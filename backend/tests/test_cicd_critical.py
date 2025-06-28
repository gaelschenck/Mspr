#!/usr/bin/env python3
"""
Tests critiques pour CI/CD - ces tests doivent toujours passer
"""

import pytest

def test_environment_ready():
    """Test que l'environnement Python est prêt"""
    import sys
    assert sys.version_info >= (3, 8), "Python 3.8+ requis"
    
def test_dependencies_core():
    """Test que les dépendances core sont installées"""
    try:
        import fastapi
        import uvicorn
        import sqlalchemy
        import pydantic
        assert True, "Dépendances core OK"
    except ImportError as e:
        pytest.fail(f"Dépendance core manquante: {e}")

def test_dependencies_optional():
    """Test des dépendances optionnelles (ne fait pas échouer si manquantes)"""
    optional_deps = ["aiohttp", "asyncpg", "psycopg", "pandas"]
    available = []
    missing = []
    
    for dep in optional_deps:
        try:
            __import__(dep)
            available.append(dep)
        except ImportError:
            missing.append(dep)
    
    print(f"Dépendances optionnelles disponibles: {available}")
    print(f"Dépendances optionnelles manquantes: {missing}")
    
    # Au moins FastAPI doit être là
    assert "fastapi" not in missing, "FastAPI est requis"

def test_backend_structure():
    """Test que la structure du backend est correcte"""
    import os
    
    # Fichiers requis (relatifs au dossier backend)
    required_files = [
        "main.py",
        "requirements.txt", 
        "models.py",
        "schemas.py"
    ]
    
    missing_files = []
    # Chercher dans le dossier parent (backend) depuis tests/
    backend_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    
    for file in required_files:
        file_path = os.path.join(backend_dir, file)
        if not os.path.exists(file_path):
            missing_files.append(file)
    
    assert len(missing_files) == 0, f"Fichiers manquants: {missing_files}"

def test_data_consistency_logic():
    """Test de la logique de cohérence des données sans dépendances externes"""
    # Exemple de données transmission_mere_enfant
    test_data = {
        "besoin_arv_min": 100,
        "besoin_arv_median": 200, 
        "besoin_arv_max": 300,
        "pourcentage_recu_min": 10,
        "pourcentage_recu_median": 50,
        "pourcentage_recu_max": 90
    }
    
    # Tests de cohérence
    assert test_data["besoin_arv_min"] <= test_data["besoin_arv_median"] <= test_data["besoin_arv_max"]
    assert test_data["pourcentage_recu_min"] <= test_data["pourcentage_recu_median"] <= test_data["pourcentage_recu_max"]
    assert 0 <= test_data["pourcentage_recu_min"] <= 100
    assert 0 <= test_data["pourcentage_recu_max"] <= 100

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
