#!/usr/bin/env python3
"""
Tests des modèles SQLAlchemy
"""
import pytest
import pytest_asyncio
from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker, AsyncSession
from sqlalchemy.pool import StaticPool
import sys
import os

# Ajouter le répertoire backend au path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from models import Base, Country, IndicatorType, HealthIndicator, ETLMetadata, Utilisateur

@pytest_asyncio.fixture
async def async_session():
    """Créer une session de test en mémoire"""
    engine = create_async_engine(
        "sqlite+aiosqlite:///:memory:",
        echo=False,
        poolclass=StaticPool,
        connect_args={"check_same_thread": False},
    )
    
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    
    SessionLocal = async_sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
    session = SessionLocal()
    
    yield session
    
    await session.close()
    await engine.dispose()

class TestModels:
    """Tests des modèles de données"""
    
    @pytest.mark.asyncio
    async def test_country_model(self, async_session):
        """Test du modèle Country"""
        country = Country(
            id=1,
            name="France",
            who_region="Europe",
            iso_code="FR"
        )
        
        async_session.add(country)
        await async_session.commit()
        
        # Vérifier que l'objet a été sauvegardé
        assert country.id == 1
        assert country.name == "France"
        assert country.who_region == "Europe"
        assert country.iso_code == "FR"
    
    @pytest.mark.asyncio
    async def test_indicator_type_model(self, async_session):
        """Test du modèle IndicatorType"""
        indicator_type = IndicatorType(
            id=1,
            name="HIV Population",
            description="Number of people living with HIV",
            unit="persons"
        )
        
        async_session.add(indicator_type)
        await async_session.commit()
        
        assert indicator_type.id == 1
        assert indicator_type.name == "HIV Population"
        assert indicator_type.unit == "persons"
    
    @pytest.mark.asyncio
    async def test_health_indicator_model(self, async_session):
        """Test du modèle HealthIndicator"""
        # Créer les dépendances
        country = Country(id=1, name="France", who_region="Europe", iso_code="FR")
        indicator_type = IndicatorType(id=1, name="HIV Population", description="Test", unit="persons")
        
        async_session.add(country)
        async_session.add(indicator_type)
        await async_session.commit()
        
        # Créer l'indicateur de santé
        health_indicator = HealthIndicator(
            country_id=1,
            indicator_type_id=1,
            year=2023,
            value_type="estimated",
            value=180000,
            confidence_min=170000,
            confidence_max=190000,
            data_quality="good"
        )
        
        async_session.add(health_indicator)
        await async_session.commit()
        
        assert health_indicator.country_id == 1
        assert health_indicator.indicator_type_id == 1
        assert health_indicator.year == 2023
        assert health_indicator.value == 180000
    
    @pytest.mark.asyncio
    async def test_utilisateur_model(self, async_session):
        """Test du modèle Utilisateur"""
        user = Utilisateur(
            username="testuser",
            hashed_password="hashed_password_123",
            role="user",
            rgpd_accept=1
        )
        
        async_session.add(user)
        await async_session.commit()
        
        assert user.username == "testuser"
        assert user.role == "user"
        assert user.rgpd_accept == 1
    
    @pytest.mark.asyncio
    async def test_etl_metadata_model(self, async_session):
        """Test du modèle ETLMetadata"""
        etl_meta = ETLMetadata(
            file_name="test_file.csv",
            records_processed=1000,
            records_success=990,
            records_failed=10,
            processing_duration_seconds=45.5,
            notes="Test ETL process"
        )
        
        async_session.add(etl_meta)
        await async_session.commit()
        
        assert etl_meta.file_name == "test_file.csv"
        assert etl_meta.records_processed == 1000
        assert etl_meta.records_success == 990
        assert etl_meta.records_failed == 10

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
