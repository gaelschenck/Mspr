#!/usr/bin/env python3
"""
Configuration de base de données de test avec données réelles
"""
import os
import tempfile
import asyncio
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.pool import StaticPool
import sys

# Ajouter le répertoire backend au path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from models import Base, Country, IndicatorType, HealthIndicator, ETLMetadata, Utilisateur
from datetime import datetime

class TestDatabase:
    """Gestionnaire de base de données de test avec données réelles"""
    
    def __init__(self):
        self.engine = None
        self.session_factory = None
        self.db_file = None
    
    async def setup(self):
        """Créer la base de test avec des données"""
        # Créer un fichier SQLite temporaire
        self.db_file = tempfile.mktemp(suffix='.db')
        database_url = f"sqlite+aiosqlite:///{self.db_file}"
        
        # Créer l'engine
        self.engine = create_async_engine(
            database_url,
            echo=False,
            poolclass=StaticPool,
            connect_args={"check_same_thread": False},
        )
        
        # Créer les tables
        async with self.engine.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)
        
        # Créer la factory de sessions
        self.session_factory = async_sessionmaker(
            self.engine, class_=AsyncSession, expire_on_commit=False
        )
        
        # Insérer des données de test
        await self._populate_test_data()
    
    async def _populate_test_data(self):
        """Insérer des données de test réalistes"""
        async with self.session_factory() as session:
            # Créer des pays
            countries = [
                Country(id=1, name="France", who_region="Europe", iso_code="FR"),
                Country(id=2, name="Germany", who_region="Europe", iso_code="DE"),
                Country(id=3, name="Spain", who_region="Europe", iso_code="ES"),
                Country(id=4, name="Italy", who_region="Europe", iso_code="IT"),
                Country(id=5, name="United States", who_region="Americas", iso_code="US"),
                Country(id=6, name="Canada", who_region="Americas", iso_code="CA"),
            ]
            
            # Créer des types d'indicateurs
            indicator_types = [
                IndicatorType(id=1, name="HIV Population", description="Number of people living with HIV", unit="persons"),
                IndicatorType(id=2, name="Treatment Coverage", description="Percentage receiving treatment", unit="percentage"),
                IndicatorType(id=3, name="Prevention Programs", description="Prevention program coverage", unit="percentage"),
                IndicatorType(id=4, name="Mortality Rate", description="HIV-related mortality", unit="deaths per 100k"),
            ]
            
            # Ajouter les pays et types d'indicateurs
            for country in countries:
                session.add(country)
            for indicator_type in indicator_types:
                session.add(indicator_type)
            
            await session.commit()
            
            # Créer des indicateurs de santé (données réalistes)
            health_indicators = []
            
            # France - données sur plusieurs années
            for year in [2020, 2021, 2022, 2023]:
                health_indicators.extend([
                    HealthIndicator(
                        country_id=1, indicator_type_id=1, year=year,
                        value_type="estimated", value=180000 + year*1000,
                        confidence_min=170000 + year*1000, confidence_max=190000 + year*1000,
                        data_quality="good"
                    ),
                    HealthIndicator(
                        country_id=1, indicator_type_id=2, year=year,
                        value_type="percentage", value=85.5 + (year-2020)*0.5,
                        confidence_min=80.0 + (year-2020)*0.5, confidence_max=90.0 + (year-2020)*0.5,
                        data_quality="good"
                    ),
                ])
            
            # Germany - données similaires
            for year in [2020, 2021, 2022, 2023]:
                health_indicators.extend([
                    HealthIndicator(
                        country_id=2, indicator_type_id=1, year=year,
                        value_type="estimated", value=120000 + year*800,
                        confidence_min=115000 + year*800, confidence_max=125000 + year*800,
                        data_quality="good"
                    ),
                    HealthIndicator(
                        country_id=2, indicator_type_id=2, year=year,
                        value_type="percentage", value=88.0 + (year-2020)*0.3,
                        confidence_min=85.0 + (year-2020)*0.3, confidence_max=91.0 + (year-2020)*0.3,
                        data_quality="excellent"
                    ),
                ])
            
            # Spain, Italy, US, Canada - données variées
            countries_data = [
                (3, 95000, 82.0),  # Spain
                (4, 110000, 79.5),  # Italy
                (5, 1200000, 76.0),  # US
                (6, 62000, 83.5),  # Canada
            ]
            
            for country_id, base_population, base_coverage in countries_data:
                for year in [2020, 2021, 2022, 2023]:
                    health_indicators.extend([
                        HealthIndicator(
                            country_id=country_id, indicator_type_id=1, year=year,
                            value_type="estimated", value=base_population + year*500,
                            confidence_min=base_population*0.9 + year*500, 
                            confidence_max=base_population*1.1 + year*500,
                            data_quality="good"
                        ),
                        HealthIndicator(
                            country_id=country_id, indicator_type_id=2, year=year,
                            value_type="percentage", value=base_coverage + (year-2020)*0.4,
                            confidence_min=base_coverage-2 + (year-2020)*0.4, 
                            confidence_max=base_coverage+2 + (year-2020)*0.4,
                            data_quality="good"
                        ),
                    ])
            
            # Ajouter tous les indicateurs
            for indicator in health_indicators:
                session.add(indicator)
            
            # Créer quelques utilisateurs de test
            users = [
                Utilisateur(username="admin", hashed_password="admin_hash", role="admin", rgpd_accept=1),
                Utilisateur(username="user1", hashed_password="user_hash", role="user", rgpd_accept=1),
                Utilisateur(username="researcher", hashed_password="researcher_hash", role="researcher", rgpd_accept=1),
            ]
            
            for user in users:
                session.add(user)
            
            # Créer quelques métadonnées ETL
            etl_metadata = [
                ETLMetadata(
                    file_name="hiv_data_2023.csv",
                    records_processed=1000,
                    records_success=980,
                    records_failed=20,
                    processing_duration_seconds=45.5,
                    notes="Successful import of 2023 data"
                ),
                ETLMetadata(
                    file_name="treatment_data_2023.csv",
                    records_processed=500,
                    records_success=495,
                    records_failed=5,
                    processing_duration_seconds=23.2,
                    notes="Minor data quality issues resolved"
                ),
            ]
            
            for etl in etl_metadata:
                session.add(etl)
            
            await session.commit()
    
    async def get_session(self):
        """Obtenir une session de base de données"""
        return self.session_factory()
    
    async def cleanup(self):
        """Nettoyer la base de test"""
        if self.engine:
            await self.engine.dispose()
        if self.db_file and os.path.exists(self.db_file):
            os.unlink(self.db_file)

# Instance globale pour les tests
test_db = TestDatabase()

async def setup_test_database():
    """Fonction helper pour initialiser la base de test"""
    await test_db.setup()
    return test_db

async def get_test_session():
    """Fonction helper pour obtenir une session de test"""
    return await test_db.get_session()

async def cleanup_test_database():
    """Fonction helper pour nettoyer la base de test"""
    await test_db.cleanup()

if __name__ == "__main__":
    async def test_setup():
        """Test de la configuration de base"""
        await setup_test_database()
        
        session = await get_test_session()
        
        # Tester quelques requêtes
        from sqlalchemy import select, func
        
        # Compter les pays
        result = await session.execute(select(func.count(Country.id)))
        country_count = result.scalar()
        print(f"Nombre de pays: {country_count}")
        
        # Compter les indicateurs
        result = await session.execute(select(func.count(HealthIndicator.id)))
        indicator_count = result.scalar()
        print(f"Nombre d'indicateurs: {indicator_count}")
        
        await session.close()
        await cleanup_test_database()
        print("Base de test créée et nettoyée avec succès!")
    
    asyncio.run(test_setup())
