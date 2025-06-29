#!/usr/bin/env python3
"""
Configuration commune pour les tests - Fixtures partagées
"""
import pytest
import asyncio
import os
import sys
from unittest.mock import patch

# Ajouter le répertoire backend au path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from tests.test_database_setup import TestDatabase, setup_test_database, cleanup_test_database
from database import get_db

@pytest.fixture(scope="session")
def event_loop():
    """Créer une boucle d'événements pour la session de test"""
    loop = asyncio.get_event_loop_policy().new_event_loop()
    yield loop
    loop.close()

@pytest.fixture(scope="session")
async def test_database():
    """
    Fixture de base de données de test pour toute la session
    Crée une base SQLite avec des données réalistes
    """
    # Configurer la base de test
    test_db = TestDatabase()
    await test_db.setup()
    
    yield test_db
    
    # Nettoyer après les tests
    await test_db.cleanup()

@pytest.fixture
async def test_db_session(test_database):
    """
    Fixture pour obtenir une session de base de données de test
    """
    session = await test_database.get_session()
    yield session
    await session.close()

@pytest.fixture
async def override_get_db(test_database):
    """
    Fixture pour surcharger la dépendance get_db dans FastAPI
    """
    async def _get_test_db():
        session = await test_database.get_session()
        try:
            yield session
        finally:
            await session.close()
    
    return _get_test_db

@pytest.fixture(autouse=True)
async def mock_database_dependency(test_database, monkeypatch):
    """
    Fixture automatique qui remplace la dépendance de base de données
    pour tous les tests utilisant l'application FastAPI
    """
    async def _get_test_db():
        session = await test_database.get_session()
        try:
            yield session
        finally:
            await session.close()
    
    # Importer l'app et remplacer la dépendance
    from main import app
    app.dependency_overrides[get_db] = _get_test_db
    
    yield
    
    # Nettoyer les overrides après le test
    app.dependency_overrides.clear()

@pytest.fixture
def mock_environment_variables():
    """
    Fixture pour mocker les variables d'environnement pour les tests
    """
    env_vars = {
        'TEST_MODE': 'true',
        'DATABASE_URL': 'sqlite+aiosqlite:///test.db',
        'SECRET_KEY': 'test-secret-key-for-testing-only'
    }
    
    with patch.dict(os.environ, env_vars):
        yield env_vars
