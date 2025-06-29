#!/usr/bin/env python3
"""
Tests d'intégration avec la base de données
"""
import pytest
import asyncio
import sys
import os
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from sqlalchemy.pool import StaticPool

# Ajouter le répertoire backend au path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from models import Base, Country, IndicatorType, HealthIndicator, ETLMetadata, Utilisateur
import models

# Configuration pour les tests avec SQLite en mémoire
TEST_DATABASE_URL = "sqlite+aiosqlite:///:memory:"

class TestDatabaseIntegration:
    """Tests d'intégration avec la base de données"""
    
    async def get_test_session(self):
        """Créer une session de test"""
        engine = create_async_engine(
            TEST_DATABASE_URL,
            echo=False,
            poolclass=StaticPool,
            connect_args={"check_same_thread": False},
        )
        
        # Créer les tables
        async with engine.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)
        
        # Créer une session
        async_sessionmaker_instance = async_sessionmaker(
            engine, class_=AsyncSession, expire_on_commit=False
        )
        
        session = async_sessionmaker_instance()
        return session, engine
    
    @pytest.mark.asyncio
    async def test_create_country_with_defaults(self):
        """Test de création d'un pays avec les valeurs par défaut"""
        session, engine = await self.get_test_session()
        
        try:
            country = Country(name="Test Country")
            session.add(country)
            await session.commit()
            await session.refresh(country)
            
            assert country.id is not None
            assert country.name == "Test Country"
            assert country.who_region is None
            assert country.iso_code is None
            assert country.created_at is not None
            assert country.updated_at is not None
        finally:
            await session.close()
            await engine.dispose()
    
    @pytest.mark.asyncio
    async def test_create_indicator_type(self):
        """Test de création d'un type d'indicateur"""
        session, engine = await self.get_test_session()
        
        try:
            indicator_type = IndicatorType(
                name="HIV Population",
                description="Number of people living with HIV",
                unit="persons"
            )
            session.add(indicator_type)
            await session.commit()
            await session.refresh(indicator_type)
            
            assert indicator_type.id is not None
            assert indicator_type.name == "HIV Population"
            assert indicator_type.description == "Number of people living with HIV"
            assert indicator_type.unit == "persons"
            assert indicator_type.created_at is not None
        finally:
            await session.close()
            await engine.dispose()
    
    @pytest.mark.asyncio
    async def test_create_health_indicator_with_defaults(self):
        """Test de création d'un indicateur de santé avec valeurs par défaut"""
        session, engine = await self.get_test_session()
        
        try:
            # D'abord créer les entités liées
            country = Country(name="France")
            indicator_type = IndicatorType(name="HIV Population")
            
            session.add(country)
            session.add(indicator_type)
            await session.commit()
            await session.refresh(country)
            await session.refresh(indicator_type)
            
            # Créer l'indicateur de santé
            health_indicator = HealthIndicator(
                country_id=country.id,
                indicator_type_id=indicator_type.id,
                value_type="estimated"
            )
            session.add(health_indicator)
            await session.commit()
            await session.refresh(health_indicator)
            
            assert health_indicator.id is not None
            assert health_indicator.country_id == country.id
            assert health_indicator.indicator_type_id == indicator_type.id
            assert health_indicator.value_type == "estimated"
            assert health_indicator.year == 2023  # Valeur par défaut
            assert health_indicator.data_quality == "good"  # Valeur par défaut
            assert health_indicator.created_at is not None
            assert health_indicator.updated_at is not None
        finally:
            await session.close()
            await engine.dispose()
    
    @pytest.mark.asyncio
    async def test_relationships(self):
        """Test des relations entre les modèles"""
        session, engine = await self.get_test_session()
        
        try:
            # Créer les entités
            country = Country(name="Germany", who_region="Europe")
            indicator_type = IndicatorType(name="Treatment Coverage")
            
            session.add(country)
            session.add(indicator_type)
            await session.commit()
            await session.refresh(country)
            await session.refresh(indicator_type)
            
            # Créer un indicateur de santé
            health_indicator = HealthIndicator(
                country_id=country.id,
                indicator_type_id=indicator_type.id,
                value_type="percentage",
                value=85.5,
                year=2022
            )
            session.add(health_indicator)
            await session.commit()
            await session.refresh(health_indicator)
            
            # Tester les relations - charger explicitement les objets liés
            # Pour éviter les problèmes de lazy loading async
            from sqlalchemy import select
            from sqlalchemy.orm import selectinload
            
            # Requête pour récupérer l'indicateur avec ses relations
            result = await session.execute(
                select(HealthIndicator)
                .options(selectinload(HealthIndicator.country))
                .options(selectinload(HealthIndicator.indicator_type))
                .where(HealthIndicator.id == health_indicator.id)
            )
            health_indicator_with_relations = result.scalars().first()
            
            assert health_indicator_with_relations.country.name == "Germany"
            assert health_indicator_with_relations.indicator_type.name == "Treatment Coverage"
            
            # Test des collections back_populates
            country_result = await session.execute(
                select(Country)
                .options(selectinload(Country.health_indicators))
                .where(Country.id == country.id)
            )
            country_with_indicators = country_result.scalars().first()
            
            indicator_result = await session.execute(
                select(IndicatorType)
                .options(selectinload(IndicatorType.health_indicators))
                .where(IndicatorType.id == indicator_type.id)
            )
            indicator_with_health = indicator_result.scalars().first()
            
            assert len(country_with_indicators.health_indicators) >= 1
            assert len(indicator_with_health.health_indicators) >= 1
        finally:
            await session.close()
            await engine.dispose()
    
    @pytest.mark.asyncio
    async def test_create_user(self):
        """Test de création d'un utilisateur"""
        session, engine = await self.get_test_session()
        
        try:
            user = Utilisateur(
                username="testuser",
                hashed_password="hashed_password_123",
                role="user",
                rgpd_accept=1
            )
            session.add(user)
            await session.commit()
            await session.refresh(user)
            
            assert user.id is not None
            assert user.username == "testuser"
            assert user.hashed_password == "hashed_password_123"
            assert user.role == "user"
            assert user.rgpd_accept == 1
        finally:
            await session.close()
            await engine.dispose()
    
    @pytest.mark.asyncio
    async def test_etl_metadata(self):
        """Test de création de métadonnées ETL"""
        session, engine = await self.get_test_session()
        
        try:
            etl_data = ETLMetadata(
                file_name="test_data.csv",
                records_processed=1000,
                records_success=950,
                records_failed=50,
                processing_duration_seconds=45.5,
                notes="Test processing completed"
            )
            session.add(etl_data)
            await session.commit()
            await session.refresh(etl_data)
            
            assert etl_data.id is not None
            assert etl_data.file_name == "test_data.csv"
            assert etl_data.records_processed == 1000
            assert etl_data.records_success == 950
            assert etl_data.records_failed == 50
            assert float(etl_data.processing_duration_seconds) == 45.5
            assert etl_data.notes == "Test processing completed"
            assert etl_data.processing_date is not None
        finally:
            await session.close()
            await engine.dispose()
    
    @pytest.mark.asyncio
    async def test_unique_constraints(self):
        """Test des contraintes d'unicité"""
        session, engine = await self.get_test_session()
        
        try:
            # Créer un premier pays
            country1 = Country(name="Spain")
            session.add(country1)
            await session.commit()
            
            # Tenter de créer un second pays avec le même nom
            country2 = Country(name="Spain")
            session.add(country2)
            
            with pytest.raises(Exception):  # Violation de contrainte unique
                await session.commit()
        finally:
            await session.close()
            await engine.dispose()

if __name__ == "__main__":
    pytest.main([__file__, "-v"])
