-- Schéma SQL pour FR
-- Généré automatiquement le 2025-06-28 23:42:04
-- Base de données source: c:\Users\gaels\OneDrive\Documents\ECOLE-EPSI\Mspr\SourceData\NewETL\..\..\backend\normalized_health_data.db

-- Configuration pour PostgreSQL
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Suppression des tables existantes (avec CASCADE pour gérer les dépendances)
DROP TABLE IF EXISTS health_indicators CASCADE;
DROP TABLE IF EXISTS countries CASCADE;
DROP TABLE IF EXISTS indicator_types CASCADE;
DROP TABLE IF EXISTS etl_metadata CASCADE;
DROP TABLE IF EXISTS utilisateur CASCADE;

CREATE TABLE countries (
            id SERIAL PRIMARY KEY,
            name VARCHAR(255) NOT NULL UNIQUE,
            who_region VARCHAR(100),
            iso_code VARCHAR(3),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

CREATE TABLE etl_metadata (
            id SERIAL PRIMARY KEY,
            file_name VARCHAR(255) NOT NULL,
            processing_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            records_processed INTEGER,
            records_success INTEGER,
            records_failed INTEGER,
            processing_duration_seconds DECIMAL(10,2),
            notes TEXT
        );

CREATE TABLE health_indicators (
            id SERIAL PRIMARY KEY,
            country_id INTEGER NOT NULL,
            indicator_type_id INTEGER NOT NULL,
            year INTEGER DEFAULT 2023,
            value_type VARCHAR(100) NOT NULL, -- 'received', 'needed', 'percentage', etc.
            value NUMERIC(15,2),
            value_text VARCHAR(255), -- pour les valeurs comme "No data"
            confidence_min NUMERIC(15,2),
            confidence_max NUMERIC(15,2),
            confidence_median NUMERIC(15,2),
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
            id SERIAL PRIMARY KEY,
            name VARCHAR(255) NOT NULL UNIQUE,
            description TEXT,
            unit VARCHAR(100),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

-- Table utilisateur spécifique au pays
CREATE TABLE utilisateur (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'user',
    rgpd_accept INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_countries_region ON countries(who_region);
CREATE INDEX idx_health_indicators_country ON health_indicators(country_id);
CREATE INDEX idx_health_indicators_type ON health_indicators(indicator_type_id);
CREATE INDEX idx_health_indicators_year ON health_indicators(year);

-- Index pour la table utilisateur
CREATE INDEX idx_utilisateur_username ON utilisateur(username);
CREATE INDEX idx_utilisateur_role ON utilisateur(role);

-- Données utilisateur pour FR
INSERT INTO utilisateur (id, username, hashed_password, role, rgpd_accept) VALUES (1, 'adminfr', '$2b$12$lN4GPs6jcnuhJHfYSIuTZOvksHo1WQjUZ2sn8XBh4M9WslOhZ18qW', 'admin', 0);
INSERT INTO utilisateur (id, username, hashed_password, role, rgpd_accept) VALUES (2, 'userfr', '$2b$12$3bIXd2nTT8zvU80IMEKlg.QvMmFdcxc/.2aM3WT0wPauN2e9tl1wu', 'user', 0);

-- Réinitialise la séquence de l'ID utilisateur
SELECT setval('utilisateur_id_seq', (SELECT MAX(id) FROM utilisateur));

-- Fin du schéma pour FR