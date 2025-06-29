-- Schéma de base de données généré automatiquement
-- Date de génération: 2025-06-28 23:42:04
-- Base de données source: c:\Users\gaels\OneDrive\Documents\ECOLE-EPSI\Mspr\SourceData\NewETL\..\..\backend\normalized_health_data.db

-- Désactive les contraintes de clés étrangères temporairement
PRAGMA foreign_keys = OFF;

CREATE TABLE countries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(255) NOT NULL UNIQUE,
            who_region VARCHAR(100),
            iso_code VARCHAR(3),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

CREATE TABLE etl_metadata (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            file_name VARCHAR(255) NOT NULL,
            processing_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            records_processed INTEGER,
            records_success INTEGER,
            records_failed INTEGER,
            processing_duration_seconds DECIMAL(10,2),
            notes TEXT
        );

CREATE TABLE health_indicators (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country_id INTEGER NOT NULL,
            indicator_type_id INTEGER NOT NULL,
            year INTEGER DEFAULT 2023,
            value_type VARCHAR(100) NOT NULL, -- 'received', 'needed', 'percentage', etc.
            value DECIMAL(15,2),
            value_text VARCHAR(255), -- pour les valeurs comme "No data"
            confidence_min DECIMAL(15,2),
            confidence_max DECIMAL(15,2),
            confidence_median DECIMAL(15,2),
            data_quality VARCHAR(50) DEFAULT 'good',
            source_file VARCHAR(255),
            raw_value_text TEXT, -- stocke la valeur brute pour traçabilité
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (country_id) REFERENCES countries(id),
            FOREIGN KEY (indicator_type_id) REFERENCES indicator_types(id),
            UNIQUE(country_id, indicator_type_id, value_type, year)
        );

CREATE TABLE indicator_types (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(255) NOT NULL UNIQUE,
            description TEXT,
            unit VARCHAR(100),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

CREATE INDEX idx_countries_region ON countries(who_region);

CREATE INDEX idx_health_indicators_country ON health_indicators(country_id);

CREATE INDEX idx_health_indicators_type ON health_indicators(indicator_type_id);

CREATE INDEX idx_health_indicators_year ON health_indicators(year);

-- Réactive les contraintes de clés étrangères
PRAGMA foreign_keys = ON;
