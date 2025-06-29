-- Schéma SQL pour US
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

CREATE TABLE indicator_types (
            id SERIAL PRIMARY KEY,
            name VARCHAR(255) NOT NULL UNIQUE,
            description TEXT,
            unit VARCHAR(100),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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

-- Données utilisateur pour US
INSERT INTO utilisateur (id, username, hashed_password, role, rgpd_accept) VALUES (1, 'adminus', '$2b$12$11T77aHFYoAbk0bsH4jWxO6XYYUobYdayWRhbg0iKkRTZtvE86IXy', 'admin', 0);
INSERT INTO utilisateur (id, username, hashed_password, role, rgpd_accept) VALUES (2, 'userus', '$2b$12$0D55L95jWU./LJTg5HnLj.dit2Aw4mODM7YuWnxHg1ZH/goBVWbQi', 'user', 0);

-- Réinitialise la séquence de l'ID utilisateur
SELECT setval('utilisateur_id_seq', (SELECT MAX(id) FROM utilisateur));

-- Fin du schéma pour US

-- === DONNÉES IMPORTÉES DEPUIS NORMALIZED_HEALTH_DATA.DB ===
-- Généré automatiquement le 2025-06-29 15:55:29

-- Insertion des types d'indicateurs
INSERT INTO indicator_types (id, name, description, unit) VALUES (1, 'Prevention of Mother-to-Child Transmission', NULL, NULL);
INSERT INTO indicator_types (id, name, description, unit) VALUES (2, 'ART Coverage', NULL, NULL);
INSERT INTO indicator_types (id, name, description, unit) VALUES (3, 'People Living with HIV', NULL, NULL);
INSERT INTO indicator_types (id, name, description, unit) VALUES (4, 'HIV-related Deaths', NULL, NULL);
INSERT INTO indicator_types (id, name, description, unit) VALUES (5, 'HIV Cases Adults 15-49', NULL, NULL);
INSERT INTO indicator_types (id, name, description, unit) VALUES (6, 'ART Pediatric Coverage', NULL, NULL);

-- Insertion des pays
INSERT INTO countries (id, name, who_region, iso_code) VALUES (1, 'Afghanistan', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (2, 'Albania', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (3, 'Algeria', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (4, 'Angola', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (5, 'Argentina', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (6, 'Armenia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (7, 'Australia', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (8, 'Austria', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (9, 'Azerbaijan', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (10, 'Bahamas', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (11, 'Bahrain', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (12, 'Bangladesh', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (13, 'Barbados', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (14, 'Belarus', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (15, 'Belgium', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (16, 'Belize', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (17, 'Benin', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (18, 'Bhutan', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (19, 'Bolivia', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (20, 'Bosnia and Herzegovina', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (21, 'Botswana', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (22, 'Brazil', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (23, 'Brunei Darussalam', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (24, 'Bulgaria', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (25, 'Burkina Faso', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (26, 'Burundi', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (27, 'Cabo Verde', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (28, 'Cambodia', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (29, 'Cameroon', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (30, 'Canada', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (31, 'Central African Republic', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (32, 'Chad', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (33, 'Chile', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (34, 'China', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (35, 'Colombia', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (36, 'Comoros', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (37, 'Congo', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (38, 'Costa Rica', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (39, 'Côte d''Ivoire', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (40, 'Croatia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (41, 'Cuba', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (42, 'Cyprus', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (43, 'Czechia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (44, 'North Korea', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (45, 'DR Congo', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (46, 'Denmark', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (47, 'Djibouti', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (48, 'Dominican Republic', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (49, 'Ecuador', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (50, 'Egypt', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (51, 'El Salvador', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (52, 'Equatorial Guinea', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (53, 'Eritrea', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (54, 'Estonia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (55, 'Eswatini', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (56, 'Ethiopia', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (57, 'Fiji', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (58, 'Finland', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (59, 'France', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (60, 'Gabon', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (61, 'Gambia', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (62, 'Georgia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (63, 'Germany', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (64, 'Ghana', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (65, 'Greece', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (66, 'Guatemala', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (67, 'Guinea', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (68, 'Guinea-Bissau', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (69, 'Guyana', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (70, 'Haiti', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (71, 'Honduras', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (72, 'Hungary', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (73, 'Iceland', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (74, 'India', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (75, 'Indonesia', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (76, 'Iran', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (77, 'Ireland', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (78, 'Israel', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (79, 'Italy', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (80, 'Jamaica', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (81, 'Japan', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (82, 'Jordan', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (83, 'Kazakhstan', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (84, 'Kenya', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (85, 'Kuwait', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (86, 'Kyrgyzstan', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (87, 'Laos', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (88, 'Latvia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (89, 'Lebanon', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (90, 'Lesotho', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (91, 'Liberia', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (92, 'Libya', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (93, 'Lithuania', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (94, 'Luxembourg', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (95, 'Madagascar', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (96, 'Malawi', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (97, 'Malaysia', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (98, 'Maldives', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (99, 'Mali', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (100, 'Malta', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (101, 'Mauritania', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (102, 'Mauritius', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (103, 'Mexico', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (104, 'Mongolia', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (105, 'Montenegro', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (106, 'Morocco', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (107, 'Mozambique', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (108, 'Myanmar', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (109, 'Namibia', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (110, 'Nepal', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (111, 'Netherlands', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (112, 'New Zealand', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (113, 'Nicaragua', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (114, 'Niger', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (115, 'Nigeria', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (116, 'Norway', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (117, 'Oman', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (118, 'Pakistan', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (119, 'Panama', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (120, 'Papua New Guinea', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (121, 'Paraguay', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (122, 'Peru', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (123, 'Philippines', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (124, 'Poland', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (125, 'Portugal', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (126, 'Qatar', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (127, 'South Korea', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (128, 'Moldova', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (129, 'North Macedonia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (130, 'Romania', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (131, 'Russia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (132, 'Rwanda', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (133, 'Saudi Arabia', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (134, 'Senegal', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (135, 'Serbia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (136, 'Sierra Leone', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (137, 'Singapore', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (138, 'Slovakia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (139, 'Slovenia', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (140, 'Somalia', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (141, 'South Africa', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (142, 'South Sudan', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (143, 'Spain', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (144, 'Sri Lanka', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (145, 'Sudan', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (146, 'Suriname', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (147, 'Sweden', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (148, 'Switzerland', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (149, 'Syria', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (150, 'Tajikistan', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (151, 'Thailand', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (152, 'Timor-Leste', 'South-East Asia', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (153, 'Togo', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (154, 'Trinidad and Tobago', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (155, 'Tunisia', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (156, 'Turkey', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (157, 'Turkmenistan', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (158, 'Uganda', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (159, 'Ukraine', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (160, 'United Arab Emirates', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (161, 'United Kingdom', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (162, 'Tanzania', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (163, 'United States', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (164, 'Uruguay', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (165, 'Uzbekistan', 'Europe', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (166, 'Venezuela', 'Americas', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (167, 'Viet Nam', 'Western Pacific', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (168, 'Yemen', 'Eastern Mediterranean', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (169, 'Zambia', 'Africa', NULL);
INSERT INTO countries (id, name, who_region, iso_code) VALUES (170, 'Zimbabwe', 'Africa', NULL);

-- Insertion de TOUS les indicateurs de santé (données identiques pour toutes les régions)
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3401, 1, 1, 2023, 'received_antiretrovirals', 20, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3402, 1, 1, 2023, 'needing_antiretrovirals', 200, NULL, 100, 500, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3403, 1, 1, 2023, 'percentage_received', 11, NULL, 7, 18, 11, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3407, 3, 1, 2023, 'received_antiretrovirals', 320, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3408, 3, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3409, 3, 1, 2023, 'percentage_received', 74, NULL, 69, 78, 74, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3410, 4, 1, 2023, 'received_antiretrovirals', 9600, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3411, 4, 1, 2023, 'needing_antiretrovirals', 25000, NULL, 19000, 32000, 25000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3412, 4, 1, 2023, 'percentage_received', 38, NULL, 29, 48, 38, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3413, 5, 1, 2023, 'received_antiretrovirals', 1800, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3414, 5, 1, 2023, 'needing_antiretrovirals', 1800, NULL, 1600, 2000, 1800, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3415, 5, 1, 2023, 'percentage_received', 95, NULL, 85, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3416, 6, 1, 2023, 'received_antiretrovirals', 50, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3420, 7, 1, 2023, 'needing_antiretrovirals', 100, NULL, 100, 100, 100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3428, 10, 1, 2023, 'received_antiretrovirals', 50, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3429, 10, 1, 2023, 'needing_antiretrovirals', 100, NULL, 100, 200, 100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3430, 10, 1, 2023, 'percentage_received', 58, NULL, 51, 65, 58, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3431, 11, 1, 2023, 'received_antiretrovirals', 0, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3434, 12, 1, 2023, 'received_antiretrovirals', 40, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3435, 12, 1, 2023, 'needing_antiretrovirals', 200, NULL, 200, 200, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3436, 12, 1, 2023, 'percentage_received', 28, NULL, 24, 33, 28, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3437, 13, 1, 2023, 'received_antiretrovirals', 20, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3440, 14, 1, 2023, 'received_antiretrovirals', 230, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3441, 14, 1, 2023, 'needing_antiretrovirals', 500, NULL, 200, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3442, 14, 1, 2023, 'percentage_received', 90, NULL, 67, 95, 90, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3446, 16, 1, 2023, 'received_antiretrovirals', 40, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3447, 16, 1, 2023, 'needing_antiretrovirals', 100, NULL, 100, 200, 100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3448, 16, 1, 2023, 'percentage_received', 44, NULL, 39, 49, 44, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3449, 17, 1, 2023, 'received_antiretrovirals', 4600, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3450, 17, 1, 2023, 'needing_antiretrovirals', 2600, NULL, 1600, 4300, 2600, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3451, 17, 1, 2023, 'percentage_received', 95, NULL, 95, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3455, 19, 1, 2023, 'received_antiretrovirals', 350, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3456, 19, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3457, 19, 1, 2023, 'percentage_received', 95, NULL, 95, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3461, 21, 1, 2023, 'received_antiretrovirals', 12400, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3462, 21, 1, 2023, 'needing_antiretrovirals', 13000, NULL, 10000, 14000, 13000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3463, 21, 1, 2023, 'percentage_received', 95, NULL, 77, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3467, 23, 1, 2023, 'received_antiretrovirals', 0, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3473, 25, 1, 2023, 'received_antiretrovirals', 4700, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3474, 25, 1, 2023, 'needing_antiretrovirals', 4900, NULL, 3600, 6100, 4900, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3475, 25, 1, 2023, 'percentage_received', 95, NULL, 71, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3476, 26, 1, 2023, 'received_antiretrovirals', 4000, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3477, 26, 1, 2023, 'needing_antiretrovirals', 5000, NULL, 3800, 6000, 5000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3478, 26, 1, 2023, 'percentage_received', 80, NULL, 61, 95, 80, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3482, 28, 1, 2023, 'received_antiretrovirals', 620, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3483, 28, 1, 2023, 'needing_antiretrovirals', 730, NULL, 600, 850, 730, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3484, 28, 1, 2023, 'percentage_received', 85, NULL, 71, 95, 85, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3485, 29, 1, 2023, 'received_antiretrovirals', 21700, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3486, 29, 1, 2023, 'needing_antiretrovirals', 27000, NULL, 21000, 32000, 27000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3487, 29, 1, 2023, 'percentage_received', 80, NULL, 61, 94, 80, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3491, 31, 1, 2023, 'received_antiretrovirals', 3200, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3492, 31, 1, 2023, 'needing_antiretrovirals', 4500, NULL, 3300, 5800, 4500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3493, 31, 1, 2023, 'percentage_received', 71, NULL, 52, 91, 71, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3494, 32, 1, 2023, 'received_antiretrovirals', 5600, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3495, 32, 1, 2023, 'needing_antiretrovirals', 10000, NULL, 7200, 13000, 10000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3496, 32, 1, 2023, 'percentage_received', 56, NULL, 40, 72, 56, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3497, 33, 1, 2023, 'received_antiretrovirals', 370, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3498, 33, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3499, 33, 1, 2023, 'percentage_received', 95, NULL, 95, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3503, 35, 1, 2023, 'received_antiretrovirals', 490, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3504, 35, 1, 2023, 'needing_antiretrovirals', 2300, NULL, 1900, 2700, 2300, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3505, 35, 1, 2023, 'percentage_received', 21, NULL, 17, 25, 21, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3506, 36, 1, 2023, 'received_antiretrovirals', 0, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3509, 37, 1, 2023, 'received_antiretrovirals', 1000, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3510, 37, 1, 2023, 'needing_antiretrovirals', 4100, NULL, 2800, 5800, 4100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3511, 37, 1, 2023, 'percentage_received', 25, NULL, 17, 36, 25, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3512, 38, 1, 2023, 'received_antiretrovirals', 40, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3515, 39, 1, 2023, 'received_antiretrovirals', 16500, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3516, 39, 1, 2023, 'needing_antiretrovirals', 18000, NULL, 13000, 24000, 18000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3517, 39, 1, 2023, 'percentage_received', 90, NULL, 65, 95, 90, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3521, 41, 1, 2023, 'received_antiretrovirals', 180, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3522, 41, 1, 2023, 'needing_antiretrovirals', 200, NULL, 200, 200, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3523, 41, 1, 2023, 'percentage_received', 95, NULL, 86, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3527, 43, 1, 2023, 'received_antiretrovirals', 10, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3533, 45, 1, 2023, 'received_antiretrovirals', 11400, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3534, 45, 1, 2023, 'needing_antiretrovirals', 26000, NULL, 20000, 31000, 26000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3535, 45, 1, 2023, 'percentage_received', 44, NULL, 33, 52, 44, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3539, 47, 1, 2023, 'received_antiretrovirals', 60, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3540, 47, 1, 2023, 'needing_antiretrovirals', 500, NULL, 200, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3541, 47, 1, 2023, 'percentage_received', 30, NULL, 22, 39, 30, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3542, 48, 1, 2023, 'received_antiretrovirals', 770, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3543, 48, 1, 2023, 'needing_antiretrovirals', 910, NULL, 690, 1200, 910, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3544, 48, 1, 2023, 'percentage_received', 84, NULL, 64, 95, 84, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3545, 49, 1, 2023, 'received_antiretrovirals', 370, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3546, 49, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 620, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3547, 49, 1, 2023, 'percentage_received', 95, NULL, 68, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3548, 50, 1, 2023, 'received_antiretrovirals', 60, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3549, 50, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3550, 50, 1, 2023, 'percentage_received', 16, NULL, 15, 18, 16, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3551, 51, 1, 2023, 'received_antiretrovirals', 110, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3552, 51, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3553, 51, 1, 2023, 'percentage_received', 40, NULL, 33, 46, 40, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3554, 52, 1, 2023, 'received_antiretrovirals', 1300, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3555, 52, 1, 2023, 'needing_antiretrovirals', 2600, NULL, 1800, 3500, 2600, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3556, 52, 1, 2023, 'percentage_received', 50, NULL, 35, 68, 50, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3557, 53, 1, 2023, 'received_antiretrovirals', 230, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3558, 53, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 690, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3559, 53, 1, 2023, 'percentage_received', 48, NULL, 34, 69, 48, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3563, 55, 1, 2023, 'received_antiretrovirals', 8600, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3564, 55, 1, 2023, 'needing_antiretrovirals', 11000, NULL, 9000, 12000, 11000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3565, 55, 1, 2023, 'percentage_received', 79, NULL, 66, 89, 79, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3566, 56, 1, 2023, 'received_antiretrovirals', 18400, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3567, 56, 1, 2023, 'needing_antiretrovirals', 20000, NULL, 14000, 28000, 20000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3568, 56, 1, 2023, 'percentage_received', 92, NULL, 63, 95, 92, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3576, 59, 1, 2023, 'needing_antiretrovirals', 1200, NULL, 1100, 1300, 1200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3578, 60, 1, 2023, 'received_antiretrovirals', 1900, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3579, 60, 1, 2023, 'needing_antiretrovirals', 2700, NULL, 1900, 3600, 2700, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3580, 60, 1, 2023, 'percentage_received', 72, NULL, 52, 95, 72, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3581, 61, 1, 2023, 'received_antiretrovirals', 700, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3582, 61, 1, 2023, 'needing_antiretrovirals', 1000, NULL, 820, 1300, 1000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3583, 61, 1, 2023, 'percentage_received', 68, NULL, 54, 86, 68, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3588, 63, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3590, 64, 1, 2023, 'received_antiretrovirals', 13000, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3591, 64, 1, 2023, 'needing_antiretrovirals', 16000, NULL, 12000, 21000, 16000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3592, 64, 1, 2023, 'percentage_received', 79, NULL, 58, 95, 79, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3596, 66, 1, 2023, 'received_antiretrovirals', 270, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3597, 66, 1, 2023, 'needing_antiretrovirals', 790, NULL, 720, 870, 790, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3598, 66, 1, 2023, 'percentage_received', 34, NULL, 31, 38, 34, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3599, 67, 1, 2023, 'received_antiretrovirals', 3300, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3600, 67, 1, 2023, 'needing_antiretrovirals', 5100, NULL, 3800, 6600, 5100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3601, 67, 1, 2023, 'percentage_received', 65, NULL, 48, 84, 65, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3602, 68, 1, 2023, 'received_antiretrovirals', 1000, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3603, 68, 1, 2023, 'needing_antiretrovirals', 2100, NULL, 1700, 2500, 2100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3604, 68, 1, 2023, 'percentage_received', 48, NULL, 38, 58, 48, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3605, 69, 1, 2023, 'received_antiretrovirals', 160, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3606, 69, 1, 2023, 'needing_antiretrovirals', 200, NULL, 200, 500, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3607, 69, 1, 2023, 'percentage_received', 89, NULL, 67, 95, 89, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3608, 70, 1, 2023, 'received_antiretrovirals', 4900, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3609, 70, 1, 2023, 'needing_antiretrovirals', 5900, NULL, 4700, 6800, 5900, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3610, 70, 1, 2023, 'percentage_received', 83, NULL, 67, 95, 83, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3611, 71, 1, 2023, 'received_antiretrovirals', 200, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3612, 71, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3613, 71, 1, 2023, 'percentage_received', 59, NULL, 48, 72, 59, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3620, 74, 1, 2023, 'received_antiretrovirals', 13200, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3623, 75, 1, 2023, 'received_antiretrovirals', 1800, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3624, 75, 1, 2023, 'needing_antiretrovirals', 12000, NULL, 10000, 14000, 12000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3625, 75, 1, 2023, 'percentage_received', 15, NULL, 13, 18, 15, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3626, 76, 1, 2023, 'received_antiretrovirals', 310, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3627, 76, 1, 2023, 'needing_antiretrovirals', 500, NULL, 200, 840, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3628, 76, 1, 2023, 'percentage_received', 81, NULL, 41, 95, 81, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3630, 77, 1, 2023, 'needing_antiretrovirals', 100, NULL, 100, 100, 100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3633, 78, 1, 2023, 'needing_antiretrovirals', 100, NULL, 100, 100, 100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3636, 79, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3638, 80, 1, 2023, 'received_antiretrovirals', 400, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3639, 80, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3640, 80, 1, 2023, 'percentage_received', 95, NULL, 95, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3647, 83, 1, 2023, 'received_antiretrovirals', 360, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3648, 83, 1, 2023, 'needing_antiretrovirals', 610, NULL, 550, 660, 610, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3649, 83, 1, 2023, 'percentage_received', 59, NULL, 54, 65, 59, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3650, 84, 1, 2023, 'received_antiretrovirals', 57500, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3651, 84, 1, 2023, 'needing_antiretrovirals', 63000, NULL, 49000, 80000, 63000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3652, 84, 1, 2023, 'percentage_received', 91, NULL, 70, 95, 91, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3653, 85, 1, 2023, 'received_antiretrovirals', 0, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3656, 86, 1, 2023, 'received_antiretrovirals', 130, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3657, 86, 1, 2023, 'needing_antiretrovirals', 200, NULL, 200, 500, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3658, 86, 1, 2023, 'percentage_received', 88, NULL, 69, 95, 88, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3659, 87, 1, 2023, 'received_antiretrovirals', 90, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3660, 87, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3661, 87, 1, 2023, 'percentage_received', 35, NULL, 31, 41, 35, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3668, 90, 1, 2023, 'received_antiretrovirals', 8200, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3669, 90, 1, 2023, 'needing_antiretrovirals', 11000, NULL, 8200, 12000, 11000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3670, 90, 1, 2023, 'percentage_received', 77, NULL, 59, 89, 77, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3671, 91, 1, 2023, 'received_antiretrovirals', 1800, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3672, 91, 1, 2023, 'needing_antiretrovirals', 2000, NULL, 1500, 2300, 2000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3673, 91, 1, 2023, 'percentage_received', 93, NULL, 70, 95, 93, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3674, 92, 1, 2023, 'received_antiretrovirals', 60, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3675, 92, 1, 2023, 'needing_antiretrovirals', 200, NULL, 100, 200, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3676, 92, 1, 2023, 'percentage_received', 63, NULL, 56, 69, 63, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3683, 95, 1, 2023, 'received_antiretrovirals', 280, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3684, 95, 1, 2023, 'needing_antiretrovirals', 1100, NULL, 820, 1600, 1100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3685, 95, 1, 2023, 'percentage_received', 25, NULL, 19, 36, 25, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3686, 96, 1, 2023, 'received_antiretrovirals', 47100, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3687, 96, 1, 2023, 'needing_antiretrovirals', 45000, NULL, 34000, 53000, 45000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3688, 96, 1, 2023, 'percentage_received', 95, NULL, 80, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3689, 97, 1, 2023, 'received_antiretrovirals', 260, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3690, 97, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3691, 97, 1, 2023, 'percentage_received', 95, NULL, 86, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3695, 99, 1, 2023, 'received_antiretrovirals', 2400, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3696, 99, 1, 2023, 'needing_antiretrovirals', 10000, NULL, 8300, 13000, 10000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3697, 99, 1, 2023, 'percentage_received', 24, NULL, 19, 31, 24, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3701, 101, 1, 2023, 'received_antiretrovirals', 50, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3702, 101, 1, 2023, 'needing_antiretrovirals', 200, NULL, 200, 200, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3703, 101, 1, 2023, 'percentage_received', 38, NULL, 31, 47, 38, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3704, 102, 1, 2023, 'received_antiretrovirals', 110, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3705, 102, 1, 2023, 'needing_antiretrovirals', 100, NULL, 100, 100, 100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3706, 102, 1, 2023, 'percentage_received', 95, NULL, 95, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3716, 106, 1, 2023, 'received_antiretrovirals', 220, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3717, 106, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3718, 106, 1, 2023, 'percentage_received', 61, NULL, 50, 78, 61, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3719, 107, 1, 2023, 'received_antiretrovirals', 109000, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3720, 107, 1, 2023, 'needing_antiretrovirals', 110000, NULL, 78000, 140000, 110000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3721, 107, 1, 2023, 'percentage_received', 95, NULL, 73, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3722, 108, 1, 2023, 'received_antiretrovirals', 4300, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3723, 108, 1, 2023, 'needing_antiretrovirals', 5400, NULL, 4700, 6100, 5400, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3724, 108, 1, 2023, 'percentage_received', 80, NULL, 69, 89, 80, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3725, 109, 1, 2023, 'received_antiretrovirals', 12100, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3726, 109, 1, 2023, 'needing_antiretrovirals', 10000, NULL, 8200, 12000, 10000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3727, 109, 1, 2023, 'percentage_received', 95, NULL, 92, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3728, 110, 1, 2023, 'received_antiretrovirals', 150, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3729, 110, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3730, 110, 1, 2023, 'percentage_received', 51, NULL, 43, 60, 51, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3734, 112, 1, 2023, 'received_antiretrovirals', 0, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3737, 113, 1, 2023, 'received_antiretrovirals', 120, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3738, 113, 1, 2023, 'needing_antiretrovirals', 200, NULL, 200, 200, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3739, 113, 1, 2023, 'percentage_received', 90, NULL, 73, 95, 90, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3740, 114, 1, 2023, 'received_antiretrovirals', 940, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3741, 114, 1, 2023, 'needing_antiretrovirals', 1600, NULL, 1400, 2000, 1600, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3742, 114, 1, 2023, 'percentage_received', 58, NULL, 48, 70, 58, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3743, 115, 1, 2023, 'received_antiretrovirals', 43700, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3744, 115, 1, 2023, 'needing_antiretrovirals', 100000, NULL, 65000, 140000, 100000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3745, 115, 1, 2023, 'percentage_received', 44, NULL, 28, 62, 44, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3749, 117, 1, 2023, 'received_antiretrovirals', 40, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3752, 118, 1, 2023, 'received_antiretrovirals', 320, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3753, 118, 1, 2023, 'needing_antiretrovirals', 3200, NULL, 2700, 3800, 3200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3754, 118, 1, 2023, 'percentage_received', 10, NULL, 8, 12, 10, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3755, 119, 1, 2023, 'received_antiretrovirals', 190, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3756, 119, 1, 2023, 'needing_antiretrovirals', 500, NULL, 200, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3757, 119, 1, 2023, 'percentage_received', 92, NULL, 83, 95, 92, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3758, 120, 1, 2023, 'received_antiretrovirals', 960, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3759, 120, 1, 2023, 'needing_antiretrovirals', 1200, NULL, 910, 1500, 1200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3760, 120, 1, 2023, 'percentage_received', 79, NULL, 59, 95, 79, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3761, 121, 1, 2023, 'received_antiretrovirals', 250, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3762, 121, 1, 2023, 'needing_antiretrovirals', 500, NULL, 200, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3763, 121, 1, 2023, 'percentage_received', 88, NULL, 60, 95, 88, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3764, 122, 1, 2023, 'received_antiretrovirals', 930, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3765, 122, 1, 2023, 'needing_antiretrovirals', 1100, NULL, 880, 1500, 1100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3766, 122, 1, 2023, 'percentage_received', 85, NULL, 67, 95, 85, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3767, 123, 1, 2023, 'received_antiretrovirals', 70, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3768, 123, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3769, 123, 1, 2023, 'percentage_received', 18, NULL, 15, 22, 18, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3774, 125, 1, 2023, 'needing_antiretrovirals', 200, NULL, 100, 200, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3782, 128, 1, 2023, 'received_antiretrovirals', 180, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3783, 128, 1, 2023, 'needing_antiretrovirals', 500, NULL, 200, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3784, 128, 1, 2023, 'percentage_received', 73, NULL, 54, 95, 73, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3788, 130, 1, 2023, 'received_antiretrovirals', 230, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3789, 130, 1, 2023, 'needing_antiretrovirals', 200, NULL, 200, 200, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3790, 130, 1, 2023, 'percentage_received', 95, NULL, 95, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3791, 131, 1, 2023, 'received_antiretrovirals', 13600, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3794, 132, 1, 2023, 'received_antiretrovirals', 8600, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3795, 132, 1, 2023, 'needing_antiretrovirals', 8100, NULL, 6000, 9400, 8100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3796, 132, 1, 2023, 'percentage_received', 95, NULL, 79, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3797, 133, 1, 2023, 'received_antiretrovirals', 40, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3800, 134, 1, 2023, 'received_antiretrovirals', 1400, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3801, 134, 1, 2023, 'needing_antiretrovirals', 2200, NULL, 1800, 2500, 2200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3802, 134, 1, 2023, 'percentage_received', 65, NULL, 56, 75, 65, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3806, 136, 1, 2023, 'received_antiretrovirals', 4400, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3809, 137, 1, 2023, 'received_antiretrovirals', 20, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3818, 140, 1, 2023, 'received_antiretrovirals', 90, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3819, 140, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 730, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3820, 140, 1, 2023, 'percentage_received', 19, NULL, 14, 31, 19, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3821, 141, 1, 2023, 'received_antiretrovirals', 248000, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3822, 141, 1, 2023, 'needing_antiretrovirals', 290000, NULL, 210000, 350000, 290000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3823, 141, 1, 2023, 'percentage_received', 87, NULL, 63, 95, 87, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3824, 142, 1, 2023, 'received_antiretrovirals', 5500, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3825, 142, 1, 2023, 'needing_antiretrovirals', 9900, NULL, 7200, 13000, 9900, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3826, 142, 1, 2023, 'percentage_received', 56, NULL, 41, 74, 56, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3828, 143, 1, 2023, 'needing_antiretrovirals', 500, NULL, 200, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3830, 144, 1, 2023, 'received_antiretrovirals', 20, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3833, 145, 1, 2023, 'received_antiretrovirals', 100, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3834, 145, 1, 2023, 'needing_antiretrovirals', 2000, NULL, 760, 3700, 2000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3835, 145, 1, 2023, 'percentage_received', 5, NULL, 2, 9, 5, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3836, 146, 1, 2023, 'received_antiretrovirals', 90, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3837, 146, 1, 2023, 'needing_antiretrovirals', 100, NULL, 100, 100, 100, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3838, 146, 1, 2023, 'percentage_received', 95, NULL, 84, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3845, 149, 1, 2023, 'received_antiretrovirals', 10, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3848, 150, 1, 2023, 'received_antiretrovirals', 220, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3849, 150, 1, 2023, 'needing_antiretrovirals', 500, NULL, 500, 560, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3850, 150, 1, 2023, 'percentage_received', 46, NULL, 39, 56, 46, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3851, 151, 1, 2023, 'received_antiretrovirals', 3800, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3852, 151, 1, 2023, 'needing_antiretrovirals', 3900, NULL, 3200, 4500, 3900, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3853, 151, 1, 2023, 'percentage_received', 95, NULL, 81, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3857, 153, 1, 2023, 'received_antiretrovirals', 4300, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3858, 153, 1, 2023, 'needing_antiretrovirals', 5400, NULL, 4200, 6200, 5400, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3859, 153, 1, 2023, 'percentage_received', 80, NULL, 62, 92, 80, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3863, 155, 1, 2023, 'received_antiretrovirals', 10, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3872, 158, 1, 2023, 'received_antiretrovirals', 94800, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3873, 158, 1, 2023, 'needing_antiretrovirals', 100000, NULL, 81000, 120000, 100000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3874, 158, 1, 2023, 'percentage_received', 93, NULL, 73, 95, 93, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3875, 159, 1, 2023, 'received_antiretrovirals', 2200, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3876, 159, 1, 2023, 'needing_antiretrovirals', 2200, NULL, 1900, 2500, 2200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3877, 159, 1, 2023, 'percentage_received', 95, NULL, 89, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3878, 160, 1, 2023, 'received_antiretrovirals', 10, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3884, 162, 1, 2023, 'received_antiretrovirals', 77000, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3885, 162, 1, 2023, 'needing_antiretrovirals', 83000, NULL, 62000, 98000, 83000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3886, 162, 1, 2023, 'percentage_received', 93, NULL, 70, 95, 93, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3890, 164, 1, 2023, 'received_antiretrovirals', 140, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3891, 164, 1, 2023, 'needing_antiretrovirals', 200, NULL, 100, 200, 200, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3892, 164, 1, 2023, 'percentage_received', 95, NULL, 71, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3893, 165, 1, 2023, 'received_antiretrovirals', 540, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3894, 165, 1, 2023, 'needing_antiretrovirals', 1500, NULL, 1400, 1600, 1500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3895, 165, 1, 2023, 'percentage_received', 35, NULL, 33, 38, 35, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3896, 166, 1, 2023, 'received_antiretrovirals', 410, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3899, 167, 1, 2023, 'received_antiretrovirals', 1900, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3900, 167, 1, 2023, 'needing_antiretrovirals', 2400, NULL, 2000, 2800, 2400, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3901, 167, 1, 2023, 'percentage_received', 81, NULL, 69, 95, 81, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3902, 168, 1, 2023, 'received_antiretrovirals', 30, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3903, 168, 1, 2023, 'needing_antiretrovirals', 500, NULL, 200, 500, 500, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3904, 168, 1, 2023, 'percentage_received', 13, NULL, 8, 20, 13, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3905, 169, 1, 2023, 'received_antiretrovirals', 56500, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3906, 169, 1, 2023, 'needing_antiretrovirals', 48000, NULL, 38000, 57000, 48000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3907, 169, 1, 2023, 'percentage_received', 95, NULL, 94, 95, 95, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3908, 170, 1, 2023, 'received_antiretrovirals', 59600, NULL, NULL, NULL, NULL, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3909, 170, 1, 2023, 'needing_antiretrovirals', 63000, NULL, 48000, 76000, 63000, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3910, 170, 1, 2023, 'percentage_received', 94, NULL, 71, 95, 94, 'good', 'prevention_of_mother_to_child_transmission_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3911, 1, 2, 2023, 'reported_receiving_art', 920, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3912, 1, 2, 2023, 'estimated_living_with_hiv', 7200, NULL, 4100, 11000, 7200, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3913, 1, 2, 2023, 'estimated_art_coverage_percent', 13, NULL, 7, 20, 13, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3914, 2, 2, 2023, 'reported_receiving_art', 580, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3917, 3, 2, 2023, 'reported_receiving_art', 12800, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3918, 3, 2, 2023, 'estimated_living_with_hiv', 16000, NULL, 15000, 17000, 16000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3919, 3, 2, 2023, 'estimated_art_coverage_percent', 81, NULL, 75, 86, 81, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3920, 4, 2, 2023, 'reported_receiving_art', 88700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3921, 4, 2, 2023, 'estimated_living_with_hiv', 330000, NULL, 290000, 390000, 330000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3922, 4, 2, 2023, 'estimated_art_coverage_percent', 27, NULL, 23, 31, 27, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3923, 5, 2, 2023, 'reported_receiving_art', 85500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3924, 5, 2, 2023, 'estimated_living_with_hiv', 140000, NULL, 130000, 150000, 140000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3925, 5, 2, 2023, 'estimated_art_coverage_percent', 61, NULL, 55, 67, 61, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3926, 6, 2, 2023, 'reported_receiving_art', 1900, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3927, 6, 2, 2023, 'estimated_living_with_hiv', 3500, NULL, 3000, 4400, 3500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3928, 6, 2, 2023, 'estimated_art_coverage_percent', 53, NULL, 44, 65, 53, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3929, 7, 2, 2023, 'reported_receiving_art', 22800, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3930, 7, 2, 2023, 'estimated_living_with_hiv', 28000, NULL, 23000, 31000, 28000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3931, 7, 2, 2023, 'estimated_art_coverage_percent', 83, NULL, 70, 93, 83, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3935, 9, 2, 2023, 'reported_receiving_art', 4400, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3938, 10, 2, 2023, 'reported_receiving_art', 3100, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3939, 10, 2, 2023, 'estimated_living_with_hiv', 6000, NULL, 5300, 6700, 6000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3940, 10, 2, 2023, 'estimated_art_coverage_percent', 52, NULL, 45, 58, 52, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3944, 12, 2, 2023, 'reported_receiving_art', 3000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3945, 12, 2, 2023, 'estimated_living_with_hiv', 14000, NULL, 12000, 16000, 14000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3946, 12, 2, 2023, 'estimated_art_coverage_percent', 22, NULL, 19, 25, 22, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3947, 13, 2, 2023, 'reported_receiving_art', 1500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3948, 13, 2, 2023, 'estimated_living_with_hiv', 3000, NULL, 2700, 3400, 3000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3949, 13, 2, 2023, 'estimated_art_coverage_percent', 50, NULL, 44, 57, 50, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3950, 14, 2, 2023, 'reported_receiving_art', 15500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3951, 14, 2, 2023, 'estimated_living_with_hiv', 27000, NULL, 22000, 34000, 27000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3952, 14, 2, 2023, 'estimated_art_coverage_percent', 59, NULL, 48, 75, 59, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3956, 16, 2, 2023, 'reported_receiving_art', 1400, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3957, 16, 2, 2023, 'estimated_living_with_hiv', 4900, NULL, 4400, 5400, 4900, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3958, 16, 2, 2023, 'estimated_art_coverage_percent', 28, NULL, 26, 31, 28, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3959, 17, 2, 2023, 'reported_receiving_art', 44200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3960, 17, 2, 2023, 'estimated_living_with_hiv', 73000, NULL, 48000, 120000, 73000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3961, 17, 2, 2023, 'estimated_art_coverage_percent', 61, NULL, 40, 95, 61, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3962, 18, 2, 2023, 'reported_receiving_art', 480, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3963, 18, 2, 2023, 'estimated_living_with_hiv', 1300, NULL, 700, 2700, 1300, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3964, 18, 2, 2023, 'estimated_art_coverage_percent', 37, NULL, 20, 78, 37, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3965, 19, 2, 2023, 'reported_receiving_art', 9900, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3966, 19, 2, 2023, 'estimated_living_with_hiv', 22000, NULL, 20000, 24000, 22000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3967, 19, 2, 2023, 'estimated_art_coverage_percent', 44, NULL, 40, 48, 44, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3968, 20, 2, 2023, 'reported_receiving_art', 220, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3969, 20, 2, 2023, 'estimated_living_with_hiv', 500, NULL, 500, 500, 500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3970, 20, 2, 2023, 'estimated_art_coverage_percent', 67, NULL, 57, 78, 67, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3971, 21, 2, 2023, 'reported_receiving_art', 307000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3972, 21, 2, 2023, 'estimated_living_with_hiv', 370000, NULL, 330000, 400000, 370000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3973, 21, 2, 2023, 'estimated_art_coverage_percent', 83, NULL, 75, 90, 83, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3974, 22, 2, 2023, 'reported_receiving_art', 593000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3975, 22, 2, 2023, 'estimated_living_with_hiv', 900000, NULL, 690000, 1100000, 900000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3976, 22, 2, 2023, 'estimated_art_coverage_percent', 66, NULL, 51, 82, 66, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3977, 23, 2, 2023, 'reported_receiving_art', 150, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3980, 24, 2, 2023, 'reported_receiving_art', 1500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3981, 24, 2, 2023, 'estimated_living_with_hiv', 3500, NULL, 3000, 4100, 3500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3982, 24, 2, 2023, 'estimated_art_coverage_percent', 41, NULL, 35, 48, 41, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3983, 25, 2, 2023, 'reported_receiving_art', 59300, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3984, 25, 2, 2023, 'estimated_living_with_hiv', 96000, NULL, 78000, 120000, 96000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3985, 25, 2, 2023, 'estimated_art_coverage_percent', 62, NULL, 50, 75, 62, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3986, 26, 2, 2023, 'reported_receiving_art', 65500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3987, 26, 2, 2023, 'estimated_living_with_hiv', 82000, NULL, 71000, 97000, 82000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3988, 26, 2, 2023, 'estimated_art_coverage_percent', 80, NULL, 69, 94, 80, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3989, 27, 2, 2023, 'reported_receiving_art', 2200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3990, 27, 2, 2023, 'estimated_living_with_hiv', 2400, NULL, 2100, 2900, 2400, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3991, 27, 2, 2023, 'estimated_art_coverage_percent', 89, NULL, 75, 95, 89, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3992, 28, 2, 2023, 'reported_receiving_art', 59500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3993, 28, 2, 2023, 'estimated_living_with_hiv', 73000, NULL, 64000, 84000, 73000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3994, 28, 2, 2023, 'estimated_art_coverage_percent', 81, NULL, 71, 93, 81, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3995, 29, 2, 2023, 'reported_receiving_art', 281000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3996, 29, 2, 2023, 'estimated_living_with_hiv', 540000, NULL, 470000, 590000, 540000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (3997, 29, 2, 2023, 'estimated_art_coverage_percent', 52, NULL, 46, 57, 52, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4001, 31, 2, 2023, 'reported_receiving_art', 39600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4002, 31, 2, 2023, 'estimated_living_with_hiv', 110000, NULL, 90000, 140000, 110000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4003, 31, 2, 2023, 'estimated_art_coverage_percent', 36, NULL, 30, 45, 36, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4004, 32, 2, 2023, 'reported_receiving_art', 61400, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4005, 32, 2, 2023, 'estimated_living_with_hiv', 120000, NULL, 94000, 150000, 120000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4006, 32, 2, 2023, 'estimated_art_coverage_percent', 51, NULL, 40, 63, 51, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4007, 33, 2, 2023, 'reported_receiving_art', 45100, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4008, 33, 2, 2023, 'estimated_living_with_hiv', 71000, NULL, 63000, 78000, 71000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4009, 33, 2, 2023, 'estimated_art_coverage_percent', 63, NULL, 56, 70, 63, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4010, 34, 2, 2023, 'reported_receiving_art', 718000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4013, 35, 2, 2023, 'reported_receiving_art', 113000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4014, 35, 2, 2023, 'estimated_living_with_hiv', 160000, NULL, 130000, 180000, 160000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4015, 35, 2, 2023, 'estimated_art_coverage_percent', 73, NULL, 60, 86, 73, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4016, 36, 2, 2023, 'reported_receiving_art', 100, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4017, 36, 2, 2023, 'estimated_living_with_hiv', 200, NULL, 100, 500, 200, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4018, 36, 2, 2023, 'estimated_art_coverage_percent', 79, NULL, 39, 95, 79, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4019, 37, 2, 2023, 'reported_receiving_art', 31200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4020, 37, 2, 2023, 'estimated_living_with_hiv', 89000, NULL, 69000, 120000, 89000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4021, 37, 2, 2023, 'estimated_art_coverage_percent', 35, NULL, 27, 46, 35, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4022, 38, 2, 2023, 'reported_receiving_art', 7200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4023, 38, 2, 2023, 'estimated_living_with_hiv', 15000, NULL, 13000, 17000, 15000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4024, 38, 2, 2023, 'estimated_art_coverage_percent', 49, NULL, 44, 54, 49, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4025, 39, 2, 2023, 'reported_receiving_art', 252000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4026, 39, 2, 2023, 'estimated_living_with_hiv', 460000, NULL, 360000, 580000, 460000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4027, 39, 2, 2023, 'estimated_art_coverage_percent', 55, NULL, 44, 70, 55, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4028, 40, 2, 2023, 'reported_receiving_art', 1200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4029, 40, 2, 2023, 'estimated_living_with_hiv', 1600, NULL, 1400, 1700, 1600, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4030, 40, 2, 2023, 'estimated_art_coverage_percent', 75, NULL, 67, 83, 75, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4031, 41, 2, 2023, 'reported_receiving_art', 21900, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4032, 41, 2, 2023, 'estimated_living_with_hiv', 31000, NULL, 24000, 37000, 31000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4033, 41, 2, 2023, 'estimated_art_coverage_percent', 72, NULL, 55, 85, 72, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4037, 43, 2, 2023, 'reported_receiving_art', 2600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4038, 43, 2, 2023, 'estimated_living_with_hiv', 4400, NULL, 3700, 5000, 4400, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4039, 43, 2, 2023, 'estimated_art_coverage_percent', 60, NULL, 51, 68, 60, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4043, 45, 2, 2023, 'reported_receiving_art', 256000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4044, 45, 2, 2023, 'estimated_living_with_hiv', 450000, NULL, 370000, 530000, 450000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4045, 45, 2, 2023, 'estimated_art_coverage_percent', 57, NULL, 47, 67, 57, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4046, 46, 2, 2023, 'reported_receiving_art', 5500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4047, 46, 2, 2023, 'estimated_living_with_hiv', 6200, NULL, 5600, 7000, 6200, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4048, 46, 2, 2023, 'estimated_art_coverage_percent', 89, NULL, 79, 95, 89, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4049, 47, 2, 2023, 'reported_receiving_art', 2700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4050, 47, 2, 2023, 'estimated_living_with_hiv', 8800, NULL, 7100, 11000, 8800, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4051, 47, 2, 2023, 'estimated_art_coverage_percent', 30, NULL, 25, 38, 30, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4052, 48, 2, 2023, 'reported_receiving_art', 39000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4053, 48, 2, 2023, 'estimated_living_with_hiv', 70000, NULL, 54000, 92000, 70000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4054, 48, 2, 2023, 'estimated_art_coverage_percent', 56, NULL, 43, 73, 56, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4055, 49, 2, 2023, 'reported_receiving_art', 25100, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4056, 49, 2, 2023, 'estimated_living_with_hiv', 44000, NULL, 29000, 71000, 44000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4057, 49, 2, 2023, 'estimated_art_coverage_percent', 57, NULL, 38, 93, 57, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4058, 50, 2, 2023, 'reported_receiving_art', 6700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4059, 50, 2, 2023, 'estimated_living_with_hiv', 22000, NULL, 20000, 24000, 22000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4060, 50, 2, 2023, 'estimated_art_coverage_percent', 31, NULL, 28, 33, 31, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4061, 51, 2, 2023, 'reported_receiving_art', 11900, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4062, 51, 2, 2023, 'estimated_living_with_hiv', 25000, NULL, 21000, 30000, 25000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4063, 51, 2, 2023, 'estimated_art_coverage_percent', 47, NULL, 39, 55, 47, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4064, 52, 2, 2023, 'reported_receiving_art', 21400, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4065, 52, 2, 2023, 'estimated_living_with_hiv', 62000, NULL, 50000, 81000, 62000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4066, 52, 2, 2023, 'estimated_art_coverage_percent', 34, NULL, 27, 44, 34, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4067, 53, 2, 2023, 'reported_receiving_art', 8900, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4068, 53, 2, 2023, 'estimated_living_with_hiv', 18000, NULL, 13000, 24000, 18000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4069, 53, 2, 2023, 'estimated_art_coverage_percent', 51, NULL, 38, 68, 51, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4070, 54, 2, 2023, 'reported_receiving_art', 4300, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4071, 54, 2, 2023, 'estimated_living_with_hiv', 7400, NULL, 6600, 8200, 7400, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4072, 54, 2, 2023, 'estimated_art_coverage_percent', 59, NULL, 53, 66, 59, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4073, 55, 2, 2023, 'reported_receiving_art', 177000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4074, 55, 2, 2023, 'estimated_living_with_hiv', 210000, NULL, 190000, 220000, 210000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4075, 55, 2, 2023, 'estimated_art_coverage_percent', 86, NULL, 80, 94, 86, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4076, 56, 2, 2023, 'reported_receiving_art', 450000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4077, 56, 2, 2023, 'estimated_living_with_hiv', 690000, NULL, 530000, 900000, 690000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4078, 56, 2, 2023, 'estimated_art_coverage_percent', 65, NULL, 50, 85, 65, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4082, 58, 2, 2023, 'reported_receiving_art', 3000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4083, 58, 2, 2023, 'estimated_living_with_hiv', 4000, NULL, 3100, 4900, 4000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4084, 58, 2, 2023, 'estimated_art_coverage_percent', 76, NULL, 60, 95, 76, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4085, 59, 2, 2023, 'reported_receiving_art', 148000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4086, 59, 2, 2023, 'estimated_living_with_hiv', 180000, NULL, 150000, 210000, 180000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4087, 59, 2, 2023, 'estimated_art_coverage_percent', 83, NULL, 69, 95, 83, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4088, 60, 2, 2023, 'reported_receiving_art', 35600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4089, 60, 2, 2023, 'estimated_living_with_hiv', 53000, NULL, 43000, 67000, 53000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4090, 60, 2, 2023, 'estimated_art_coverage_percent', 67, NULL, 54, 85, 67, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4091, 61, 2, 2023, 'reported_receiving_art', 7500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4092, 61, 2, 2023, 'estimated_living_with_hiv', 26000, NULL, 21000, 33000, 26000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4093, 61, 2, 2023, 'estimated_art_coverage_percent', 29, NULL, 24, 38, 29, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4094, 62, 2, 2023, 'reported_receiving_art', 4600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4095, 62, 2, 2023, 'estimated_living_with_hiv', 9400, NULL, 8100, 11000, 9400, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4096, 62, 2, 2023, 'estimated_art_coverage_percent', 49, NULL, 42, 57, 49, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4097, 63, 2, 2023, 'reported_receiving_art', 69900, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4098, 63, 2, 2023, 'estimated_living_with_hiv', 87000, NULL, 71000, 100000, 87000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4099, 63, 2, 2023, 'estimated_art_coverage_percent', 80, NULL, 65, 93, 80, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4100, 64, 2, 2023, 'reported_receiving_art', 113000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4101, 64, 2, 2023, 'estimated_living_with_hiv', 330000, NULL, 280000, 390000, 330000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4102, 64, 2, 2023, 'estimated_art_coverage_percent', 34, NULL, 28, 39, 34, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4106, 66, 2, 2023, 'reported_receiving_art', 20200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4107, 66, 2, 2023, 'estimated_living_with_hiv', 47000, NULL, 43000, 51000, 47000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4108, 66, 2, 2023, 'estimated_art_coverage_percent', 43, NULL, 40, 47, 43, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4109, 67, 2, 2023, 'reported_receiving_art', 48600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4110, 67, 2, 2023, 'estimated_living_with_hiv', 120000, NULL, 100000, 140000, 120000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4111, 67, 2, 2023, 'estimated_art_coverage_percent', 40, NULL, 34, 48, 40, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4112, 68, 2, 2023, 'reported_receiving_art', 14600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4113, 68, 2, 2023, 'estimated_living_with_hiv', 44000, NULL, 39000, 49000, 44000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4114, 68, 2, 2023, 'estimated_art_coverage_percent', 33, NULL, 29, 37, 33, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4115, 69, 2, 2023, 'reported_receiving_art', 5600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4116, 69, 2, 2023, 'estimated_living_with_hiv', 8200, NULL, 7200, 9400, 8200, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4117, 69, 2, 2023, 'estimated_art_coverage_percent', 68, NULL, 60, 78, 68, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4118, 70, 2, 2023, 'reported_receiving_art', 91500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4119, 70, 2, 2023, 'estimated_living_with_hiv', 160000, NULL, 140000, 180000, 160000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4120, 70, 2, 2023, 'estimated_art_coverage_percent', 58, NULL, 52, 65, 58, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4121, 71, 2, 2023, 'reported_receiving_art', 11700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4122, 71, 2, 2023, 'estimated_living_with_hiv', 23000, NULL, 18000, 28000, 23000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4123, 71, 2, 2023, 'estimated_art_coverage_percent', 50, NULL, 40, 61, 50, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4124, 72, 2, 2023, 'reported_receiving_art', 2000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4125, 72, 2, 2023, 'estimated_living_with_hiv', 3700, NULL, 3200, 4200, 3700, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4126, 72, 2, 2023, 'estimated_art_coverage_percent', 56, NULL, 48, 63, 56, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4127, 73, 2, 2023, 'reported_receiving_art', 250, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4128, 73, 2, 2023, 'estimated_living_with_hiv', 500, NULL, 500, 500, 500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4129, 73, 2, 2023, 'estimated_art_coverage_percent', 79, NULL, 71, 87, 79, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4133, 75, 2, 2023, 'reported_receiving_art', 108000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4134, 75, 2, 2023, 'estimated_living_with_hiv', 640000, NULL, 550000, 750000, 640000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4135, 75, 2, 2023, 'estimated_art_coverage_percent', 17, NULL, 15, 20, 17, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4136, 76, 2, 2023, 'reported_receiving_art', 12400, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4137, 76, 2, 2023, 'estimated_living_with_hiv', 61000, NULL, 34000, 120000, 61000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4138, 76, 2, 2023, 'estimated_art_coverage_percent', 20, NULL, 11, 39, 20, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4139, 77, 2, 2023, 'reported_receiving_art', 5700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4140, 77, 2, 2023, 'estimated_living_with_hiv', 7200, NULL, 6200, 8000, 7200, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4141, 77, 2, 2023, 'estimated_art_coverage_percent', 80, NULL, 69, 89, 80, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4143, 78, 2, 2023, 'estimated_living_with_hiv', 9000, NULL, 8000, 10000, 9000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4145, 79, 2, 2023, 'reported_receiving_art', 118000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4146, 79, 2, 2023, 'estimated_living_with_hiv', 130000, NULL, 110000, 140000, 130000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4147, 79, 2, 2023, 'estimated_art_coverage_percent', 91, NULL, 78, 95, 91, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4148, 80, 2, 2023, 'reported_receiving_art', 12600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4149, 80, 2, 2023, 'estimated_living_with_hiv', 40000, NULL, 35000, 46000, 40000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4150, 80, 2, 2023, 'estimated_art_coverage_percent', 31, NULL, 27, 36, 31, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4151, 81, 2, 2023, 'reported_receiving_art', 23700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4152, 81, 2, 2023, 'estimated_living_with_hiv', 30000, NULL, 25000, 34000, 30000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4153, 81, 2, 2023, 'estimated_art_coverage_percent', 80, NULL, 68, 92, 80, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4154, 82, 2, 2023, 'reported_receiving_art', 310, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4155, 82, 2, 2023, 'estimated_living_with_hiv', 500, NULL, 500, 500, 500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4156, 82, 2, 2023, 'estimated_art_coverage_percent', 84, NULL, 76, 95, 84, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4157, 83, 2, 2023, 'reported_receiving_art', 15000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4158, 83, 2, 2023, 'estimated_living_with_hiv', 26000, NULL, 24000, 27000, 26000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4159, 83, 2, 2023, 'estimated_art_coverage_percent', 58, NULL, 54, 62, 58, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4160, 84, 2, 2023, 'reported_receiving_art', 1068000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4161, 84, 2, 2023, 'estimated_living_with_hiv', 1600000, NULL, 1300000, 1900000, 1600000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4162, 84, 2, 2023, 'estimated_art_coverage_percent', 68, NULL, 58, 82, 68, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4163, 85, 2, 2023, 'reported_receiving_art', 400, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4164, 85, 2, 2023, 'estimated_living_with_hiv', 640, NULL, 580, 700, 640, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4165, 85, 2, 2023, 'estimated_art_coverage_percent', 62, NULL, 55, 67, 62, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4166, 86, 2, 2023, 'reported_receiving_art', 3700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4167, 86, 2, 2023, 'estimated_living_with_hiv', 8500, NULL, 6500, 12000, 8500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4168, 86, 2, 2023, 'estimated_art_coverage_percent', 43, NULL, 33, 59, 43, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4169, 87, 2, 2023, 'reported_receiving_art', 6500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4170, 87, 2, 2023, 'estimated_living_with_hiv', 12000, NULL, 11000, 14000, 12000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4171, 87, 2, 2023, 'estimated_art_coverage_percent', 54, NULL, 48, 62, 54, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4172, 88, 2, 2023, 'reported_receiving_art', 2400, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4173, 88, 2, 2023, 'estimated_living_with_hiv', 5300, NULL, 4800, 5900, 5300, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4174, 88, 2, 2023, 'estimated_art_coverage_percent', 45, NULL, 41, 50, 45, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4175, 89, 2, 2023, 'reported_receiving_art', 1500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4176, 89, 2, 2023, 'estimated_living_with_hiv', 2500, NULL, 2200, 2800, 2500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4177, 89, 2, 2023, 'estimated_art_coverage_percent', 60, NULL, 53, 67, 60, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4178, 90, 2, 2023, 'reported_receiving_art', 206000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4179, 90, 2, 2023, 'estimated_living_with_hiv', 340000, NULL, 320000, 360000, 340000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4180, 90, 2, 2023, 'estimated_art_coverage_percent', 61, NULL, 57, 65, 61, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4181, 91, 2, 2023, 'reported_receiving_art', 13900, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4182, 91, 2, 2023, 'estimated_living_with_hiv', 39000, NULL, 36000, 44000, 39000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4183, 91, 2, 2023, 'estimated_art_coverage_percent', 35, NULL, 32, 39, 35, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4184, 92, 2, 2023, 'reported_receiving_art', 4100, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4185, 92, 2, 2023, 'estimated_living_with_hiv', 9200, NULL, 8300, 10000, 9200, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4186, 92, 2, 2023, 'estimated_art_coverage_percent', 44, NULL, 40, 49, 44, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4190, 94, 2, 2023, 'reported_receiving_art', 890, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4191, 94, 2, 2023, 'estimated_living_with_hiv', 1200, NULL, 1000, 1300, 1200, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4192, 94, 2, 2023, 'estimated_art_coverage_percent', 77, NULL, 67, 86, 77, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4193, 95, 2, 2023, 'reported_receiving_art', 3500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4194, 95, 2, 2023, 'estimated_living_with_hiv', 39000, NULL, 30000, 55000, 39000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4195, 95, 2, 2023, 'estimated_art_coverage_percent', 9, NULL, 7, 13, 9, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4196, 96, 2, 2023, 'reported_receiving_art', 814000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4197, 96, 2, 2023, 'estimated_living_with_hiv', 1000000, NULL, 940000, 1100000, 1000000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4198, 96, 2, 2023, 'estimated_art_coverage_percent', 78, NULL, 70, 84, 78, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4199, 97, 2, 2023, 'reported_receiving_art', 41500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4200, 97, 2, 2023, 'estimated_living_with_hiv', 87000, NULL, 77000, 98000, 87000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4201, 97, 2, 2023, 'estimated_art_coverage_percent', 48, NULL, 42, 53, 48, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4205, 99, 2, 2023, 'reported_receiving_art', 47100, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4206, 99, 2, 2023, 'estimated_living_with_hiv', 150000, NULL, 120000, 190000, 150000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4207, 99, 2, 2023, 'estimated_art_coverage_percent', 31, NULL, 25, 39, 31, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4211, 101, 2, 2023, 'reported_receiving_art', 3000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4212, 101, 2, 2023, 'estimated_living_with_hiv', 5600, NULL, 4500, 7200, 5600, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4213, 101, 2, 2023, 'estimated_art_coverage_percent', 54, NULL, 44, 69, 54, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4214, 102, 2, 2023, 'reported_receiving_art', 2800, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4215, 102, 2, 2023, 'estimated_living_with_hiv', 13000, NULL, 10000, 15000, 13000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4216, 102, 2, 2023, 'estimated_art_coverage_percent', 22, NULL, 18, 26, 22, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4217, 103, 2, 2023, 'reported_receiving_art', 165000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4218, 103, 2, 2023, 'estimated_living_with_hiv', 230000, NULL, 200000, 270000, 230000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4219, 103, 2, 2023, 'estimated_art_coverage_percent', 70, NULL, 60, 80, 70, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4220, 104, 2, 2023, 'reported_receiving_art', 200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4221, 104, 2, 2023, 'estimated_living_with_hiv', 600, NULL, 530, 670, 600, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4222, 104, 2, 2023, 'estimated_art_coverage_percent', 32, NULL, 29, 36, 32, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4223, 105, 2, 2023, 'reported_receiving_art', 160, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4224, 105, 2, 2023, 'estimated_living_with_hiv', 500, NULL, 500, 500, 500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4225, 105, 2, 2023, 'estimated_art_coverage_percent', 40, NULL, 34, 46, 40, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4226, 106, 2, 2023, 'reported_receiving_art', 13600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4227, 106, 2, 2023, 'estimated_living_with_hiv', 21000, NULL, 17000, 28000, 21000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4228, 106, 2, 2023, 'estimated_art_coverage_percent', 65, NULL, 52, 86, 65, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4229, 107, 2, 2023, 'reported_receiving_art', 1213000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4230, 107, 2, 2023, 'estimated_living_with_hiv', 2200000, NULL, 1700000, 2700000, 2200000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4231, 107, 2, 2023, 'estimated_art_coverage_percent', 56, NULL, 44, 68, 56, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4232, 108, 2, 2023, 'reported_receiving_art', 167000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4233, 108, 2, 2023, 'estimated_living_with_hiv', 240000, NULL, 210000, 270000, 240000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4234, 108, 2, 2023, 'estimated_art_coverage_percent', 70, NULL, 63, 79, 70, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4235, 109, 2, 2023, 'reported_receiving_art', 184000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4236, 109, 2, 2023, 'estimated_living_with_hiv', 200000, NULL, 190000, 220000, 200000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4237, 109, 2, 2023, 'estimated_art_coverage_percent', 92, NULL, 84, 95, 92, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4238, 110, 2, 2023, 'reported_receiving_art', 16900, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4239, 110, 2, 2023, 'estimated_living_with_hiv', 30000, NULL, 26000, 34000, 30000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4240, 110, 2, 2023, 'estimated_art_coverage_percent', 56, NULL, 50, 65, 56, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4244, 112, 2, 2023, 'reported_receiving_art', 2700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4245, 112, 2, 2023, 'estimated_living_with_hiv', 3600, NULL, 3100, 4200, 3600, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4246, 112, 2, 2023, 'estimated_art_coverage_percent', 73, NULL, 62, 84, 73, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4247, 113, 2, 2023, 'reported_receiving_art', 5000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4248, 113, 2, 2023, 'estimated_living_with_hiv', 9400, NULL, 7600, 12000, 9400, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4249, 113, 2, 2023, 'estimated_art_coverage_percent', 53, NULL, 43, 68, 53, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4250, 114, 2, 2023, 'reported_receiving_art', 19800, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4251, 114, 2, 2023, 'estimated_living_with_hiv', 36000, NULL, 30000, 43000, 36000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4252, 114, 2, 2023, 'estimated_art_coverage_percent', 54, NULL, 45, 65, 54, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4253, 115, 2, 2023, 'reported_receiving_art', 1016000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4254, 115, 2, 2023, 'estimated_living_with_hiv', 1900000, NULL, 1400000, 2600000, 1900000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4255, 115, 2, 2023, 'estimated_art_coverage_percent', 53, NULL, 40, 71, 53, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4256, 116, 2, 2023, 'reported_receiving_art', 4700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4257, 116, 2, 2023, 'estimated_living_with_hiv', 5800, NULL, 5200, 6300, 5800, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4258, 116, 2, 2023, 'estimated_art_coverage_percent', 82, NULL, 74, 90, 82, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4259, 117, 2, 2023, 'reported_receiving_art', 1300, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4260, 117, 2, 2023, 'estimated_living_with_hiv', 3200, NULL, 2900, 3600, 3200, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4261, 117, 2, 2023, 'estimated_art_coverage_percent', 41, NULL, 37, 45, 41, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4262, 118, 2, 2023, 'reported_receiving_art', 15800, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4263, 118, 2, 2023, 'estimated_living_with_hiv', 160000, NULL, 140000, 190000, 160000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4264, 118, 2, 2023, 'estimated_art_coverage_percent', 10, NULL, 9, 11, 10, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4265, 119, 2, 2023, 'reported_receiving_art', 14200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4266, 119, 2, 2023, 'estimated_living_with_hiv', 26000, NULL, 24000, 29000, 26000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4267, 119, 2, 2023, 'estimated_art_coverage_percent', 54, NULL, 48, 59, 54, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4268, 120, 2, 2023, 'reported_receiving_art', 29400, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4269, 120, 2, 2023, 'estimated_living_with_hiv', 45000, NULL, 41000, 50000, 45000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4270, 120, 2, 2023, 'estimated_art_coverage_percent', 65, NULL, 58, 71, 65, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4271, 121, 2, 2023, 'reported_receiving_art', 8500, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4272, 121, 2, 2023, 'estimated_living_with_hiv', 21000, NULL, 16000, 31000, 21000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4273, 121, 2, 2023, 'estimated_art_coverage_percent', 40, NULL, 31, 58, 40, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4274, 122, 2, 2023, 'reported_receiving_art', 57800, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4275, 122, 2, 2023, 'estimated_living_with_hiv', 79000, NULL, 58000, 110000, 79000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4276, 122, 2, 2023, 'estimated_art_coverage_percent', 73, NULL, 54, 95, 73, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4277, 123, 2, 2023, 'reported_receiving_art', 33600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4278, 123, 2, 2023, 'estimated_living_with_hiv', 77000, NULL, 65000, 90000, 77000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4279, 123, 2, 2023, 'estimated_art_coverage_percent', 44, NULL, 37, 51, 44, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4283, 125, 2, 2023, 'reported_receiving_art', 37200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4284, 125, 2, 2023, 'estimated_living_with_hiv', 41000, NULL, 36000, 46000, 41000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4285, 125, 2, 2023, 'estimated_art_coverage_percent', 90, NULL, 78, 95, 90, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4286, 126, 2, 2023, 'reported_receiving_art', 150, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4292, 128, 2, 2023, 'reported_receiving_art', 6000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4293, 128, 2, 2023, 'estimated_living_with_hiv', 17000, NULL, 14000, 23000, 17000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4294, 128, 2, 2023, 'estimated_art_coverage_percent', 34, NULL, 27, 45, 34, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4295, 129, 2, 2023, 'reported_receiving_art', 240, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4296, 129, 2, 2023, 'estimated_living_with_hiv', 500, NULL, 500, 520, 500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4297, 129, 2, 2023, 'estimated_art_coverage_percent', 54, NULL, 47, 63, 54, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4298, 130, 2, 2023, 'reported_receiving_art', 12100, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4299, 130, 2, 2023, 'estimated_living_with_hiv', 18000, NULL, 16000, 20000, 18000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4300, 130, 2, 2023, 'estimated_art_coverage_percent', 67, NULL, 60, 73, 67, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4304, 132, 2, 2023, 'reported_receiving_art', 194000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4305, 132, 2, 2023, 'estimated_living_with_hiv', 220000, NULL, 200000, 250000, 220000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4306, 132, 2, 2023, 'estimated_art_coverage_percent', 87, NULL, 76, 95, 87, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4307, 133, 2, 2023, 'reported_receiving_art', 6300, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4310, 134, 2, 2023, 'reported_receiving_art', 26600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4311, 134, 2, 2023, 'estimated_living_with_hiv', 42000, NULL, 37000, 47000, 42000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4312, 134, 2, 2023, 'estimated_art_coverage_percent', 63, NULL, 55, 71, 63, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4313, 135, 2, 2023, 'reported_receiving_art', 2000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4314, 135, 2, 2023, 'estimated_living_with_hiv', 3000, NULL, 2200, 3800, 3000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4315, 135, 2, 2023, 'estimated_art_coverage_percent', 65, NULL, 47, 83, 65, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4316, 136, 2, 2023, 'reported_receiving_art', 28400, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4317, 136, 2, 2023, 'estimated_living_with_hiv', 70000, NULL, 56000, 86000, 70000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4318, 136, 2, 2023, 'estimated_art_coverage_percent', 41, NULL, 33, 50, 41, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4319, 137, 2, 2023, 'reported_receiving_art', 6200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4320, 137, 2, 2023, 'estimated_living_with_hiv', 7900, NULL, 7200, 8700, 7900, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4321, 137, 2, 2023, 'estimated_art_coverage_percent', 78, NULL, 71, 86, 78, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4322, 138, 2, 2023, 'reported_receiving_art', 650, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4323, 138, 2, 2023, 'estimated_living_with_hiv', 1200, NULL, 910, 1900, 1200, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4324, 138, 2, 2023, 'estimated_art_coverage_percent', 54, NULL, 40, 85, 54, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4328, 140, 2, 2023, 'reported_receiving_art', 3300, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4329, 140, 2, 2023, 'estimated_living_with_hiv', 11000, NULL, 8400, 15000, 11000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4330, 140, 2, 2023, 'estimated_art_coverage_percent', 30, NULL, 23, 41, 30, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4331, 141, 2, 2023, 'reported_receiving_art', 4788000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4332, 141, 2, 2023, 'estimated_living_with_hiv', 7700000, NULL, 7100000, 8300000, 7700000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4333, 141, 2, 2023, 'estimated_art_coverage_percent', 62, NULL, 57, 66, 62, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4334, 142, 2, 2023, 'reported_receiving_art', 30700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4335, 142, 2, 2023, 'estimated_living_with_hiv', 190000, NULL, 140000, 240000, 190000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4336, 142, 2, 2023, 'estimated_art_coverage_percent', 16, NULL, 12, 20, 16, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4337, 143, 2, 2023, 'reported_receiving_art', 125000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4338, 143, 2, 2023, 'estimated_living_with_hiv', 150000, NULL, 130000, 170000, 150000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4339, 143, 2, 2023, 'estimated_art_coverage_percent', 84, NULL, 73, 94, 84, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4340, 144, 2, 2023, 'reported_receiving_art', 1600, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4341, 144, 2, 2023, 'estimated_living_with_hiv', 3500, NULL, 3100, 4000, 3500, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4342, 144, 2, 2023, 'estimated_art_coverage_percent', 45, NULL, 40, 52, 45, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4343, 145, 2, 2023, 'reported_receiving_art', 9000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4344, 145, 2, 2023, 'estimated_living_with_hiv', 59000, NULL, 26000, 110000, 59000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4345, 145, 2, 2023, 'estimated_art_coverage_percent', 15, NULL, 7, 28, 15, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4346, 146, 2, 2023, 'reported_receiving_art', 2900, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4347, 146, 2, 2023, 'estimated_living_with_hiv', 5600, NULL, 3700, 8100, 5600, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4348, 146, 2, 2023, 'estimated_art_coverage_percent', 52, NULL, 35, 75, 52, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4352, 148, 2, 2023, 'reported_receiving_art', 14800, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4355, 149, 2, 2023, 'reported_receiving_art', 130, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4356, 149, 2, 2023, 'estimated_living_with_hiv', 660, NULL, 590, 720, 660, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4357, 149, 2, 2023, 'estimated_art_coverage_percent', 20, NULL, 18, 22, 20, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4358, 150, 2, 2023, 'reported_receiving_art', 6000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4359, 150, 2, 2023, 'estimated_living_with_hiv', 13000, NULL, 11000, 16000, 13000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4360, 150, 2, 2023, 'estimated_art_coverage_percent', 46, NULL, 38, 56, 46, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4361, 151, 2, 2023, 'reported_receiving_art', 359000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4362, 151, 2, 2023, 'estimated_living_with_hiv', 480000, NULL, 420000, 550000, 480000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4363, 151, 2, 2023, 'estimated_art_coverage_percent', 75, NULL, 66, 86, 75, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4367, 153, 2, 2023, 'reported_receiving_art', 64800, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4368, 153, 2, 2023, 'estimated_living_with_hiv', 110000, NULL, 100000, 120000, 110000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4369, 153, 2, 2023, 'estimated_art_coverage_percent', 60, NULL, 56, 65, 60, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4373, 155, 2, 2023, 'reported_receiving_art', 1100, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4374, 155, 2, 2023, 'estimated_living_with_hiv', 2800, NULL, 1700, 4400, 2800, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4375, 155, 2, 2023, 'estimated_art_coverage_percent', 39, NULL, 24, 61, 39, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4382, 158, 2, 2023, 'reported_receiving_art', 1004000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4383, 158, 2, 2023, 'estimated_living_with_hiv', 1400000, NULL, 1300000, 1500000, 1400000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4384, 158, 2, 2023, 'estimated_art_coverage_percent', 72, NULL, 68, 78, 72, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4385, 159, 2, 2023, 'reported_receiving_art', 124000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4386, 159, 2, 2023, 'estimated_living_with_hiv', 240000, NULL, 220000, 260000, 240000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4387, 159, 2, 2023, 'estimated_art_coverage_percent', 52, NULL, 48, 56, 52, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4394, 162, 2, 2023, 'reported_receiving_art', 1109000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4395, 162, 2, 2023, 'estimated_living_with_hiv', 1600000, NULL, 1400000, 1700000, 1600000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4396, 162, 2, 2023, 'estimated_art_coverage_percent', 71, NULL, 64, 78, 71, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4400, 164, 2, 2023, 'reported_receiving_art', 8100, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4401, 164, 2, 2023, 'estimated_living_with_hiv', 14000, NULL, 9900, 19000, 14000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4402, 164, 2, 2023, 'estimated_art_coverage_percent', 58, NULL, 41, 76, 58, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4403, 165, 2, 2023, 'reported_receiving_art', 26700, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4404, 165, 2, 2023, 'estimated_living_with_hiv', 52000, NULL, 48000, 56000, 52000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4405, 165, 2, 2023, 'estimated_art_coverage_percent', 51, NULL, 47, 55, 51, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4407, 166, 2, 2023, 'estimated_living_with_hiv', 120000, NULL, 100000, 130000, 120000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4409, 167, 2, 2023, 'reported_receiving_art', 150000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4410, 167, 2, 2023, 'estimated_living_with_hiv', 230000, NULL, 200000, 260000, 230000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4411, 167, 2, 2023, 'estimated_art_coverage_percent', 65, NULL, 57, 73, 65, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4412, 168, 2, 2023, 'reported_receiving_art', 2200, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4413, 168, 2, 2023, 'estimated_living_with_hiv', 11000, NULL, 6500, 18000, 11000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4414, 168, 2, 2023, 'estimated_art_coverage_percent', 21, NULL, 12, 35, 21, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4415, 169, 2, 2023, 'reported_receiving_art', 965000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4416, 169, 2, 2023, 'estimated_living_with_hiv', 1200000, NULL, 1100000, 1400000, 1200000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4417, 169, 2, 2023, 'estimated_art_coverage_percent', 78, NULL, 69, 88, 78, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4418, 170, 2, 2023, 'reported_receiving_art', 1151000, NULL, NULL, NULL, NULL, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4419, 170, 2, 2023, 'estimated_living_with_hiv', 1300000, NULL, 1100000, 1500000, 1300000, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4420, 170, 2, 2023, 'estimated_art_coverage_percent', 88, NULL, 77, 95, 88, 'good', 'art_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4421, 1, 3, 2018, 'count', 7200, NULL, 4100, 11000, 7200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4423, 3, 3, 2018, 'count', 16000, NULL, 15000, 17000, 16000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4424, 4, 3, 2018, 'count', 330000, NULL, 290000, 390000, 330000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4425, 5, 3, 2018, 'count', 140000, NULL, 130000, 150000, 140000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4426, 6, 3, 2018, 'count', 3500, NULL, 3000, 4400, 3500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4427, 7, 3, 2018, 'count', 28000, NULL, 23000, 31000, 28000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4430, 10, 3, 2018, 'count', 6000, NULL, 5300, 6700, 6000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4432, 12, 3, 2018, 'count', 14000, NULL, 12000, 16000, 14000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4433, 13, 3, 2018, 'count', 3000, NULL, 2700, 3400, 3000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4434, 14, 3, 2018, 'count', 27000, NULL, 22000, 34000, 27000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4436, 16, 3, 2018, 'count', 4900, NULL, 4400, 5400, 4900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4437, 17, 3, 2018, 'count', 73000, NULL, 48000, 120000, 73000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4438, 18, 3, 2018, 'count', 1300, NULL, 700, 2700, 1300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4439, 19, 3, 2018, 'count', 22000, NULL, 20000, 24000, 22000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4440, 20, 3, 2018, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4441, 21, 3, 2018, 'count', 370000, NULL, 330000, 400000, 370000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4442, 22, 3, 2018, 'count', 900000, NULL, 690000, 1100000, 900000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4444, 24, 3, 2018, 'count', 3500, NULL, 3000, 4100, 3500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4445, 25, 3, 2018, 'count', 96000, NULL, 78000, 120000, 96000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4446, 26, 3, 2018, 'count', 82000, NULL, 71000, 97000, 82000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4447, 27, 3, 2018, 'count', 2400, NULL, 2100, 2900, 2400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4448, 28, 3, 2018, 'count', 73000, NULL, 64000, 84000, 73000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4449, 29, 3, 2018, 'count', 540000, NULL, 470000, 590000, 540000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4451, 31, 3, 2018, 'count', 110000, NULL, 90000, 140000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4452, 32, 3, 2018, 'count', 120000, NULL, 94000, 150000, 120000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4453, 33, 3, 2018, 'count', 71000, NULL, 63000, 78000, 71000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4455, 35, 3, 2018, 'count', 160000, NULL, 130000, 180000, 160000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4456, 36, 3, 2018, 'count', 200, NULL, 100, 500, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4457, 37, 3, 2018, 'count', 89000, NULL, 69000, 120000, 89000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4458, 38, 3, 2018, 'count', 15000, NULL, 13000, 17000, 15000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4459, 39, 3, 2018, 'count', 460000, NULL, 360000, 580000, 460000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4460, 40, 3, 2018, 'count', 1600, NULL, 1400, 1700, 1600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4461, 41, 3, 2018, 'count', 31000, NULL, 24000, 37000, 31000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4463, 43, 3, 2018, 'count', 4400, NULL, 3700, 5000, 4400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4465, 45, 3, 2018, 'count', 450000, NULL, 370000, 530000, 450000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4466, 46, 3, 2018, 'count', 6200, NULL, 5600, 7000, 6200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4467, 47, 3, 2018, 'count', 8800, NULL, 7100, 11000, 8800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4468, 48, 3, 2018, 'count', 70000, NULL, 54000, 92000, 70000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4469, 49, 3, 2018, 'count', 44000, NULL, 29000, 71000, 44000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4470, 50, 3, 2018, 'count', 22000, NULL, 20000, 24000, 22000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4471, 51, 3, 2018, 'count', 25000, NULL, 21000, 30000, 25000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4472, 52, 3, 2018, 'count', 62000, NULL, 50000, 81000, 62000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4473, 53, 3, 2018, 'count', 18000, NULL, 13000, 24000, 18000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4474, 54, 3, 2018, 'count', 7400, NULL, 6600, 8200, 7400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4475, 55, 3, 2018, 'count', 210000, NULL, 190000, 220000, 210000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4476, 56, 3, 2018, 'count', 690000, NULL, 530000, 900000, 690000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4478, 58, 3, 2018, 'count', 4000, NULL, 3100, 4900, 4000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4479, 59, 3, 2018, 'count', 180000, NULL, 150000, 210000, 180000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4480, 60, 3, 2018, 'count', 53000, NULL, 43000, 67000, 53000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4481, 61, 3, 2018, 'count', 26000, NULL, 21000, 33000, 26000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4482, 62, 3, 2018, 'count', 9400, NULL, 8100, 11000, 9400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4483, 63, 3, 2018, 'count', 87000, NULL, 71000, 100000, 87000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4484, 64, 3, 2018, 'count', 330000, NULL, 280000, 390000, 330000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4486, 66, 3, 2018, 'count', 47000, NULL, 43000, 51000, 47000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4487, 67, 3, 2018, 'count', 120000, NULL, 100000, 140000, 120000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4488, 68, 3, 2018, 'count', 44000, NULL, 39000, 49000, 44000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4489, 69, 3, 2018, 'count', 8200, NULL, 7200, 9400, 8200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4490, 70, 3, 2018, 'count', 160000, NULL, 140000, 180000, 160000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4491, 71, 3, 2018, 'count', 23000, NULL, 18000, 28000, 23000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4492, 72, 3, 2018, 'count', 3700, NULL, 3200, 4200, 3700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4493, 73, 3, 2018, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4495, 75, 3, 2018, 'count', 640000, NULL, 550000, 750000, 640000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4496, 76, 3, 2018, 'count', 61000, NULL, 34000, 120000, 61000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4497, 77, 3, 2018, 'count', 7200, NULL, 6200, 8000, 7200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4498, 78, 3, 2018, 'count', 9000, NULL, 8000, 10000, 9000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4499, 79, 3, 2018, 'count', 130000, NULL, 110000, 140000, 130000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4500, 80, 3, 2018, 'count', 40000, NULL, 35000, 46000, 40000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4501, 81, 3, 2018, 'count', 30000, NULL, 25000, 34000, 30000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4502, 82, 3, 2018, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4503, 83, 3, 2018, 'count', 26000, NULL, 24000, 27000, 26000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4504, 84, 3, 2018, 'count', 1600000, NULL, 1300000, 1900000, 1600000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4505, 85, 3, 2018, 'count', 640, NULL, 580, 700, 640, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4506, 86, 3, 2018, 'count', 8500, NULL, 6500, 12000, 8500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4507, 87, 3, 2018, 'count', 12000, NULL, 11000, 14000, 12000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4508, 88, 3, 2018, 'count', 5300, NULL, 4800, 5900, 5300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4509, 89, 3, 2018, 'count', 2500, NULL, 2200, 2800, 2500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4510, 90, 3, 2018, 'count', 340000, NULL, 320000, 360000, 340000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4511, 91, 3, 2018, 'count', 39000, NULL, 36000, 44000, 39000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4512, 92, 3, 2018, 'count', 9200, NULL, 8300, 10000, 9200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4514, 94, 3, 2018, 'count', 1200, NULL, 1000, 1300, 1200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4515, 95, 3, 2018, 'count', 39000, NULL, 30000, 55000, 39000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4516, 96, 3, 2018, 'count', 1000000, NULL, 940000, 1100000, 1000000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4517, 97, 3, 2018, 'count', 87000, NULL, 77000, 98000, 87000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4519, 99, 3, 2018, 'count', 150000, NULL, 120000, 190000, 150000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4521, 101, 3, 2018, 'count', 5600, NULL, 4500, 7200, 5600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4522, 102, 3, 2018, 'count', 13000, NULL, 10000, 15000, 13000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4523, 103, 3, 2018, 'count', 230000, NULL, 200000, 270000, 230000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4524, 104, 3, 2018, 'count', 600, NULL, 530, 670, 600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4525, 105, 3, 2018, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4526, 106, 3, 2018, 'count', 21000, NULL, 17000, 28000, 21000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4527, 107, 3, 2018, 'count', 2200000, NULL, 1700000, 2700000, 2200000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4528, 108, 3, 2018, 'count', 240000, NULL, 210000, 270000, 240000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4529, 109, 3, 2018, 'count', 200000, NULL, 190000, 220000, 200000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4530, 110, 3, 2018, 'count', 30000, NULL, 26000, 34000, 30000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4532, 112, 3, 2018, 'count', 3600, NULL, 3100, 4200, 3600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4533, 113, 3, 2018, 'count', 9400, NULL, 7600, 12000, 9400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4534, 114, 3, 2018, 'count', 36000, NULL, 30000, 43000, 36000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4535, 115, 3, 2018, 'count', 1900000, NULL, 1400000, 2600000, 1900000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4536, 116, 3, 2018, 'count', 5800, NULL, 5200, 6300, 5800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4537, 117, 3, 2018, 'count', 3200, NULL, 2900, 3600, 3200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4538, 118, 3, 2018, 'count', 160000, NULL, 140000, 190000, 160000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4539, 119, 3, 2018, 'count', 26000, NULL, 24000, 29000, 26000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4540, 120, 3, 2018, 'count', 45000, NULL, 41000, 50000, 45000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4541, 121, 3, 2018, 'count', 21000, NULL, 16000, 31000, 21000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4542, 122, 3, 2018, 'count', 79000, NULL, 58000, 110000, 79000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4543, 123, 3, 2018, 'count', 77000, NULL, 65000, 90000, 77000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4545, 125, 3, 2018, 'count', 41000, NULL, 36000, 46000, 41000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4548, 128, 3, 2018, 'count', 17000, NULL, 14000, 23000, 17000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4549, 129, 3, 2018, 'count', 500, NULL, 500, 520, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4550, 130, 3, 2018, 'count', 18000, NULL, 16000, 20000, 18000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4552, 132, 3, 2018, 'count', 220000, NULL, 200000, 250000, 220000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4554, 134, 3, 2018, 'count', 42000, NULL, 37000, 47000, 42000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4555, 135, 3, 2018, 'count', 3000, NULL, 2200, 3800, 3000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4556, 136, 3, 2018, 'count', 70000, NULL, 56000, 86000, 70000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4557, 137, 3, 2018, 'count', 7900, NULL, 7200, 8700, 7900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4558, 138, 3, 2018, 'count', 1200, NULL, 910, 1900, 1200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4560, 140, 3, 2018, 'count', 11000, NULL, 8400, 15000, 11000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4561, 141, 3, 2018, 'count', 7700000, NULL, 7100000, 8300000, 7700000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4562, 142, 3, 2018, 'count', 190000, NULL, 140000, 240000, 190000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4563, 143, 3, 2018, 'count', 150000, NULL, 130000, 170000, 150000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4564, 144, 3, 2018, 'count', 3500, NULL, 3100, 4000, 3500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4565, 145, 3, 2018, 'count', 59000, NULL, 26000, 110000, 59000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4566, 146, 3, 2018, 'count', 5600, NULL, 3700, 8100, 5600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4569, 149, 3, 2018, 'count', 660, NULL, 590, 720, 660, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4570, 150, 3, 2018, 'count', 13000, NULL, 11000, 16000, 13000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4571, 151, 3, 2018, 'count', 480000, NULL, 420000, 550000, 480000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4573, 153, 3, 2018, 'count', 110000, NULL, 100000, 120000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4575, 155, 3, 2018, 'count', 2800, NULL, 1700, 4400, 2800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4578, 158, 3, 2018, 'count', 1400000, NULL, 1300000, 1500000, 1400000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4579, 159, 3, 2018, 'count', 240000, NULL, 220000, 260000, 240000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4582, 162, 3, 2018, 'count', 1600000, NULL, 1400000, 1700000, 1600000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4584, 164, 3, 2018, 'count', 14000, NULL, 9900, 19000, 14000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4585, 165, 3, 2018, 'count', 52000, NULL, 48000, 56000, 52000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4586, 166, 3, 2018, 'count', 120000, NULL, 100000, 130000, 120000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4587, 167, 3, 2018, 'count', 230000, NULL, 200000, 260000, 230000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4588, 168, 3, 2018, 'count', 11000, NULL, 6500, 18000, 11000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4589, 169, 3, 2018, 'count', 1200000, NULL, 1100000, 1400000, 1200000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4590, 170, 3, 2018, 'count', 1300000, NULL, 1100000, 1500000, 1300000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4591, 1, 3, 2010, 'count', 4200, NULL, 2500, 6200, 4200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4593, 3, 3, 2010, 'count', 7100, NULL, 6600, 7600, 7100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4594, 4, 3, 2010, 'count', 220000, NULL, 180000, 250000, 220000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4595, 5, 3, 2010, 'count', 110000, NULL, 96000, 120000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4596, 6, 3, 2010, 'count', 3300, NULL, 2800, 4100, 3300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4597, 7, 3, 2010, 'count', 21000, NULL, 17000, 23000, 21000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4600, 10, 3, 2010, 'count', 5800, NULL, 5100, 6600, 5800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4602, 12, 3, 2010, 'count', 7700, NULL, 6600, 8800, 7700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4603, 13, 3, 2010, 'count', 2300, NULL, 2100, 2600, 2300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4604, 14, 3, 2010, 'count', 12000, NULL, 10000, 15000, 12000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4606, 16, 3, 2010, 'count', 3700, NULL, 3400, 4100, 3700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4607, 17, 3, 2010, 'count', 61000, NULL, 41000, 98000, 61000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4608, 18, 3, 2010, 'count', 1300, NULL, 590, 2700, 1300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4609, 19, 3, 2010, 'count', 23000, NULL, 20000, 25000, 23000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4610, 20, 3, 2010, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4611, 21, 3, 2010, 'count', 340000, NULL, 300000, 360000, 340000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4612, 22, 3, 2010, 'count', 670000, NULL, 520000, 830000, 670000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4614, 24, 3, 2010, 'count', 1700, NULL, 1600, 1900, 1700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4615, 25, 3, 2010, 'count', 110000, NULL, 88000, 130000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4616, 26, 3, 2010, 'count', 93000, NULL, 79000, 110000, 93000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4617, 27, 3, 2010, 'count', 2100, NULL, 1700, 2600, 2100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4618, 28, 3, 2010, 'count', 79000, NULL, 68000, 93000, 79000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4619, 29, 3, 2010, 'count', 520000, NULL, 460000, 560000, 520000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4621, 31, 3, 2010, 'count', 140000, NULL, 110000, 160000, 140000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4622, 32, 3, 2010, 'count', 99000, NULL, 80000, 120000, 99000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4623, 33, 3, 2010, 'count', 39000, NULL, 34000, 43000, 39000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4625, 35, 3, 2010, 'count', 130000, NULL, 100000, 150000, 130000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4626, 36, 3, 2010, 'count', 200, NULL, 100, 500, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4627, 37, 3, 2010, 'count', 82000, NULL, 69000, 95000, 82000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4628, 38, 3, 2010, 'count', 9300, NULL, 8400, 10000, 9300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4629, 39, 3, 2010, 'count', 480000, NULL, 380000, 610000, 480000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4630, 40, 3, 2010, 'count', 1000, NULL, 930, 1100, 1000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4631, 41, 3, 2010, 'count', 17000, NULL, 13000, 21000, 17000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4633, 43, 3, 2010, 'count', 1800, NULL, 1500, 2000, 1800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4635, 45, 3, 2010, 'count', 480000, NULL, 400000, 560000, 480000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4636, 46, 3, 2010, 'count', 5500, NULL, 5000, 6200, 5500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4637, 47, 3, 2010, 'count', 9400, NULL, 7700, 11000, 9400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4638, 48, 3, 2010, 'count', 72000, NULL, 54000, 91000, 72000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4639, 49, 3, 2010, 'count', 34000, NULL, 22000, 57000, 34000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4640, 50, 3, 2010, 'count', 6800, NULL, 6100, 7400, 6800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4641, 51, 3, 2010, 'count', 26000, NULL, 20000, 31000, 26000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4642, 52, 3, 2010, 'count', 35000, NULL, 29000, 41000, 35000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4643, 53, 3, 2010, 'count', 17000, NULL, 13000, 22000, 17000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4644, 54, 3, 2010, 'count', 6000, NULL, 5100, 6700, 6000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4645, 55, 3, 2010, 'count', 160000, NULL, 150000, 170000, 160000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4646, 56, 3, 2010, 'count', 630000, NULL, 480000, 830000, 630000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4648, 58, 3, 2010, 'count', 2700, NULL, 2200, 3500, 2700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4649, 59, 3, 2010, 'count', 140000, NULL, 120000, 160000, 140000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4650, 60, 3, 2010, 'count', 43000, NULL, 36000, 51000, 43000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4651, 61, 3, 2010, 'count', 18000, NULL, 15000, 23000, 18000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4652, 62, 3, 2010, 'count', 5600, NULL, 4500, 6700, 5600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4653, 63, 3, 2010, 'count', 69000, NULL, 57000, 81000, 69000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4654, 64, 3, 2010, 'count', 300000, NULL, 250000, 340000, 300000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4656, 66, 3, 2010, 'count', 49000, NULL, 44000, 53000, 49000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4657, 67, 3, 2010, 'count', 100000, NULL, 90000, 120000, 100000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4658, 68, 3, 2010, 'count', 38000, NULL, 34000, 42000, 38000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4659, 69, 3, 2010, 'count', 6700, NULL, 6000, 7400, 6700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4660, 70, 3, 2010, 'count', 140000, NULL, 130000, 160000, 140000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4661, 71, 3, 2010, 'count', 26000, NULL, 21000, 32000, 26000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4662, 72, 3, 2010, 'count', 2000, NULL, 1800, 2300, 2000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4663, 73, 3, 2010, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4665, 75, 3, 2010, 'count', 510000, NULL, 450000, 590000, 510000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4666, 76, 3, 2010, 'count', 50000, NULL, 37000, 70000, 50000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4667, 77, 3, 2010, 'count', 4800, NULL, 4200, 5400, 4800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4668, 78, 3, 2010, 'count', 6000, NULL, 5400, 6800, 6000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4669, 79, 3, 2010, 'count', 110000, NULL, 92000, 120000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4670, 80, 3, 2010, 'count', 37000, NULL, 32000, 42000, 37000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4671, 81, 3, 2010, 'count', 19000, NULL, 16000, 22000, 19000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4672, 82, 3, 2010, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4673, 83, 3, 2010, 'count', 11000, NULL, 10000, 11000, 11000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4674, 84, 3, 2010, 'count', 1500000, NULL, 1200000, 1800000, 1500000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4675, 85, 3, 2010, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4676, 86, 3, 2010, 'count', 4100, NULL, 3200, 5500, 4100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4677, 87, 3, 2010, 'count', 9900, NULL, 8800, 11000, 9900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4678, 88, 3, 2010, 'count', 4000, NULL, 3500, 4500, 4000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4679, 89, 3, 2010, 'count', 1600, NULL, 1400, 1800, 1600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4680, 90, 3, 2010, 'count', 300000, NULL, 280000, 320000, 300000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4681, 91, 3, 2010, 'count', 41000, NULL, 37000, 46000, 41000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4682, 92, 3, 2010, 'count', 6100, NULL, 5600, 6500, 6100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4684, 94, 3, 2010, 'count', 700, NULL, 620, 780, 700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4685, 95, 3, 2010, 'count', 21000, NULL, 18000, 24000, 21000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4686, 96, 3, 2010, 'count', 870000, NULL, 770000, 960000, 870000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4687, 97, 3, 2010, 'count', 74000, NULL, 65000, 86000, 74000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4689, 99, 3, 2010, 'count', 120000, NULL, 94000, 140000, 120000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4691, 101, 3, 2010, 'count', 7100, NULL, 5900, 8400, 7100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4692, 102, 3, 2010, 'count', 11000, NULL, 9500, 12000, 11000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4693, 103, 3, 2010, 'count', 180000, NULL, 150000, 210000, 180000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4694, 104, 3, 2010, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4695, 105, 3, 2010, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4696, 106, 3, 2010, 'count', 17000, NULL, 13000, 22000, 17000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4697, 107, 3, 2010, 'count', 1600000, NULL, 1300000, 1900000, 1600000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4698, 108, 3, 2010, 'count', 220000, NULL, 190000, 260000, 220000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4699, 109, 3, 2010, 'count', 170000, NULL, 160000, 180000, 170000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4700, 110, 3, 2010, 'count', 31000, NULL, 27000, 36000, 31000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4701, 111, 3, 2010, 'count', 20000, NULL, 19000, 21000, 20000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4702, 112, 3, 2010, 'count', 2500, NULL, 2100, 2800, 2500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4703, 113, 3, 2010, 'count', 7900, NULL, 6500, 10000, 7900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4704, 114, 3, 2010, 'count', 37000, NULL, 32000, 42000, 37000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4705, 115, 3, 2010, 'count', 1500000, NULL, 1100000, 2100000, 1500000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4706, 116, 3, 2010, 'count', 4200, NULL, 3800, 4600, 4200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4707, 117, 3, 2010, 'count', 2200, NULL, 2000, 2500, 2200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4708, 118, 3, 2010, 'count', 67000, NULL, 57000, 76000, 67000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4709, 119, 3, 2010, 'count', 20000, NULL, 18000, 22000, 20000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4710, 120, 3, 2010, 'count', 38000, NULL, 34000, 42000, 38000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4711, 121, 3, 2010, 'count', 20000, NULL, 14000, 27000, 20000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4712, 122, 3, 2010, 'count', 65000, NULL, 49000, 91000, 65000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4713, 123, 3, 2010, 'count', 15000, NULL, 13000, 18000, 15000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4715, 125, 3, 2010, 'count', 40000, NULL, 35000, 45000, 40000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4718, 128, 3, 2010, 'count', 16000, NULL, 12000, 20000, 16000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4719, 129, 3, 2010, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4720, 130, 3, 2010, 'count', 14000, NULL, 12000, 15000, 14000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4722, 132, 3, 2010, 'count', 220000, NULL, 200000, 250000, 220000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4724, 134, 3, 2010, 'count', 44000, NULL, 39000, 50000, 44000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4725, 135, 3, 2010, 'count', 1800, NULL, 1300, 2200, 1800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4726, 136, 3, 2010, 'count', 58000, NULL, 48000, 70000, 58000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4727, 137, 3, 2010, 'count', 6500, NULL, 5700, 7300, 6500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4728, 138, 3, 2010, 'count', 500, NULL, 500, 730, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4730, 140, 3, 2010, 'count', 17000, NULL, 15000, 20000, 17000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4731, 141, 3, 2010, 'count', 6100000, NULL, 5500000, 6600000, 6100000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4732, 142, 3, 2010, 'count', 140000, NULL, 110000, 170000, 140000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4733, 143, 3, 2010, 'count', 140000, NULL, 120000, 150000, 140000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4734, 144, 3, 2010, 'count', 4000, NULL, 3400, 4700, 4000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4735, 145, 3, 2010, 'count', 43000, NULL, 36000, 51000, 43000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4736, 146, 3, 2010, 'count', 4600, NULL, 3300, 6200, 4600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4739, 149, 3, 2010, 'count', 570, NULL, 510, 630, 570, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4740, 150, 3, 2010, 'count', 9200, NULL, 7500, 11000, 9200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4741, 151, 3, 2010, 'count', 580000, NULL, 490000, 690000, 580000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4743, 153, 3, 2010, 'count', 100000, NULL, 96000, 110000, 100000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4745, 155, 3, 2010, 'count', 1400, NULL, 980, 2200, 1400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4748, 158, 3, 2010, 'count', 1200000, NULL, 1100000, 1300000, 1200000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4749, 159, 3, 2010, 'count', 230000, NULL, 220000, 250000, 230000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4752, 162, 3, 2010, 'count', 1300000, NULL, 1100000, 1400000, 1300000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4753, 163, 3, 2010, 'count', 990000, NULL, 880000, 1100000, 990000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4754, 164, 3, 2010, 'count', 9600, NULL, 8000, 11000, 9600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4755, 165, 3, 2010, 'count', 30000, NULL, 27000, 32000, 30000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4757, 167, 3, 2010, 'count', 220000, NULL, 180000, 250000, 220000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4758, 168, 3, 2010, 'count', 5100, NULL, 3500, 7400, 5100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4759, 169, 3, 2010, 'count', 1000000, NULL, 900000, 1100000, 1000000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4760, 170, 3, 2010, 'count', 1200000, NULL, 1100000, 1400000, 1200000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4761, 1, 3, 2005, 'count', 2900, NULL, 1700, 5000, 2900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4763, 3, 3, 2005, 'count', 3700, NULL, 3500, 4000, 3700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4764, 4, 3, 2005, 'count', 150000, NULL, 120000, 170000, 150000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4765, 5, 3, 2005, 'count', 85000, NULL, 76000, 94000, 85000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4766, 6, 3, 2005, 'count', 2700, NULL, 2000, 3500, 2700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4767, 7, 3, 2005, 'count', 16000, NULL, 14000, 19000, 16000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4770, 10, 3, 2005, 'count', 5100, NULL, 4400, 6000, 5100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4772, 12, 3, 2005, 'count', 4000, NULL, 3500, 4600, 4000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4773, 13, 3, 2005, 'count', 1700, NULL, 1500, 1900, 1700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4774, 14, 3, 2005, 'count', 5400, NULL, 4500, 6700, 5400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4776, 16, 3, 2005, 'count', 2800, NULL, 2600, 3100, 2800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4777, 17, 3, 2005, 'count', 56000, NULL, 37000, 90000, 56000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4778, 18, 3, 2005, 'count', 1100, NULL, 500, 2000, 1100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4779, 19, 3, 2005, 'count', 26000, NULL, 24000, 28000, 26000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4780, 20, 3, 2005, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4781, 21, 3, 2005, 'count', 310000, NULL, 280000, 330000, 310000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4782, 22, 3, 2005, 'count', 550000, NULL, 420000, 680000, 550000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4784, 24, 3, 2005, 'count', 980, NULL, 910, 1100, 980, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4785, 25, 3, 2005, 'count', 120000, NULL, 95000, 140000, 120000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4786, 26, 3, 2005, 'count', 110000, NULL, 88000, 120000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4787, 27, 3, 2005, 'count', 1800, NULL, 1400, 2700, 1800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4788, 28, 3, 2005, 'count', 82000, NULL, 70000, 97000, 82000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4789, 29, 3, 2005, 'count', 470000, NULL, 430000, 500000, 470000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4791, 31, 3, 2005, 'count', 150000, NULL, 130000, 170000, 150000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4792, 32, 3, 2005, 'count', 88000, NULL, 69000, 110000, 88000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4793, 33, 3, 2005, 'count', 25000, NULL, 22000, 27000, 25000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4795, 35, 3, 2005, 'count', 120000, NULL, 98000, 140000, 120000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4796, 36, 3, 2005, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4797, 37, 3, 2005, 'count', 77000, NULL, 63000, 90000, 77000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4798, 38, 3, 2005, 'count', 6500, NULL, 5800, 7200, 6500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4799, 39, 3, 2005, 'count', 510000, NULL, 410000, 650000, 510000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4800, 40, 3, 2005, 'count', 710, NULL, 630, 800, 710, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4801, 41, 3, 2005, 'count', 9000, NULL, 6700, 11000, 9000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4803, 43, 3, 2005, 'count', 970, NULL, 820, 1100, 970, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4805, 45, 3, 2005, 'count', 510000, NULL, 430000, 590000, 510000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4806, 46, 3, 2005, 'count', 4900, NULL, 4500, 5500, 4900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4807, 47, 3, 2005, 'count', 11000, NULL, 9000, 13000, 11000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4808, 48, 3, 2005, 'count', 79000, NULL, 61000, 100000, 79000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4809, 49, 3, 2005, 'count', 29000, NULL, 19000, 49000, 29000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4810, 50, 3, 2005, 'count', 3200, NULL, 2800, 3500, 3200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4811, 51, 3, 2005, 'count', 23000, NULL, 17000, 28000, 23000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4812, 52, 3, 2005, 'count', 22000, NULL, 17000, 28000, 22000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4813, 53, 3, 2005, 'count', 17000, NULL, 13000, 22000, 17000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4814, 54, 3, 2005, 'count', 5400, NULL, 4600, 6000, 5400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4815, 55, 3, 2005, 'count', 130000, NULL, 120000, 140000, 130000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4816, 56, 3, 2005, 'count', 640000, NULL, 490000, 840000, 640000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4818, 58, 3, 2005, 'count', 1900, NULL, 1500, 2400, 1900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4819, 59, 3, 2005, 'count', 110000, NULL, 95000, 130000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4820, 60, 3, 2005, 'count', 35000, NULL, 27000, 43000, 35000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4821, 61, 3, 2005, 'count', 15000, NULL, 11000, 19000, 15000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4822, 62, 3, 2005, 'count', 2800, NULL, 2300, 3400, 2800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4823, 63, 3, 2005, 'count', 56000, NULL, 46000, 65000, 56000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4824, 64, 3, 2005, 'count', 280000, NULL, 240000, 320000, 280000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4826, 66, 3, 2005, 'count', 48000, NULL, 44000, 51000, 48000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4827, 67, 3, 2005, 'count', 93000, NULL, 81000, 110000, 93000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4828, 68, 3, 2005, 'count', 31000, NULL, 28000, 35000, 31000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4829, 69, 3, 2005, 'count', 5000, NULL, 4400, 5700, 5000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4830, 70, 3, 2005, 'count', 140000, NULL, 120000, 160000, 140000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4831, 71, 3, 2005, 'count', 31000, NULL, 24000, 38000, 31000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4832, 72, 3, 2005, 'count', 1200, NULL, 1000, 1300, 1200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4833, 73, 3, 2005, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4835, 75, 3, 2005, 'count', 290000, NULL, 260000, 330000, 290000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4836, 76, 3, 2005, 'count', 37000, NULL, 25000, 56000, 37000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4837, 77, 3, 2005, 'count', 3200, NULL, 2800, 3600, 3200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4838, 78, 3, 2005, 'count', 4100, NULL, 3700, 4600, 4100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4839, 79, 3, 2005, 'count', 89000, NULL, 76000, 100000, 89000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4840, 80, 3, 2005, 'count', 38000, NULL, 33000, 42000, 38000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4841, 81, 3, 2005, 'count', 12000, NULL, 9700, 14000, 12000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4842, 82, 3, 2005, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4843, 83, 3, 2005, 'count', 4000, NULL, 3800, 4300, 4000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4844, 84, 3, 2005, 'count', 1500000, NULL, 1300000, 1900000, 1500000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4845, 85, 3, 2005, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4846, 86, 3, 2005, 'count', 1500, NULL, 1300, 1900, 1500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4847, 87, 3, 2005, 'count', 6700, NULL, 6000, 7500, 6700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4848, 88, 3, 2005, 'count', 3200, NULL, 2900, 3600, 3200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4849, 89, 3, 2005, 'count', 1300, NULL, 1100, 1400, 1300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4850, 90, 3, 2005, 'count', 280000, NULL, 260000, 300000, 280000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4851, 91, 3, 2005, 'count', 41000, NULL, 38000, 45000, 41000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4852, 92, 3, 2005, 'count', 2900, NULL, 2700, 3100, 2900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4854, 94, 3, 2005, 'count', 500, NULL, 500, 540, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4855, 95, 3, 2005, 'count', 19000, NULL, 15000, 23000, 19000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4856, 96, 3, 2005, 'count', 820000, NULL, 720000, 900000, 820000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4857, 97, 3, 2005, 'count', 66000, NULL, 57000, 77000, 66000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4859, 99, 3, 2005, 'count', 110000, NULL, 91000, 130000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4861, 101, 3, 2005, 'count', 7500, NULL, 6400, 8800, 7500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4862, 102, 3, 2005, 'count', 8000, NULL, 6100, 11000, 8000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4863, 103, 3, 2005, 'count', 150000, NULL, 120000, 200000, 150000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4864, 104, 3, 2005, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4865, 105, 3, 2005, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4866, 106, 3, 2005, 'count', 13000, NULL, 11000, 18000, 13000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4867, 107, 3, 2005, 'count', 1200000, NULL, 980000, 1500000, 1200000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4868, 108, 3, 2005, 'count', 210000, NULL, 180000, 240000, 210000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4869, 109, 3, 2005, 'count', 160000, NULL, 140000, 170000, 160000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4870, 110, 3, 2005, 'count', 29000, NULL, 25000, 33000, 29000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4871, 111, 3, 2005, 'count', 16000, NULL, 15000, 17000, 16000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4872, 112, 3, 2005, 'count', 1800, NULL, 1600, 2100, 1800, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4873, 113, 3, 2005, 'count', 6100, NULL, 4600, 8300, 6100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4874, 114, 3, 2005, 'count', 40000, NULL, 34000, 46000, 40000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4875, 115, 3, 2005, 'count', 1400000, NULL, 1000000, 1900000, 1400000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4876, 116, 3, 2005, 'count', 3000, NULL, 2700, 3300, 3000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4877, 117, 3, 2005, 'count', 1700, NULL, 1600, 1900, 1700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4878, 118, 3, 2005, 'count', 12000, NULL, 10000, 14000, 12000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4879, 119, 3, 2005, 'count', 16000, NULL, 14000, 17000, 16000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4880, 120, 3, 2005, 'count', 38000, NULL, 34000, 42000, 38000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4881, 121, 3, 2005, 'count', 19000, NULL, 14000, 25000, 19000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4882, 122, 3, 2005, 'count', 65000, NULL, 50000, 91000, 65000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4883, 123, 3, 2005, 'count', 3700, NULL, 3100, 4300, 3700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4885, 125, 3, 2005, 'count', 37000, NULL, 33000, 42000, 37000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4888, 128, 3, 2005, 'count', 12000, NULL, 9600, 16000, 12000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4889, 129, 3, 2005, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4890, 130, 3, 2005, 'count', 11000, NULL, 9800, 12000, 11000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4892, 132, 3, 2005, 'count', 220000, NULL, 190000, 250000, 220000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4894, 134, 3, 2005, 'count', 42000, NULL, 38000, 48000, 42000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4895, 135, 3, 2005, 'count', 1100, NULL, 750, 1500, 1100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4896, 136, 3, 2005, 'count', 51000, NULL, 42000, 61000, 51000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4897, 137, 3, 2005, 'count', 4100, NULL, 3500, 4700, 4100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4898, 138, 3, 2005, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4900, 140, 3, 2005, 'count', 20000, NULL, 18000, 23000, 20000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4901, 141, 3, 2005, 'count', 5000000, NULL, 4400000, 5400000, 5000000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4902, 142, 3, 2005, 'count', 120000, NULL, 89000, 150000, 120000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4903, 143, 3, 2005, 'count', 120000, NULL, 100000, 130000, 120000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4904, 144, 3, 2005, 'count', 3600, NULL, 3100, 4100, 3600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4905, 145, 3, 2005, 'count', 29000, NULL, 20000, 40000, 29000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4906, 146, 3, 2005, 'count', 4000, NULL, 3000, 5600, 4000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4909, 149, 3, 2005, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4910, 150, 3, 2005, 'count', 5200, NULL, 3700, 6900, 5200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4911, 151, 3, 2005, 'count', 630000, NULL, 510000, 780000, 630000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4913, 153, 3, 2005, 'count', 100000, NULL, 94000, 110000, 100000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4915, 155, 3, 2005, 'count', 640, NULL, 500, 1100, 640, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4918, 158, 3, 2005, 'count', 1100000, NULL, 1000000, 1100000, 1100000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4919, 159, 3, 2005, 'count', 230000, NULL, 220000, 240000, 230000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4922, 162, 3, 2005, 'count', 1200000, NULL, 1000000, 1300000, 1200000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4924, 164, 3, 2005, 'count', 7600, NULL, 6200, 10000, 7600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4925, 165, 3, 2005, 'count', 21000, NULL, 19000, 23000, 21000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4927, 167, 3, 2005, 'count', 180000, NULL, 160000, 210000, 180000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4928, 168, 3, 2005, 'count', 2400, NULL, 1500, 4000, 2400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4929, 169, 3, 2005, 'count', 920000, NULL, 820000, 1000000, 920000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4930, 170, 3, 2005, 'count', 1400000, NULL, 1200000, 1600000, 1400000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4931, 1, 3, 2000, 'count', 1600, NULL, 1000, 3500, 1600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4933, 3, 3, 2000, 'count', 1900, NULL, 1700, 2000, 1900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4934, 4, 3, 2000, 'count', 87000, NULL, 72000, 110000, 87000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4935, 5, 3, 2000, 'count', 64000, NULL, 55000, 71000, 64000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4936, 6, 3, 2000, 'count', 950, NULL, 580, 1600, 950, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4937, 7, 3, 2000, 'count', 13000, NULL, 11000, 15000, 13000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4940, 10, 3, 2000, 'count', 5100, NULL, 4400, 5900, 5100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4942, 12, 3, 2000, 'count', 940, NULL, 800, 1100, 940, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4943, 13, 3, 2000, 'count', 1100, NULL, 1000, 1300, 1100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4944, 14, 3, 2000, 'count', 1400, NULL, 1100, 1900, 1400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4946, 16, 3, 2000, 'count', 1700, NULL, 1600, 1800, 1700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4947, 17, 3, 2000, 'count', 47000, NULL, 31000, 75000, 47000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4948, 18, 3, 2000, 'count', 530, NULL, 200, 970, 530, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4949, 19, 3, 2000, 'count', 21000, NULL, 20000, 23000, 21000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4950, 20, 3, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4951, 21, 3, 2000, 'count', 280000, NULL, 270000, 300000, 280000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4952, 22, 3, 2000, 'count', 410000, NULL, 320000, 510000, 410000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4954, 24, 3, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4955, 25, 3, 2000, 'count', 140000, NULL, 110000, 170000, 140000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4956, 26, 3, 2000, 'count', 130000, NULL, 110000, 150000, 130000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4957, 27, 3, 2000, 'count', 1600, NULL, 1200, 2500, 1600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4958, 28, 3, 2000, 'count', 81000, NULL, 73000, 91000, 81000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4959, 29, 3, 2000, 'count', 370000, NULL, 350000, 410000, 370000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4961, 31, 3, 2000, 'count', 160000, NULL, 130000, 190000, 160000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4962, 32, 3, 2000, 'count', 80000, NULL, 60000, 100000, 80000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4963, 33, 3, 2000, 'count', 14000, NULL, 13000, 16000, 14000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4965, 35, 3, 2000, 'count', 110000, NULL, 91000, 130000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4966, 36, 3, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4967, 37, 3, 2000, 'count', 80000, NULL, 64000, 96000, 80000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4968, 38, 3, 2000, 'count', 4300, NULL, 3700, 4700, 4300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4969, 39, 3, 2000, 'count', 590000, NULL, 470000, 740000, 590000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4970, 40, 3, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4971, 41, 3, 2000, 'count', 4100, NULL, 2900, 5000, 4100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4973, 43, 3, 2000, 'count', 510, NULL, 500, 580, 510, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4975, 45, 3, 2000, 'count', 540000, NULL, 470000, 610000, 540000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4976, 46, 3, 2000, 'count', 4000, NULL, 3600, 4600, 4000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4977, 47, 3, 2000, 'count', 9400, NULL, 7200, 12000, 9400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4978, 48, 3, 2000, 'count', 85000, NULL, 62000, 120000, 85000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4979, 49, 3, 2000, 'count', 26000, NULL, 15000, 46000, 26000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4980, 50, 3, 2000, 'count', 1500, NULL, 1400, 1600, 1500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4981, 51, 3, 2000, 'count', 18000, NULL, 14000, 23000, 18000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4982, 52, 3, 2000, 'count', 13000, NULL, 9200, 18000, 13000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4983, 53, 3, 2000, 'count', 16000, NULL, 12000, 20000, 16000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4984, 54, 3, 2000, 'count', 3400, NULL, 2900, 3900, 3400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4985, 55, 3, 2000, 'count', 110000, NULL, 98000, 120000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4986, 56, 3, 2000, 'count', 750000, NULL, 570000, 980000, 750000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4988, 58, 3, 2000, 'count', 1100, NULL, 850, 1400, 1100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4989, 59, 3, 2000, 'count', 82000, NULL, 69000, 97000, 82000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4990, 60, 3, 2000, 'count', 28000, NULL, 20000, 38000, 28000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4991, 61, 3, 2000, 'count', 9900, NULL, 7200, 13000, 9900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4992, 62, 3, 2000, 'count', 980, NULL, 720, 1300, 980, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4993, 63, 3, 2000, 'count', 45000, NULL, 37000, 54000, 45000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4994, 64, 3, 2000, 'count', 270000, NULL, 240000, 300000, 270000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4996, 66, 3, 2000, 'count', 44000, NULL, 41000, 47000, 44000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4997, 67, 3, 2000, 'count', 83000, NULL, 67000, 100000, 83000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4998, 68, 3, 2000, 'count', 22000, NULL, 20000, 25000, 22000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (4999, 69, 3, 2000, 'count', 2300, NULL, 1600, 3100, 2300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5000, 70, 3, 2000, 'count', 150000, NULL, 130000, 180000, 150000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5001, 71, 3, 2000, 'count', 40000, NULL, 34000, 49000, 40000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5002, 72, 3, 2000, 'count', 830, NULL, 700, 950, 830, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5003, 73, 3, 2000, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5005, 75, 3, 2000, 'count', 80000, NULL, 72000, 89000, 80000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5006, 76, 3, 2000, 'count', 16000, NULL, 7900, 35000, 16000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5007, 77, 3, 2000, 'count', 1900, NULL, 1700, 2200, 1900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5008, 78, 3, 2000, 'count', 2700, NULL, 2400, 3100, 2700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5009, 79, 3, 2000, 'count', 68000, NULL, 57000, 78000, 68000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5010, 80, 3, 2000, 'count', 41000, NULL, 37000, 46000, 41000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5011, 81, 3, 2000, 'count', 6200, NULL, 5100, 7200, 6200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5012, 82, 3, 2000, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5013, 83, 3, 2000, 'count', 1100, NULL, 1100, 1200, 1100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5014, 84, 3, 2000, 'count', 1700000, NULL, 1400000, 2000000, 1700000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5015, 85, 3, 2000, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5016, 86, 3, 2000, 'count', 710, NULL, 580, 840, 710, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5017, 87, 3, 2000, 'count', 2200, NULL, 2000, 2400, 2200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5018, 88, 3, 2000, 'count', 2300, NULL, 2200, 2500, 2300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5019, 89, 3, 2000, 'count', 910, NULL, 790, 1000, 910, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5020, 90, 3, 2000, 'count', 260000, NULL, 240000, 290000, 260000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5021, 91, 3, 2000, 'count', 43000, NULL, 41000, 45000, 43000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5022, 92, 3, 2000, 'count', 950, NULL, 870, 1000, 950, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5024, 94, 3, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5025, 95, 3, 2000, 'count', 13000, NULL, 7900, 20000, 13000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5026, 96, 3, 2000, 'count', 810000, NULL, 740000, 860000, 810000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5027, 97, 3, 2000, 'count', 55000, NULL, 48000, 65000, 55000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5029, 99, 3, 2000, 'count', 110000, NULL, 91000, 130000, 110000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5031, 101, 3, 2000, 'count', 5500, NULL, 4500, 6500, 5500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5032, 102, 3, 2000, 'count', 3200, NULL, 1500, 6000, 3200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5033, 103, 3, 2000, 'count', 130000, NULL, 94000, 190000, 130000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5034, 104, 3, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5035, 105, 3, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5036, 106, 3, 2000, 'count', 9700, NULL, 7800, 13000, 9700, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5037, 107, 3, 2000, 'count', 840000, NULL, 670000, 1000000, 840000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5038, 108, 3, 2000, 'count', 150000, NULL, 130000, 170000, 150000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5039, 109, 3, 2000, 'count', 140000, NULL, 130000, 160000, 140000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5040, 110, 3, 2000, 'count', 16000, NULL, 14000, 17000, 16000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5041, 111, 3, 2000, 'count', 11000, NULL, 11000, 12000, 11000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5042, 112, 3, 2000, 'count', 1300, NULL, 1100, 1500, 1300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5043, 113, 3, 2000, 'count', 3600, NULL, 2100, 5300, 3600, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5044, 114, 3, 2000, 'count', 37000, NULL, 31000, 44000, 37000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5045, 115, 3, 2000, 'count', 1300000, NULL, 940000, 1700000, 1300000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5046, 116, 3, 2000, 'count', 1900, NULL, 1700, 2100, 1900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5047, 117, 3, 2000, 'count', 1300, NULL, 1100, 1400, 1300, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5048, 118, 3, 2000, 'count', 500, NULL, 500, 520, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5049, 119, 3, 2000, 'count', 11000, NULL, 10000, 12000, 11000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5050, 120, 3, 2000, 'count', 20000, NULL, 17000, 25000, 20000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5051, 121, 3, 2000, 'count', 14000, NULL, 7100, 21000, 14000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5052, 122, 3, 2000, 'count', 71000, NULL, 56000, 94000, 71000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5053, 123, 3, 2000, 'count', 1000, NULL, 910, 1200, 1000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5055, 125, 3, 2000, 'count', 32000, NULL, 27000, 37000, 32000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5058, 128, 3, 2000, 'count', 10000, NULL, 8000, 13000, 10000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5059, 129, 3, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5060, 130, 3, 2000, 'count', 7500, NULL, 6900, 8100, 7500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5062, 132, 3, 2000, 'count', 240000, NULL, 220000, 280000, 240000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5064, 134, 3, 2000, 'count', 33000, NULL, 29000, 39000, 33000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5065, 135, 3, 2000, 'count', 1000, NULL, 660, 1400, 1000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5066, 136, 3, 2000, 'count', 40000, NULL, 31000, 50000, 40000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5067, 137, 3, 2000, 'count', 2900, NULL, 2600, 3300, 2900, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5068, 138, 3, 2000, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5070, 140, 3, 2000, 'count', 16000, NULL, 14000, 20000, 16000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5071, 141, 3, 2000, 'count', 3300000, NULL, 2900000, 3700000, 3300000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5072, 142, 3, 2000, 'count', 90000, NULL, 56000, 120000, 90000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5073, 143, 3, 2000, 'count', 92000, NULL, 78000, 110000, 92000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5074, 144, 3, 2000, 'count', 2200, NULL, 1900, 2400, 2200, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5075, 145, 3, 2000, 'count', 15000, NULL, 7500, 29000, 15000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5076, 146, 3, 2000, 'count', 3100, NULL, 2300, 4400, 3100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5079, 149, 3, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5080, 150, 3, 2000, 'count', 1400, NULL, 780, 2700, 1400, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5081, 151, 3, 2000, 'count', 740000, NULL, 610000, 890000, 740000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5083, 153, 3, 2000, 'count', 94000, NULL, 87000, 100000, 94000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5085, 155, 3, 2000, 'count', 500, NULL, 200, 710, 500, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5088, 158, 3, 2000, 'count', 1000000, NULL, 930000, 1100000, 1000000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5089, 159, 3, 2000, 'count', 170000, NULL, 150000, 180000, 170000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5092, 162, 3, 2000, 'count', 1100000, NULL, 1000000, 1200000, 1100000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5094, 164, 3, 2000, 'count', 6000, NULL, 4200, 12000, 6000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5095, 165, 3, 2000, 'count', 14000, NULL, 13000, 16000, 14000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5097, 167, 3, 2000, 'count', 120000, NULL, 110000, 130000, 120000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5098, 168, 3, 2000, 'count', 1100, NULL, 680, 2500, 1100, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5099, 169, 3, 2000, 'count', 890000, NULL, 800000, 1000000, 890000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5100, 170, 3, 2000, 'count', 1600000, NULL, 1400000, 1900000, 1600000, 'good', 'no_of_people_living_with_hiv_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5101, 1, 4, 2018, 'count', 500, NULL, 200, 610, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5103, 3, 4, 2018, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5104, 4, 4, 2018, 'count', 14000, NULL, 9500, 18000, 14000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5105, 5, 4, 2018, 'count', 1700, NULL, 1300, 2100, 1700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5106, 6, 4, 2018, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5107, 7, 4, 2018, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5110, 10, 4, 2018, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5112, 12, 4, 2018, 'count', 580, NULL, 500, 680, 580, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5113, 13, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5114, 14, 4, 2018, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5116, 16, 4, 2018, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5117, 17, 4, 2018, 'count', 2200, NULL, 1100, 4400, 2200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5118, 18, 4, 2018, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5119, 19, 4, 2018, 'count', 670, NULL, 550, 760, 670, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5120, 20, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5121, 21, 4, 2018, 'count', 4800, NULL, 4100, 5700, 4800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5122, 22, 4, 2018, 'count', 15000, NULL, 11000, 19000, 15000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5124, 24, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5125, 25, 4, 2018, 'count', 3300, NULL, 2400, 4400, 3300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5126, 26, 4, 2018, 'count', 1900, NULL, 1400, 2500, 1900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5127, 27, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5128, 28, 4, 2018, 'count', 1300, NULL, 920, 1900, 1300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5129, 29, 4, 2018, 'count', 18000, NULL, 15000, 21000, 18000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5131, 31, 4, 2018, 'count', 4800, NULL, 3700, 6400, 4800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5132, 32, 4, 2018, 'count', 3100, NULL, 2000, 4500, 3100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5133, 33, 4, 2018, 'count', 590, NULL, 500, 770, 590, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5136, 36, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5137, 37, 4, 2018, 'count', 4000, NULL, 2800, 5400, 4000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5138, 38, 4, 2018, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5139, 39, 4, 2018, 'count', 16000, NULL, 11000, 23000, 16000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5140, 40, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5141, 41, 4, 2018, 'count', 500, NULL, 500, 580, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5143, 43, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5145, 45, 4, 2018, 'count', 13000, NULL, 10000, 17000, 13000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5146, 46, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5147, 47, 4, 2018, 'count', 500, NULL, 500, 550, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5148, 48, 4, 2018, 'count', 1200, NULL, 750, 1900, 1200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5149, 49, 4, 2018, 'count', 620, NULL, 500, 1500, 620, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5150, 50, 4, 2018, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5151, 51, 4, 2018, 'count', 700, NULL, 500, 1000, 700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5152, 52, 4, 2018, 'count', 1800, NULL, 1200, 2600, 1800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5153, 53, 4, 2018, 'count', 500, NULL, 500, 890, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5154, 54, 4, 2018, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5155, 55, 4, 2018, 'count', 2400, NULL, 2000, 2900, 2400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5156, 56, 4, 2018, 'count', 11000, NULL, 6800, 19000, 11000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5158, 58, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5159, 59, 4, 2018, 'count', 500, NULL, 500, 540, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5160, 60, 4, 2018, 'count', 1200, NULL, 790, 1700, 1200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5161, 61, 4, 2018, 'count', 980, NULL, 650, 1400, 980, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5162, 62, 4, 2018, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5163, 63, 4, 2018, 'count', 500, NULL, 500, 670, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5164, 64, 4, 2018, 'count', 14000, NULL, 11000, 18000, 14000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5166, 66, 4, 2018, 'count', 2200, NULL, 2000, 2400, 2200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5167, 67, 4, 2018, 'count', 4300, NULL, 3300, 5400, 4300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5168, 68, 4, 2018, 'count', 1800, NULL, 1400, 2100, 1800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5169, 69, 4, 2018, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5170, 70, 4, 2018, 'count', 2700, NULL, 2200, 3600, 2700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5171, 71, 4, 2018, 'count', 780, NULL, 540, 1100, 780, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5172, 72, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5173, 73, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5175, 75, 4, 2018, 'count', 38000, NULL, 33000, 43000, 38000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5176, 76, 4, 2018, 'count', 2600, NULL, 1400, 5100, 2600, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5177, 77, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5178, 78, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5179, 79, 4, 2018, 'count', 710, NULL, 510, 930, 710, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5180, 80, 4, 2018, 'count', 1500, NULL, 1300, 1800, 1500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5182, 82, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5183, 83, 4, 2018, 'count', 500, NULL, 500, 530, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5184, 84, 4, 2018, 'count', 25000, NULL, 18000, 38000, 25000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5185, 85, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5186, 86, 4, 2018, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5187, 87, 4, 2018, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5188, 88, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5189, 89, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5190, 90, 4, 2018, 'count', 6100, NULL, 5000, 7600, 6100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5191, 91, 4, 2018, 'count', 1800, NULL, 1700, 1900, 1800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5192, 92, 4, 2018, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5194, 94, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5195, 95, 4, 2018, 'count', 1700, NULL, 1200, 2300, 1700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5196, 96, 4, 2018, 'count', 13000, NULL, 11000, 16000, 13000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5197, 97, 4, 2018, 'count', 2600, NULL, 2100, 3300, 2600, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5199, 99, 4, 2018, 'count', 6500, NULL, 5000, 8700, 6500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5201, 101, 4, 2018, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5202, 102, 4, 2018, 'count', 610, NULL, 500, 820, 610, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5204, 104, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5205, 105, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5206, 106, 4, 2018, 'count', 500, NULL, 500, 600, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5207, 107, 4, 2018, 'count', 54000, NULL, 39000, 73000, 54000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5208, 108, 4, 2018, 'count', 7800, NULL, 5900, 11000, 7800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5209, 109, 4, 2018, 'count', 2700, NULL, 2300, 3200, 2700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5210, 110, 4, 2018, 'count', 910, NULL, 700, 1200, 910, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5212, 112, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5213, 113, 4, 2018, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5214, 114, 4, 2018, 'count', 1200, NULL, 970, 1700, 1200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5215, 115, 4, 2018, 'count', 53000, NULL, 31000, 89000, 53000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5216, 116, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5217, 117, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5218, 118, 4, 2018, 'count', 6400, NULL, 5200, 7600, 6400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5219, 119, 4, 2018, 'count', 500, NULL, 500, 530, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5221, 121, 4, 2018, 'count', 720, NULL, 500, 1200, 720, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5222, 122, 4, 2018, 'count', 1000, NULL, 650, 1900, 1000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5223, 123, 4, 2018, 'count', 1200, NULL, 800, 1700, 1200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5225, 125, 4, 2018, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5228, 128, 4, 2018, 'count', 570, NULL, 500, 860, 570, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5229, 129, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5230, 130, 4, 2018, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5232, 132, 4, 2018, 'count', 2900, NULL, 2400, 3500, 2900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5234, 134, 4, 2018, 'count', 1300, NULL, 1000, 1600, 1300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5235, 135, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5236, 136, 4, 2018, 'count', 2100, NULL, 1600, 2800, 2100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5237, 137, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5238, 138, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5239, 139, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5240, 140, 4, 2018, 'count', 710, NULL, 530, 1000, 710, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5241, 141, 4, 2018, 'count', 71000, NULL, 52000, 91000, 71000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5242, 142, 4, 2018, 'count', 9900, NULL, 6900, 13000, 9900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5244, 144, 4, 2018, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5245, 145, 4, 2018, 'count', 2900, NULL, 1400, 5200, 2900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5246, 146, 4, 2018, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5249, 149, 4, 2018, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5250, 150, 4, 2018, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5251, 151, 4, 2018, 'count', 18000, NULL, 13000, 26000, 18000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5253, 153, 4, 2018, 'count', 3800, NULL, 3300, 4200, 3800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5255, 155, 4, 2018, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5258, 158, 4, 2018, 'count', 23000, NULL, 19000, 31000, 23000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5259, 159, 4, 2018, 'count', 6100, NULL, 4700, 8000, 6100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5262, 162, 4, 2018, 'count', 24000, NULL, 20000, 29000, 24000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5264, 164, 4, 2018, 'count', 200, NULL, 100, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5265, 165, 4, 2018, 'count', 1300, NULL, 1100, 1500, 1300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5267, 167, 4, 2018, 'count', 4700, NULL, 3200, 6200, 4700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5268, 168, 4, 2018, 'count', 500, NULL, 200, 520, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5269, 169, 4, 2018, 'count', 17000, NULL, 13000, 22000, 17000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5270, 170, 4, 2018, 'count', 22000, NULL, 17000, 27000, 22000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5271, 1, 4, 2010, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5273, 3, 4, 2010, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5274, 4, 4, 2010, 'count', 10000, NULL, 7300, 13000, 10000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5275, 5, 4, 2010, 'count', 1600, NULL, 1300, 2000, 1600, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5276, 6, 4, 2010, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5277, 7, 4, 2010, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5280, 10, 4, 2010, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5282, 12, 4, 2010, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5283, 13, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5284, 14, 4, 2010, 'count', 200, NULL, 100, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5286, 16, 4, 2010, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5287, 17, 4, 2010, 'count', 2000, NULL, 980, 4100, 2000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5288, 18, 4, 2010, 'count', 100, NULL, 100, 500, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5289, 19, 4, 2010, 'count', 1600, NULL, 1500, 1800, 1600, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5290, 20, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5291, 21, 4, 2010, 'count', 7300, NULL, 6500, 8000, 7300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5292, 22, 4, 2010, 'count', 15000, NULL, 11000, 19000, 15000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5294, 24, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5295, 25, 4, 2010, 'count', 4800, NULL, 3600, 6300, 4800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5296, 26, 4, 2010, 'count', 5200, NULL, 4100, 6400, 5200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5297, 27, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5298, 28, 4, 2010, 'count', 2500, NULL, 1900, 3400, 2500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5299, 29, 4, 2010, 'count', 22000, NULL, 19000, 25000, 22000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5301, 31, 4, 2010, 'count', 7800, NULL, 6400, 9400, 7800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5302, 32, 4, 2010, 'count', 3500, NULL, 2600, 4800, 3500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5306, 36, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5307, 37, 4, 2010, 'count', 3900, NULL, 3100, 4800, 3900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5308, 38, 4, 2010, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5309, 39, 4, 2010, 'count', 24000, NULL, 17000, 34000, 24000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5310, 40, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5311, 41, 4, 2010, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5313, 43, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5315, 45, 4, 2010, 'count', 34000, NULL, 27000, 40000, 34000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5316, 46, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5317, 47, 4, 2010, 'count', 630, NULL, 500, 780, 630, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5318, 48, 4, 2010, 'count', 3000, NULL, 2100, 4300, 3000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5319, 49, 4, 2010, 'count', 1100, NULL, 520, 2200, 1100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5320, 50, 4, 2010, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5321, 51, 4, 2010, 'count', 500, NULL, 500, 730, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5322, 52, 4, 2010, 'count', 1400, NULL, 970, 1900, 1400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5323, 53, 4, 2010, 'count', 620, NULL, 500, 980, 620, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5324, 54, 4, 2010, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5325, 55, 4, 2010, 'count', 3800, NULL, 3400, 4200, 3800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5326, 56, 4, 2010, 'count', 20000, NULL, 12000, 35000, 20000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5328, 58, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5329, 59, 4, 2010, 'count', 600, NULL, 500, 780, 600, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5330, 60, 4, 2010, 'count', 1600, NULL, 1100, 2100, 1600, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5331, 61, 4, 2010, 'count', 970, NULL, 660, 1400, 970, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5332, 62, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5333, 63, 4, 2010, 'count', 500, NULL, 500, 720, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5334, 64, 4, 2010, 'count', 17000, NULL, 14000, 19000, 17000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5336, 66, 4, 2010, 'count', 1700, NULL, 1500, 1900, 1700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5337, 67, 4, 2010, 'count', 4100, NULL, 3300, 5000, 4100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5338, 68, 4, 2010, 'count', 1900, NULL, 1500, 2200, 1900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5339, 69, 4, 2010, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5340, 70, 4, 2010, 'count', 4900, NULL, 3800, 6600, 4900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5341, 71, 4, 2010, 'count', 1400, NULL, 990, 1800, 1400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5342, 72, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5343, 73, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5345, 75, 4, 2010, 'count', 24000, NULL, 19000, 28000, 24000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5346, 76, 4, 2010, 'count', 2400, NULL, 1700, 3500, 2400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5347, 77, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5348, 78, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5349, 79, 4, 2010, 'count', 830, NULL, 620, 1100, 830, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5350, 80, 4, 2010, 'count', 1800, NULL, 1500, 2100, 1800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5352, 82, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5353, 83, 4, 2010, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5354, 84, 4, 2010, 'count', 56000, NULL, 41000, 86000, 56000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5355, 85, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5356, 86, 4, 2010, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5357, 87, 4, 2010, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5358, 88, 4, 2010, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5359, 89, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5360, 90, 4, 2010, 'count', 7200, NULL, 5600, 10000, 7200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5361, 91, 4, 2010, 'count', 2700, NULL, 2600, 2900, 2700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5362, 92, 4, 2010, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5364, 94, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5365, 95, 4, 2010, 'count', 1400, NULL, 1000, 1700, 1400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5366, 96, 4, 2010, 'count', 29000, NULL, 25000, 33000, 29000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5367, 97, 4, 2010, 'count', 2900, NULL, 2400, 3300, 2900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5369, 99, 4, 2010, 'count', 5300, NULL, 4100, 6700, 5300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5371, 101, 4, 2010, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5372, 102, 4, 2010, 'count', 500, NULL, 500, 680, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5374, 104, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5375, 105, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5376, 106, 4, 2010, 'count', 550, NULL, 500, 840, 550, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5377, 107, 4, 2010, 'count', 64000, NULL, 46000, 87000, 64000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5378, 108, 4, 2010, 'count', 11000, NULL, 9600, 13000, 11000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5379, 109, 4, 2010, 'count', 3500, NULL, 3000, 3900, 3500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5380, 110, 4, 2010, 'count', 1400, NULL, 1200, 1700, 1400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5381, 111, 4, 2010, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5382, 112, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5383, 113, 4, 2010, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5384, 114, 4, 2010, 'count', 1700, NULL, 1300, 2100, 1700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5385, 115, 4, 2010, 'count', 72000, NULL, 42000, 120000, 72000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5386, 116, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5387, 117, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5388, 118, 4, 2010, 'count', 1400, NULL, 870, 1900, 1400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5389, 119, 4, 2010, 'count', 500, NULL, 500, 570, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5391, 121, 4, 2010, 'count', 790, NULL, 540, 1200, 790, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5392, 122, 4, 2010, 'count', 2100, NULL, 1400, 3300, 2100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5393, 123, 4, 2010, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5395, 125, 4, 2010, 'count', 930, NULL, 730, 1200, 930, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5398, 128, 4, 2010, 'count', 740, NULL, 510, 1100, 740, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5399, 129, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5400, 130, 4, 2010, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5402, 132, 4, 2010, 'count', 5700, NULL, 4700, 7100, 5700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5404, 134, 4, 2010, 'count', 1300, NULL, 1000, 1800, 1300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5405, 135, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5406, 136, 4, 2010, 'count', 2900, NULL, 2400, 3600, 2900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5407, 137, 4, 2010, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5408, 138, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5409, 139, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5410, 140, 4, 2010, 'count', 1400, NULL, 1200, 1700, 1400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5411, 141, 4, 2010, 'count', 140000, NULL, 110000, 170000, 140000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5412, 142, 4, 2010, 'count', 9800, NULL, 7300, 13000, 9800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5413, 143, 4, 2010, 'count', 1300, NULL, 1100, 1700, 1300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5414, 144, 4, 2010, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5415, 145, 4, 2010, 'count', 1900, NULL, 1300, 2600, 1900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5416, 146, 4, 2010, 'count', 200, NULL, 100, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5419, 149, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5420, 150, 4, 2010, 'count', 500, NULL, 500, 560, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5421, 151, 4, 2010, 'count', 27000, NULL, 19000, 36000, 27000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5423, 153, 4, 2010, 'count', 5700, NULL, 5100, 6300, 5700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5425, 155, 4, 2010, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5428, 158, 4, 2010, 'count', 56000, NULL, 48000, 66000, 56000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5429, 159, 4, 2010, 'count', 12000, NULL, 10000, 15000, 12000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5432, 162, 4, 2010, 'count', 48000, NULL, 42000, 53000, 48000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5434, 164, 4, 2010, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5435, 165, 4, 2010, 'count', 1800, NULL, 1700, 1900, 1800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5437, 167, 4, 2010, 'count', 8500, NULL, 6400, 9800, 8500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5438, 168, 4, 2010, 'count', 200, NULL, 100, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5439, 169, 4, 2010, 'count', 26000, NULL, 21000, 35000, 26000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5440, 170, 4, 2010, 'count', 54000, NULL, 43000, 68000, 54000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5441, 1, 4, 2000, 'count', 100, NULL, 100, 500, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5443, 3, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5444, 4, 4, 2000, 'count', 4800, NULL, 3500, 6400, 4800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5445, 5, 4, 2000, 'count', 1400, NULL, 1200, 1700, 1400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5446, 6, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5447, 7, 4, 2000, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5450, 10, 4, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5452, 12, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5453, 13, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5454, 14, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5456, 16, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5457, 17, 4, 2000, 'count', 2400, NULL, 1200, 4900, 2400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5458, 18, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5459, 19, 4, 2000, 'count', 670, NULL, 500, 830, 670, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5460, 20, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5461, 21, 4, 2000, 'count', 15000, NULL, 13000, 18000, 15000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5462, 22, 4, 2000, 'count', 15000, NULL, 11000, 20000, 15000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5464, 24, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5465, 25, 4, 2000, 'count', 12000, NULL, 9300, 15000, 12000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5466, 26, 4, 2000, 'count', 11000, NULL, 7800, 13000, 11000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5467, 27, 4, 2000, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5468, 28, 4, 2000, 'count', 4500, NULL, 3200, 5800, 4500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5469, 29, 4, 2000, 'count', 19000, NULL, 15000, 24000, 19000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5471, 31, 4, 2000, 'count', 11000, NULL, 8400, 14000, 11000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5472, 32, 4, 2000, 'count', 5600, NULL, 3800, 7700, 5600, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5476, 36, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5477, 37, 4, 2000, 'count', 6100, NULL, 4700, 7800, 6100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5478, 38, 4, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5479, 39, 4, 2000, 'count', 44000, NULL, 32000, 63000, 44000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5480, 40, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5481, 41, 4, 2000, 'count', 200, NULL, 200, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5483, 43, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5485, 45, 4, 2000, 'count', 43000, NULL, 35000, 49000, 43000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5486, 46, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5487, 47, 4, 2000, 'count', 500, NULL, 500, 690, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5488, 48, 4, 2000, 'count', 4800, NULL, 3100, 7100, 4800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5489, 49, 4, 2000, 'count', 1500, NULL, 620, 2600, 1500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5490, 50, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5491, 51, 4, 2000, 'count', 810, NULL, 580, 1000, 810, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5492, 52, 4, 2000, 'count', 680, NULL, 500, 1000, 680, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5493, 53, 4, 2000, 'count', 1100, NULL, 690, 1500, 1100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5494, 54, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5495, 55, 4, 2000, 'count', 5000, NULL, 4000, 6100, 5000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5496, 56, 4, 2000, 'count', 58000, NULL, 35000, 100000, 58000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5498, 58, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5499, 59, 4, 2000, 'count', 880, NULL, 720, 1000, 880, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5500, 60, 4, 2000, 'count', 1600, NULL, 1100, 2300, 1600, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5501, 61, 4, 2000, 'count', 500, NULL, 500, 620, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5502, 62, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5503, 63, 4, 2000, 'count', 880, NULL, 690, 1100, 880, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5504, 64, 4, 2000, 'count', 18000, NULL, 15000, 22000, 18000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5506, 66, 4, 2000, 'count', 2400, NULL, 2000, 2700, 2400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5507, 67, 4, 2000, 'count', 5000, NULL, 3400, 7000, 5000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5508, 68, 4, 2000, 'count', 1100, NULL, 850, 1400, 1100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5509, 69, 4, 2000, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5510, 70, 4, 2000, 'count', 12000, NULL, 9400, 15000, 12000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5511, 71, 4, 2000, 'count', 3200, NULL, 2300, 4000, 3200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5512, 72, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5513, 73, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5515, 75, 4, 2000, 'count', 1900, NULL, 1200, 2500, 1900, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5516, 76, 4, 2000, 'count', 500, NULL, 500, 1400, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5517, 77, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5518, 78, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5519, 79, 4, 2000, 'count', 1200, NULL, 1000, 1500, 1200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5520, 80, 4, 2000, 'count', 2400, NULL, 1900, 3100, 2400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5522, 82, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5523, 83, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5524, 84, 4, 2000, 'count', 120000, NULL, 88000, 190000, 120000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5525, 85, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5526, 86, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5527, 87, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5528, 88, 4, 2000, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5529, 89, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5530, 90, 4, 2000, 'count', 12000, NULL, 9000, 16000, 12000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5531, 91, 4, 2000, 'count', 3000, NULL, 2600, 3400, 3000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5532, 92, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5534, 94, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5535, 95, 4, 2000, 'count', 500, NULL, 200, 930, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5536, 96, 4, 2000, 'count', 57000, NULL, 49000, 65000, 57000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5537, 97, 4, 2000, 'count', 2700, NULL, 2200, 3200, 2700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5539, 99, 4, 2000, 'count', 7700, NULL, 5600, 9800, 7700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5541, 101, 4, 2000, 'count', 500, NULL, 200, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5542, 102, 4, 2000, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5544, 104, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5545, 105, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5546, 106, 4, 2000, 'count', 500, NULL, 500, 680, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5547, 107, 4, 2000, 'count', 40000, NULL, 29000, 54000, 40000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5548, 108, 4, 2000, 'count', 5800, NULL, 4600, 6800, 5800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5549, 109, 4, 2000, 'count', 7300, NULL, 5700, 9100, 7300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5550, 110, 4, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5551, 111, 4, 2000, 'count', 200, NULL, 200, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5552, 112, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5553, 113, 4, 2000, 'count', 100, NULL, 100, 500, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5554, 114, 4, 2000, 'count', 2300, NULL, 1700, 3000, 2300, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5555, 115, 4, 2000, 'count', 78000, NULL, 45000, 130000, 78000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5556, 116, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5557, 117, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5558, 118, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5559, 119, 4, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5561, 121, 4, 2000, 'count', 500, NULL, 200, 920, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5562, 122, 4, 2000, 'count', 5100, NULL, 3800, 7000, 5100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5563, 123, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5565, 125, 4, 2000, 'count', 1100, NULL, 890, 1400, 1100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5568, 128, 4, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5569, 129, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5570, 130, 4, 2000, 'count', 500, NULL, 500, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5572, 132, 4, 2000, 'count', 18000, NULL, 14000, 22000, 18000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5574, 134, 4, 2000, 'count', 1700, NULL, 1300, 2300, 1700, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5575, 135, 4, 2000, 'count', 200, NULL, 100, 200, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5576, 136, 4, 2000, 'count', 2400, NULL, 1600, 3300, 2400, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5578, 138, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5579, 139, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5580, 140, 4, 2000, 'count', 810, NULL, 560, 1100, 810, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5581, 141, 4, 2000, 'count', 100000, NULL, 68000, 140000, 100000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5582, 142, 4, 2000, 'count', 5100, NULL, 2600, 7500, 5100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5583, 143, 4, 2000, 'count', 1800, NULL, 1500, 2300, 1800, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5584, 144, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5585, 145, 4, 2000, 'count', 650, NULL, 500, 1700, 650, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5586, 146, 4, 2000, 'count', 200, NULL, 100, 500, 200, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5589, 149, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5590, 150, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5591, 151, 4, 2000, 'count', 54000, NULL, 45000, 62000, 54000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5593, 153, 4, 2000, 'count', 5600, NULL, 5000, 6300, 5600, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5595, 155, 4, 2000, 'count', 100, NULL, 100, 100, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5598, 158, 4, 2000, 'count', 85000, NULL, 75000, 99000, 85000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5599, 159, 4, 2000, 'count', 4500, NULL, 3100, 6200, 4500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5602, 162, 4, 2000, 'count', 80000, NULL, 69000, 90000, 80000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5604, 164, 4, 2000, 'count', 500, NULL, 100, 500, 500, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5605, 165, 4, 2000, 'count', 840, NULL, 740, 920, 840, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5607, 167, 4, 2000, 'count', 6100, NULL, 4300, 7800, 6100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5608, 168, 4, 2000, 'count', 100, NULL, 100, 200, 100, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5609, 169, 4, 2000, 'count', 62000, NULL, 49000, 81000, 62000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5610, 170, 4, 2000, 'count', 120000, NULL, 98000, 150000, 120000, 'good', 'no_of_deaths_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5611, 1, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5613, 3, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5614, 4, 5, 2018, 'count', 2, NULL, 1.7, 2.3, 2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5615, 5, 5, 2018, 'count', 0.4, NULL, 0.4, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5616, 6, 5, 2018, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5617, 7, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5620, 10, 5, 2018, 'count', 1.8, NULL, 1.5, 1.9, 1.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5622, 12, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5623, 13, 5, 2018, 'count', 1.5, NULL, 1.3, 1.7, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5624, 14, 5, 2018, 'count', 0.5, NULL, 0.4, 0.6, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5626, 16, 5, 2018, 'count', 1.9, NULL, 1.7, 2.1, 1.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5627, 17, 5, 2018, 'count', 1, NULL, 0.7, 1.7, 1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5628, 18, 5, 2018, 'count', 0.3, NULL, 0.1, 0.5, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5629, 19, 5, 2018, 'count', 0.3, NULL, 0.3, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5630, 20, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5631, 21, 5, 2018, 'count', 20.3, NULL, 17.3, 21.8, 20.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5632, 22, 5, 2018, 'count', 0.5, NULL, 0.4, 0.7, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5634, 24, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5635, 25, 5, 2018, 'count', 0.7, NULL, 0.6, 0.9, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5636, 26, 5, 2018, 'count', 1, NULL, 0.9, 1.2, 1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5637, 27, 5, 2018, 'count', 0.6, NULL, 0.5, 0.7, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5638, 28, 5, 2018, 'count', 0.5, NULL, 0.5, 0.6, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5639, 29, 5, 2018, 'count', 3.6, NULL, 3.1, 4, 3.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5641, 31, 5, 2018, 'count', 3.6, NULL, 2.9, 4.5, 3.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5642, 32, 5, 2018, 'count', 1.3, NULL, 1, 1.7, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5643, 33, 5, 2018, 'count', 0.5, NULL, 0.5, 0.6, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5645, 35, 5, 2018, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5646, 36, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5647, 37, 5, 2018, 'count', 2.6, NULL, 2, 3.5, 2.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5648, 38, 5, 2018, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5649, 39, 5, 2018, 'count', 2.6, NULL, 2, 3.3, 2.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5650, 40, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5651, 41, 5, 2018, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5653, 43, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5655, 45, 5, 2018, 'count', 0.8, NULL, 0.6, 0.9, 0.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5656, 46, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5657, 47, 5, 2018, 'count', 1.2, NULL, 1, 1.5, 1.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5658, 48, 5, 2018, 'count', 0.9, NULL, 0.7, 1.3, 0.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5659, 49, 5, 2018, 'count', 0.4, NULL, 0.2, 0.6, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5660, 50, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5661, 51, 5, 2018, 'count', 0.6, NULL, 0.5, 0.7, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5662, 52, 5, 2018, 'count', 7.1, NULL, 5.6, 9.2, 7.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5663, 53, 5, 2018, 'count', 0.7, NULL, 0.5, 0.9, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5664, 54, 5, 2018, 'count', 0.9, NULL, 0.7, 0.9, 0.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5665, 55, 5, 2018, 'count', 27.3, NULL, 25.1, 29, 27.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5666, 56, 5, 2018, 'count', 1, NULL, 0.7, 1.4, 1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5668, 58, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5669, 59, 5, 2018, 'count', 0.3, NULL, 0.3, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5670, 60, 5, 2018, 'count', 3.8, NULL, 2.9, 4.9, 3.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5671, 61, 5, 2018, 'count', 1.9, NULL, 1.6, 2.5, 1.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5672, 62, 5, 2018, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5673, 63, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5674, 64, 5, 2018, 'count', 1.7, NULL, 1.4, 2, 1.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5676, 66, 5, 2018, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5677, 67, 5, 2018, 'count', 1.4, NULL, 1.2, 1.7, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5678, 68, 5, 2018, 'count', 3.5, NULL, 3, 4, 3.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5679, 69, 5, 2018, 'count', 1.4, NULL, 1.3, 1.6, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5680, 70, 5, 2018, 'count', 2, NULL, 1.8, 2.3, 2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5681, 71, 5, 2018, 'count', 0.3, NULL, 0.3, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5682, 72, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5683, 73, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5685, 75, 5, 2018, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5686, 76, 5, 2018, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5687, 77, 5, 2018, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5688, 78, 5, 2018, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5689, 79, 5, 2018, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5690, 80, 5, 2018, 'count', 1.9, NULL, 1.6, 2.1, 1.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5691, 81, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5692, 82, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5693, 83, 5, 2018, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5694, 84, 5, 2018, 'count', 4.7, NULL, 4, 5.7, 4.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5695, 85, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5696, 86, 5, 2018, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5697, 87, 5, 2018, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5698, 88, 5, 2018, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5699, 89, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5700, 90, 5, 2018, 'count', 23.6, NULL, 21.2, 24.7, 23.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5701, 91, 5, 2018, 'count', 1.3, NULL, 1.1, 1.4, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5702, 92, 5, 2018, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5704, 94, 5, 2018, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5705, 95, 5, 2018, 'count', 0.3, NULL, 0.2, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5706, 96, 5, 2018, 'count', 9.2, NULL, 8, 10, 9.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5707, 97, 5, 2018, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5709, 99, 5, 2018, 'count', 1.4, NULL, 1.1, 1.7, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5711, 101, 5, 2018, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5712, 102, 5, 2018, 'count', 1.3, NULL, 1.1, 1.5, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5713, 103, 5, 2018, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5714, 104, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5715, 105, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5716, 106, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5717, 107, 5, 2018, 'count', 12.6, NULL, 10, 15.7, 12.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5718, 108, 5, 2018, 'count', 0.8, NULL, 0.6, 0.9, 0.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5719, 109, 5, 2018, 'count', 11.8, NULL, 10.6, 12.7, 11.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5720, 110, 5, 2018, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5722, 112, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5723, 113, 5, 2018, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5724, 114, 5, 2018, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5725, 115, 5, 2018, 'count', 1.5, NULL, 1.1, 2.1, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5726, 116, 5, 2018, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5727, 117, 5, 2018, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5728, 118, 5, 2018, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5729, 119, 5, 2018, 'count', 0.9, NULL, 0.8, 1, 0.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5730, 120, 5, 2018, 'count', 0.8, NULL, 0.7, 0.9, 0.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5731, 121, 5, 2018, 'count', 0.5, NULL, 0.3, 0.7, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5732, 122, 5, 2018, 'count', 0.3, NULL, 0.2, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5733, 123, 5, 2018, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5735, 125, 5, 2018, 'count', 0.5, NULL, 0.4, 0.5, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5738, 128, 5, 2018, 'count', 0.6, NULL, 0.5, 0.8, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5739, 129, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5740, 130, 5, 2018, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5742, 132, 5, 2018, 'count', 2.5, NULL, 2.1, 2.8, 2.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5744, 134, 5, 2018, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5745, 135, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5746, 136, 5, 2018, 'count', 1.5, NULL, 1.2, 1.9, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5747, 137, 5, 2018, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5748, 138, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5749, 139, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5750, 140, 5, 2018, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5751, 141, 5, 2018, 'count', 20.4, NULL, 17.4, 22.5, 20.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5752, 142, 5, 2018, 'count', 2.5, NULL, 1.9, 3.1, 2.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5753, 143, 5, 2018, 'count', 0.3, NULL, 0.3, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5754, 144, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5755, 145, 5, 2018, 'count', 0.2, NULL, 0.1, 0.5, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5756, 146, 5, 2018, 'count', 1.4, NULL, 0.9, 2, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5759, 149, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5760, 150, 5, 2018, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5761, 151, 5, 2018, 'count', 1.1, NULL, 0.9, 1.3, 1.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5763, 153, 5, 2018, 'count', 2.3, NULL, 2.1, 2.5, 2.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5765, 155, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5768, 158, 5, 2018, 'count', 5.7, NULL, 5.4, 6.1, 5.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5769, 159, 5, 2018, 'count', 1, NULL, 0.9, 1, 1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5772, 162, 5, 2018, 'count', 4.6, NULL, 4, 5.1, 4.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5774, 164, 5, 2018, 'count', 0.6, NULL, 0.4, 0.8, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5775, 165, 5, 2018, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5777, 167, 5, 2018, 'count', 0.3, NULL, 0.3, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5778, 168, 5, 2018, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5779, 169, 5, 2018, 'count', 11.3, NULL, 10, 12.6, 11.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5780, 170, 5, 2018, 'count', 12.7, NULL, 10.8, 14.5, 12.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5781, 1, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5783, 3, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5784, 4, 5, 2010, 'count', 1.7, NULL, 1.5, 2, 1.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5785, 5, 5, 2010, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5786, 6, 5, 2010, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5787, 7, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5790, 10, 5, 2010, 'count', 2.2, NULL, 1.9, 2.5, 2.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5792, 12, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5793, 13, 5, 2010, 'count', 1.3, NULL, 1.2, 1.4, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5794, 14, 5, 2010, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5796, 16, 5, 2010, 'count', 1.9, NULL, 1.7, 2.1, 1.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5797, 17, 5, 2010, 'count', 1.1, NULL, 0.7, 1.8, 1.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5798, 18, 5, 2010, 'count', 0.3, NULL, 0.1, 0.6, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5799, 19, 5, 2010, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5800, 20, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5801, 21, 5, 2010, 'count', 23.2, NULL, 20.9, 24.8, 23.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5802, 22, 5, 2010, 'count', 0.5, NULL, 0.4, 0.6, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5804, 24, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5805, 25, 5, 2010, 'count', 1.2, NULL, 0.9, 1.4, 1.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5806, 26, 5, 2010, 'count', 1.6, NULL, 1.3, 1.8, 1.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5807, 27, 5, 2010, 'count', 0.6, NULL, 0.5, 0.8, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5808, 28, 5, 2010, 'count', 0.8, NULL, 0.7, 1, 0.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5809, 29, 5, 2010, 'count', 4.5, NULL, 3.9, 4.9, 4.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5811, 31, 5, 2010, 'count', 5, NULL, 4.2, 5.9, 5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5812, 32, 5, 2010, 'count', 1.5, NULL, 1.2, 1.8, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5813, 33, 5, 2010, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5815, 35, 5, 2010, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5816, 36, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5817, 37, 5, 2010, 'count', 3.1, NULL, 2.6, 3.7, 3.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5818, 38, 5, 2010, 'count', 0.3, NULL, 0.3, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5819, 39, 5, 2010, 'count', 3.6, NULL, 2.8, 4.6, 3.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5820, 40, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5821, 41, 5, 2010, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5823, 43, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5825, 45, 5, 2010, 'count', 1.1, NULL, 0.9, 1.3, 1.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5826, 46, 5, 2010, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5827, 47, 5, 2010, 'count', 1.6, NULL, 1.2, 1.9, 1.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5828, 48, 5, 2010, 'count', 1.2, NULL, 0.9, 1.5, 1.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5829, 49, 5, 2010, 'count', 0.4, NULL, 0.2, 0.6, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5830, 50, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5831, 51, 5, 2010, 'count', 0.7, NULL, 0.6, 0.9, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5832, 52, 5, 2010, 'count', 5.7, NULL, 4.8, 6.7, 5.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5833, 53, 5, 2010, 'count', 0.9, NULL, 0.7, 1.2, 0.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5834, 54, 5, 2010, 'count', 0.7, NULL, 0.6, 0.8, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5835, 55, 5, 2010, 'count', 27.4, NULL, 25.2, 29.3, 27.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5836, 56, 5, 2010, 'count', 1.3, NULL, 1, 1.8, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5838, 58, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5839, 59, 5, 2010, 'count', 0.3, NULL, 0.3, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5840, 60, 5, 2010, 'count', 4.1, NULL, 3.4, 5, 4.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5841, 61, 5, 2010, 'count', 1.9, NULL, 1.5, 2.4, 1.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5842, 62, 5, 2010, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5843, 63, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5844, 64, 5, 2010, 'count', 1.9, NULL, 1.6, 2.2, 1.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5846, 66, 5, 2010, 'count', 0.6, NULL, 0.5, 0.6, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5847, 67, 5, 2010, 'count', 1.6, NULL, 1.3, 1.9, 1.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5848, 68, 5, 2010, 'count', 3.8, NULL, 3.4, 4.3, 3.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5849, 69, 5, 2010, 'count', 1.5, NULL, 1.4, 1.7, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5850, 70, 5, 2010, 'count', 2.1, NULL, 2, 2.3, 2.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5851, 71, 5, 2010, 'count', 0.5, NULL, 0.4, 0.6, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5852, 72, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5853, 73, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5855, 75, 5, 2010, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5856, 76, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5857, 77, 5, 2010, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5858, 78, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5859, 79, 5, 2010, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5860, 80, 5, 2010, 'count', 2.1, NULL, 1.8, 2.3, 2.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5861, 81, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5862, 82, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5863, 83, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5864, 84, 5, 2010, 'count', 6, NULL, 5.1, 7.1, 6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5865, 85, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5866, 86, 5, 2010, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5867, 87, 5, 2010, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5868, 88, 5, 2010, 'count', 0.3, NULL, 0.3, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5869, 89, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5870, 90, 5, 2010, 'count', 24.1, NULL, 22.7, 24.9, 24.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5871, 91, 5, 2010, 'count', 1.7, NULL, 1.5, 2, 1.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5872, 92, 5, 2010, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5874, 94, 5, 2010, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5875, 95, 5, 2010, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5876, 96, 5, 2010, 'count', 10.6, NULL, 9.3, 11.7, 10.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5877, 97, 5, 2010, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5879, 99, 5, 2010, 'count', 1.4, NULL, 1.1, 1.6, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5881, 101, 5, 2010, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5882, 102, 5, 2010, 'count', 1.3, NULL, 1.2, 1.4, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5883, 103, 5, 2010, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5884, 104, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5885, 105, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5886, 106, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5887, 107, 5, 2010, 'count', 12, NULL, 9.5, 14.9, 12, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5888, 108, 5, 2010, 'count', 0.8, NULL, 0.6, 0.9, 0.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5889, 109, 5, 2010, 'count', 13.4, NULL, 12.2, 14.2, 13.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5890, 110, 5, 2010, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5891, 111, 5, 2010, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5892, 112, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5893, 113, 5, 2010, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5894, 114, 5, 2010, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5895, 115, 5, 2010, 'count', 1.6, NULL, 1.2, 2.1, 1.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5896, 116, 5, 2010, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5897, 117, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5898, 118, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5899, 119, 5, 2010, 'count', 0.8, NULL, 0.8, 0.9, 0.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5900, 120, 5, 2010, 'count', 0.8, NULL, 0.7, 1, 0.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5901, 121, 5, 2010, 'count', 0.5, NULL, 0.4, 0.8, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5902, 122, 5, 2010, 'count', 0.3, NULL, 0.3, 0.5, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5903, 123, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5905, 125, 5, 2010, 'count', 0.6, NULL, 0.5, 0.6, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5908, 128, 5, 2010, 'count', 0.5, NULL, 0.4, 0.7, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5909, 129, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5910, 130, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5912, 132, 5, 2010, 'count', 3.3, NULL, 2.8, 3.7, 3.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5914, 134, 5, 2010, 'count', 0.6, NULL, 0.5, 0.6, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5915, 135, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5916, 136, 5, 2010, 'count', 1.5, NULL, 1.2, 1.9, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5917, 137, 5, 2010, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5918, 138, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5919, 139, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5920, 140, 5, 2010, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5921, 141, 5, 2010, 'count', 18.9, NULL, 16.8, 20.7, 18.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5922, 142, 5, 2010, 'count', 2.4, NULL, 1.9, 3, 2.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5923, 143, 5, 2010, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5924, 144, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5925, 145, 5, 2010, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5926, 146, 5, 2010, 'count', 1.4, NULL, 1, 1.9, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5929, 149, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5930, 150, 5, 2010, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5931, 151, 5, 2010, 'count', 1.5, NULL, 1.2, 1.8, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5933, 153, 5, 2010, 'count', 2.9, NULL, 2.6, 3.1, 2.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5935, 155, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5938, 158, 5, 2010, 'count', 6.8, NULL, 6.5, 7.1, 6.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5939, 159, 5, 2010, 'count', 0.9, NULL, 0.9, 0.9, 0.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5942, 162, 5, 2010, 'count', 5, NULL, 4.3, 5.7, 5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5943, 163, 5, 2010, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5944, 164, 5, 2010, 'count', 0.5, NULL, 0.4, 0.5, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5945, 165, 5, 2010, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5947, 167, 5, 2010, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5948, 168, 5, 2010, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5949, 169, 5, 2010, 'count', 13, NULL, 11.5, 14.5, 13, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5950, 170, 5, 2010, 'count', 15.4, NULL, 13.1, 17.5, 15.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5951, 1, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5953, 3, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5954, 4, 5, 2005, 'count', 1.4, NULL, 1.2, 1.7, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5955, 5, 5, 2005, 'count', 0.3, NULL, 0.3, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5956, 6, 5, 2005, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5957, 7, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5960, 10, 5, 2005, 'count', 2.3, NULL, 1.9, 2.7, 2.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5962, 12, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5963, 13, 5, 2005, 'count', 1, NULL, 0.9, 1.1, 1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5964, 14, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5966, 16, 5, 2005, 'count', 1.7, NULL, 1.5, 1.9, 1.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5967, 17, 5, 2005, 'count', 1.3, NULL, 0.8, 2.1, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5968, 18, 5, 2005, 'count', 0.3, NULL, 0.1, 0.6, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5969, 19, 5, 2005, 'count', 0.5, NULL, 0.5, 0.5, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5970, 20, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5971, 21, 5, 2005, 'count', 24.6, NULL, 22.1, 25.9, 24.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5972, 22, 5, 2005, 'count', 0.5, NULL, 0.3, 0.6, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5974, 24, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5975, 25, 5, 2005, 'count', 1.5, NULL, 1.1, 1.8, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5976, 26, 5, 2005, 'count', 2.2, NULL, 1.7, 2.6, 2.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5977, 27, 5, 2005, 'count', 0.6, NULL, 0.5, 1, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5978, 28, 5, 2005, 'count', 1, NULL, 0.8, 1.2, 1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5979, 29, 5, 2005, 'count', 4.8, NULL, 4.3, 5.1, 4.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5981, 31, 5, 2005, 'count', 5.9, NULL, 4.9, 7, 5.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5982, 32, 5, 2005, 'count', 1.5, NULL, 1.2, 2, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5983, 33, 5, 2005, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5985, 35, 5, 2005, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5986, 36, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5987, 37, 5, 2005, 'count', 3.5, NULL, 2.8, 4.1, 3.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5988, 38, 5, 2005, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5989, 39, 5, 2005, 'count', 4.4, NULL, 3.4, 5.6, 4.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5990, 40, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5991, 41, 5, 2005, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5993, 43, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5995, 45, 5, 2005, 'count', 1.4, NULL, 1.2, 1.7, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5996, 46, 5, 2005, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5997, 47, 5, 2005, 'count', 2.1, NULL, 1.8, 2.5, 2.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5998, 48, 5, 2005, 'count', 1.4, NULL, 1.1, 1.9, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (5999, 49, 5, 2005, 'count', 0.4, NULL, 0.2, 0.6, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6000, 50, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6001, 51, 5, 2005, 'count', 0.7, NULL, 0.5, 0.9, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6002, 52, 5, 2005, 'count', 4.6, NULL, 3.6, 5.9, 4.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6003, 53, 5, 2005, 'count', 1.1, NULL, 0.8, 1.5, 1.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6004, 54, 5, 2005, 'count', 0.7, NULL, 0.6, 0.7, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6005, 55, 5, 2005, 'count', 26.3, NULL, 23.9, 27.8, 26.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6006, 56, 5, 2005, 'count', 1.7, NULL, 1.2, 2.2, 1.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6008, 58, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6009, 59, 5, 2005, 'count', 0.3, NULL, 0.3, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6010, 60, 5, 2005, 'count', 4.2, NULL, 3.3, 5.3, 4.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6011, 61, 5, 2005, 'count', 1.8, NULL, 1.4, 2.3, 1.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6012, 62, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6013, 63, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6014, 64, 5, 2005, 'count', 2.1, NULL, 1.8, 2.4, 2.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6016, 66, 5, 2005, 'count', 0.7, NULL, 0.6, 0.7, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6017, 67, 5, 2005, 'count', 1.7, NULL, 1.4, 1.9, 1.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6018, 68, 5, 2005, 'count', 3.8, NULL, 3.4, 4.2, 3.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6019, 69, 5, 2005, 'count', 1.3, NULL, 1.1, 1.4, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6020, 70, 5, 2005, 'count', 2.4, NULL, 2.2, 2.6, 2.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6021, 71, 5, 2005, 'count', 0.7, NULL, 0.5, 0.9, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6022, 72, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6023, 73, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6025, 75, 5, 2005, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6026, 76, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6027, 77, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6028, 78, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6029, 79, 5, 2005, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6030, 80, 5, 2005, 'count', 2.3, NULL, 2, 2.6, 2.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6031, 81, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6032, 82, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6033, 83, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6034, 84, 5, 2005, 'count', 7.3, NULL, 6.2, 8.7, 7.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6035, 85, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6036, 86, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6037, 87, 5, 2005, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6038, 88, 5, 2005, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6039, 89, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6040, 90, 5, 2005, 'count', 23.8, NULL, 22.9, 24.8, 23.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6041, 91, 5, 2005, 'count', 2.1, NULL, 1.9, 2.4, 2.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6042, 92, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6044, 94, 5, 2005, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6045, 95, 5, 2005, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6046, 96, 5, 2005, 'count', 12.2, NULL, 10.5, 13.4, 12.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6047, 97, 5, 2005, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6049, 99, 5, 2005, 'count', 1.5, NULL, 1.2, 1.8, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6051, 101, 5, 2005, 'count', 0.5, NULL, 0.4, 0.6, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6052, 102, 5, 2005, 'count', 1, NULL, 0.8, 1.4, 1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6053, 103, 5, 2005, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6054, 104, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6055, 105, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6056, 106, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6057, 107, 5, 2005, 'count', 11.1, NULL, 8.9, 13.8, 11.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6058, 108, 5, 2005, 'count', 0.8, NULL, 0.6, 0.9, 0.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6059, 109, 5, 2005, 'count', 13.8, NULL, 12.6, 14.7, 13.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6060, 110, 5, 2005, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6061, 111, 5, 2005, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6062, 112, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6063, 113, 5, 2005, 'count', 0.2, NULL, 0.1, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6064, 114, 5, 2005, 'count', 0.6, NULL, 0.5, 0.6, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6065, 115, 5, 2005, 'count', 1.7, NULL, 1.2, 2.2, 1.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6066, 116, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6067, 117, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6068, 118, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6069, 119, 5, 2005, 'count', 0.8, NULL, 0.7, 0.8, 0.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6070, 120, 5, 2005, 'count', 1, NULL, 0.9, 1.1, 1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6071, 121, 5, 2005, 'count', 0.6, NULL, 0.4, 0.8, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6072, 122, 5, 2005, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6073, 123, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6075, 125, 5, 2005, 'count', 0.6, NULL, 0.5, 0.6, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6078, 128, 5, 2005, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6079, 129, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6080, 130, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6082, 132, 5, 2005, 'count', 3.8, NULL, 3.2, 4.3, 3.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6084, 134, 5, 2005, 'count', 0.7, NULL, 0.6, 0.7, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6085, 135, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6086, 136, 5, 2005, 'count', 1.5, NULL, 1.3, 1.9, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6087, 137, 5, 2005, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6088, 138, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6089, 139, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6090, 140, 5, 2005, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6091, 141, 5, 2005, 'count', 16.8, NULL, 15, 18.4, 16.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6092, 142, 5, 2005, 'count', 2.5, NULL, 2, 3.2, 2.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6093, 143, 5, 2005, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6094, 144, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6095, 145, 5, 2005, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6096, 146, 5, 2005, 'count', 1.3, NULL, 1, 1.9, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6099, 149, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6100, 150, 5, 2005, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6101, 151, 5, 2005, 'count', 1.6, NULL, 1.3, 2.1, 1.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6103, 153, 5, 2005, 'count', 3.3, NULL, 3, 3.6, 3.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6105, 155, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6108, 158, 5, 2005, 'count', 7.3, NULL, 6.9, 7.6, 7.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6109, 159, 5, 2005, 'count', 0.9, NULL, 0.8, 0.9, 0.9, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6112, 162, 5, 2005, 'count', 5.4, NULL, 4.6, 6.1, 5.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6114, 164, 5, 2005, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6115, 165, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6117, 167, 5, 2005, 'count', 0.3, NULL, 0.3, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6118, 168, 5, 2005, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6119, 169, 5, 2005, 'count', 14.1, NULL, 12.5, 15.8, 14.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6120, 170, 5, 2005, 'count', 19, NULL, 16.2, 21.6, 19, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6121, 1, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6123, 3, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6124, 4, 5, 2000, 'count', 1, NULL, 0.8, 1.2, 1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6125, 5, 5, 2000, 'count', 0.3, NULL, 0.3, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6126, 6, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6127, 7, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6130, 10, 5, 2000, 'count', 2.6, NULL, 2.2, 3.1, 2.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6132, 12, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6133, 13, 5, 2000, 'count', 0.7, NULL, 0.6, 0.8, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6134, 14, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6136, 16, 5, 2000, 'count', 1.3, NULL, 1.2, 1.4, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6137, 17, 5, 2000, 'count', 1.3, NULL, 0.9, 2.2, 1.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6138, 18, 5, 2000, 'count', 0.2, NULL, 0.1, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6139, 19, 5, 2000, 'count', 0.5, NULL, 0.5, 0.5, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6140, 20, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6141, 21, 5, 2000, 'count', 26.3, NULL, 25.1, 27.2, 26.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6142, 22, 5, 2000, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6144, 24, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6145, 25, 5, 2000, 'count', 2.1, NULL, 1.7, 2.6, 2.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6146, 26, 5, 2000, 'count', 3.3, NULL, 2.8, 4, 3.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6147, 27, 5, 2000, 'count', 0.7, NULL, 0.5, 1.1, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6148, 28, 5, 2000, 'count', 1.2, NULL, 1.1, 1.4, 1.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6149, 29, 5, 2000, 'count', 4.6, NULL, 4.3, 4.9, 4.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6151, 31, 5, 2000, 'count', 7.2, NULL, 6.1, 8.6, 7.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6152, 32, 5, 2000, 'count', 1.8, NULL, 1.3, 2.3, 1.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6153, 33, 5, 2000, 'count', 0.2, NULL, 0.1, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6155, 35, 5, 2000, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6156, 36, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6157, 37, 5, 2000, 'count', 4.2, NULL, 3.4, 5.1, 4.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6158, 38, 5, 2000, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6159, 39, 5, 2000, 'count', 5.6, NULL, 4.4, 7.2, 5.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6160, 40, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6161, 41, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6163, 43, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6165, 45, 5, 2000, 'count', 1.8, NULL, 1.5, 2.1, 1.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6166, 46, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6167, 47, 5, 2000, 'count', 2.2, NULL, 1.7, 2.9, 2.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6168, 48, 5, 2000, 'count', 1.7, NULL, 1.3, 2.4, 1.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6169, 49, 5, 2000, 'count', 0.4, NULL, 0.2, 0.6, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6170, 50, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6171, 51, 5, 2000, 'count', 0.6, NULL, 0.5, 0.7, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6172, 52, 5, 2000, 'count', 3.5, NULL, 2.5, 4.9, 3.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6173, 53, 5, 2000, 'count', 1.5, NULL, 1.1, 1.9, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6174, 54, 5, 2000, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6175, 55, 5, 2000, 'count', 24.6, NULL, 23, 26.5, 24.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6176, 56, 5, 2000, 'count', 2.4, NULL, 1.7, 3.2, 2.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6178, 58, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6179, 59, 5, 2000, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6180, 60, 5, 2000, 'count', 4.1, NULL, 3, 5.6, 4.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6181, 61, 5, 2000, 'count', 1.4, NULL, 1.1, 1.9, 1.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6182, 62, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6183, 63, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6184, 64, 5, 2000, 'count', 2.4, NULL, 2.1, 2.7, 2.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6186, 66, 5, 2000, 'count', 0.7, NULL, 0.7, 0.7, 0.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6187, 67, 5, 2000, 'count', 1.7, NULL, 1.4, 2, 1.7, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6188, 68, 5, 2000, 'count', 3.2, NULL, 2.8, 3.5, 3.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6189, 69, 5, 2000, 'count', 0.6, NULL, 0.4, 0.7, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6190, 70, 5, 2000, 'count', 3, NULL, 2.7, 3.4, 3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6191, 71, 5, 2000, 'count', 1.1, NULL, 0.9, 1.4, 1.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6192, 72, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6193, 73, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6195, 75, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6196, 76, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6197, 77, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6198, 78, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6199, 79, 5, 2000, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6200, 80, 5, 2000, 'count', 2.8, NULL, 2.5, 3, 2.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6201, 81, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6202, 82, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6203, 83, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6204, 84, 5, 2000, 'count', 9.8, NULL, 8.4, 11.7, 9.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6205, 85, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6206, 86, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6207, 87, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6208, 88, 5, 2000, 'count', 0.2, NULL, 0.2, 0.2, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6209, 89, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6210, 90, 5, 2000, 'count', 23.2, NULL, 21.5, 24.8, 23.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6211, 91, 5, 2000, 'count', 2.6, NULL, 2.4, 2.7, 2.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6212, 92, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6214, 94, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6215, 95, 5, 2000, 'count', 0.2, NULL, 0.1, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6216, 96, 5, 2000, 'count', 14.4, NULL, 13, 15.4, 14.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6217, 97, 5, 2000, 'count', 0.4, NULL, 0.3, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6219, 99, 5, 2000, 'count', 1.8, NULL, 1.5, 2.2, 1.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6221, 101, 5, 2000, 'count', 0.4, NULL, 0.4, 0.5, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6222, 102, 5, 2000, 'count', 0.4, NULL, 0.2, 0.8, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6223, 103, 5, 2000, 'count', 0.2, NULL, 0.2, 0.3, 0.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6224, 104, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6225, 105, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6226, 106, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6227, 107, 5, 2000, 'count', 8.8, NULL, 7, 11, 8.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6228, 108, 5, 2000, 'count', 0.6, NULL, 0.5, 0.7, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6229, 109, 5, 2000, 'count', 14, NULL, 13.1, 15.1, 14, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6230, 110, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6231, 111, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6232, 112, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6233, 113, 5, 2000, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6234, 114, 5, 2000, 'count', 0.6, NULL, 0.5, 0.7, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6235, 115, 5, 2000, 'count', 1.8, NULL, 1.3, 2.4, 1.8, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6236, 116, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6237, 117, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6238, 118, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6239, 119, 5, 2000, 'count', 0.6, NULL, 0.6, 0.7, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6240, 120, 5, 2000, 'count', 0.6, NULL, 0.5, 0.8, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6241, 121, 5, 2000, 'count', 0.5, NULL, 0.3, 0.7, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6242, 122, 5, 2000, 'count', 0.5, NULL, 0.4, 0.6, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6243, 123, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6245, 125, 5, 2000, 'count', 0.5, NULL, 0.5, 0.6, 0.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6248, 128, 5, 2000, 'count', 0.3, NULL, 0.3, 0.4, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6249, 129, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6250, 130, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6252, 132, 5, 2000, 'count', 5.2, NULL, 4.6, 5.9, 5.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6254, 134, 5, 2000, 'count', 0.6, NULL, 0.5, 0.7, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6255, 135, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6256, 136, 5, 2000, 'count', 1.5, NULL, 1.2, 1.9, 1.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6257, 137, 5, 2000, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6258, 138, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6259, 139, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6260, 140, 5, 2000, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6261, 141, 5, 2000, 'count', 12.6, NULL, 10.7, 13.9, 12.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6262, 142, 5, 2000, 'count', 2.5, NULL, 1.5, 3.2, 2.5, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6263, 143, 5, 2000, 'count', 0.4, NULL, 0.3, 0.4, 0.4, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6264, 144, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6265, 145, 5, 2000, 'count', 0.1, NULL, 0.1, 0.2, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6266, 146, 5, 2000, 'count', 1.1, NULL, 0.8, 1.6, 1.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6269, 149, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6270, 150, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6271, 151, 5, 2000, 'count', 2, NULL, 1.6, 2.5, 2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6273, 153, 5, 2000, 'count', 3.6, NULL, 3.2, 3.8, 3.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6275, 155, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6278, 158, 5, 2000, 'count', 8.3, NULL, 7.7, 8.9, 8.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6279, 159, 5, 2000, 'count', 0.6, NULL, 0.6, 0.7, 0.6, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6282, 162, 5, 2000, 'count', 6.3, NULL, 5.5, 6.9, 6.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6284, 164, 5, 2000, 'count', 0.3, NULL, 0.2, 0.6, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6285, 165, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6287, 167, 5, 2000, 'count', 0.3, NULL, 0.2, 0.3, 0.3, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6288, 168, 5, 2000, 'count', 0.1, NULL, 0.1, 0.1, 0.1, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6289, 169, 5, 2000, 'count', 16.2, NULL, 14.3, 18.2, 16.2, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6290, 170, 5, 2000, 'count', 25, NULL, 21.2, 28.3, 25, 'good', 'no_of_cases_adults_15_to_49_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6291, 1, 6, 2023, 'reported_children_receiving_art', 60, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6292, 1, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 530, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6293, 1, 6, 2023, 'estimated_children_art_coverage_percent', 17, NULL, 10, 26, 17, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6294, 2, 6, 2023, 'reported_children_receiving_art', 20, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6297, 3, 6, 2023, 'reported_children_receiving_art', 770, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6298, 3, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 520, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6299, 3, 6, 2023, 'estimated_children_art_coverage_percent', 95, NULL, 95, 95, 95, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6300, 4, 6, 2023, 'reported_children_receiving_art', 4800, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6301, 4, 6, 2023, 'estimated_children_needing_art', 38000, NULL, 30000, 47000, 38000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6302, 4, 6, 2023, 'estimated_children_art_coverage_percent', 13, NULL, 10, 16, 13, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6303, 5, 6, 2023, 'reported_children_receiving_art', 1700, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6304, 5, 6, 2023, 'estimated_children_needing_art', 1800, NULL, 1600, 2100, 1800, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6305, 5, 6, 2023, 'estimated_children_art_coverage_percent', 92, NULL, 84, 95, 92, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6310, 7, 6, 2023, 'estimated_children_needing_art', 100, NULL, 100, 100, 100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6315, 9, 6, 2023, 'reported_children_receiving_art', 110, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6318, 10, 6, 2023, 'reported_children_receiving_art', 40, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6319, 10, 6, 2023, 'estimated_children_needing_art', 200, NULL, 200, 500, 200, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6320, 10, 6, 2023, 'estimated_children_art_coverage_percent', 21, NULL, 18, 26, 21, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6324, 12, 6, 2023, 'reported_children_receiving_art', 130, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6325, 12, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6326, 12, 6, 2023, 'estimated_children_art_coverage_percent', 33, NULL, 28, 38, 33, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6330, 14, 6, 2023, 'reported_children_receiving_art', 220, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6331, 14, 6, 2023, 'estimated_children_needing_art', 500, NULL, 200, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6332, 14, 6, 2023, 'estimated_children_art_coverage_percent', 88, NULL, 64, 95, 88, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6336, 16, 6, 2023, 'reported_children_receiving_art', 60, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6337, 16, 6, 2023, 'estimated_children_needing_art', 200, NULL, 200, 200, 200, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6338, 16, 6, 2023, 'estimated_children_art_coverage_percent', 34, NULL, 31, 38, 34, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6339, 17, 6, 2023, 'reported_children_receiving_art', 2000, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6340, 17, 6, 2023, 'estimated_children_needing_art', 4600, NULL, 2800, 8000, 4600, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6341, 17, 6, 2023, 'estimated_children_art_coverage_percent', 44, NULL, 27, 77, 44, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6345, 19, 6, 2023, 'reported_children_receiving_art', 250, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6346, 19, 6, 2023, 'estimated_children_needing_art', 620, NULL, 560, 670, 620, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6347, 19, 6, 2023, 'estimated_children_art_coverage_percent', 40, NULL, 37, 43, 40, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6351, 21, 6, 2023, 'reported_children_receiving_art', 5400, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6352, 21, 6, 2023, 'estimated_children_needing_art', 14000, NULL, 10000, 17000, 14000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6353, 21, 6, 2023, 'estimated_children_art_coverage_percent', 38, NULL, 28, 46, 38, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6357, 23, 6, 2023, 'reported_children_receiving_art', 0, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6363, 25, 6, 2023, 'reported_children_receiving_art', 1900, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6364, 25, 6, 2023, 'estimated_children_needing_art', 9100, NULL, 6300, 12000, 9100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6365, 25, 6, 2023, 'estimated_children_art_coverage_percent', 21, NULL, 15, 29, 21, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6366, 26, 6, 2023, 'reported_children_receiving_art', 3400, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6367, 26, 6, 2023, 'estimated_children_needing_art', 11000, NULL, 8000, 14000, 11000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6368, 26, 6, 2023, 'estimated_children_art_coverage_percent', 30, NULL, 22, 38, 30, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6372, 28, 6, 2023, 'reported_children_receiving_art', 3000, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6373, 28, 6, 2023, 'estimated_children_needing_art', 3300, NULL, 2800, 3900, 3300, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6374, 28, 6, 2023, 'estimated_children_art_coverage_percent', 92, NULL, 78, 95, 92, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6375, 29, 6, 2023, 'reported_children_receiving_art', 10300, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6376, 29, 6, 2023, 'estimated_children_needing_art', 43000, NULL, 33000, 51000, 43000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6377, 29, 6, 2023, 'estimated_children_art_coverage_percent', 24, NULL, 18, 28, 24, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6381, 31, 6, 2023, 'reported_children_receiving_art', 2500, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6382, 31, 6, 2023, 'estimated_children_needing_art', 11000, NULL, 8200, 14000, 11000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6383, 31, 6, 2023, 'estimated_children_art_coverage_percent', 23, NULL, 18, 29, 23, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6384, 32, 6, 2023, 'reported_children_receiving_art', 2600, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6385, 32, 6, 2023, 'estimated_children_needing_art', 16000, NULL, 11000, 21000, 16000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6386, 32, 6, 2023, 'estimated_children_art_coverage_percent', 16, NULL, 11, 22, 16, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6387, 33, 6, 2023, 'reported_children_receiving_art', 140, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6388, 33, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6389, 33, 6, 2023, 'estimated_children_art_coverage_percent', 56, NULL, 50, 61, 56, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6390, 34, 6, 2023, 'reported_children_receiving_art', 6200, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6393, 35, 6, 2023, 'reported_children_receiving_art', 1500, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6394, 35, 6, 2023, 'estimated_children_needing_art', 3600, NULL, 2900, 4300, 3600, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6395, 35, 6, 2023, 'estimated_children_art_coverage_percent', 41, NULL, 32, 49, 41, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6399, 37, 6, 2023, 'reported_children_receiving_art', 2000, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6400, 37, 6, 2023, 'estimated_children_needing_art', 7700, NULL, 5800, 10000, 7700, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6401, 37, 6, 2023, 'estimated_children_art_coverage_percent', 25, NULL, 19, 33, 25, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6405, 39, 6, 2023, 'reported_children_receiving_art', 12300, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6406, 39, 6, 2023, 'estimated_children_needing_art', 31000, NULL, 23000, 41000, 31000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6407, 39, 6, 2023, 'estimated_children_art_coverage_percent', 40, NULL, 29, 54, 40, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6411, 41, 6, 2023, 'reported_children_receiving_art', 30, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6412, 41, 6, 2023, 'estimated_children_needing_art', 100, NULL, 100, 200, 100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6413, 41, 6, 2023, 'estimated_children_art_coverage_percent', 34, NULL, 23, 46, 34, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6423, 45, 6, 2023, 'reported_children_receiving_art', 16000, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6424, 45, 6, 2023, 'estimated_children_needing_art', 64000, NULL, 50000, 76000, 64000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6425, 45, 6, 2023, 'estimated_children_art_coverage_percent', 25, NULL, 20, 30, 25, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6429, 47, 6, 2023, 'reported_children_receiving_art', 80, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6430, 47, 6, 2023, 'estimated_children_needing_art', 810, NULL, 640, 1000, 810, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6431, 47, 6, 2023, 'estimated_children_art_coverage_percent', 10, NULL, 8, 13, 10, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6432, 48, 6, 2023, 'reported_children_receiving_art', 780, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6433, 48, 6, 2023, 'estimated_children_needing_art', 1400, NULL, 1000, 1900, 1400, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6434, 48, 6, 2023, 'estimated_children_art_coverage_percent', 55, NULL, 39, 74, 55, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6435, 49, 6, 2023, 'reported_children_receiving_art', 540, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6436, 49, 6, 2023, 'estimated_children_needing_art', 660, NULL, 500, 1200, 660, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6437, 49, 6, 2023, 'estimated_children_art_coverage_percent', 82, NULL, 54, 95, 82, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6438, 50, 6, 2023, 'reported_children_receiving_art', 180, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6439, 50, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6440, 50, 6, 2023, 'estimated_children_art_coverage_percent', 39, NULL, 36, 42, 39, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6441, 51, 6, 2023, 'reported_children_receiving_art', 150, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6442, 51, 6, 2023, 'estimated_children_needing_art', 610, NULL, 500, 740, 610, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6443, 51, 6, 2023, 'estimated_children_art_coverage_percent', 24, NULL, 19, 30, 24, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6444, 52, 6, 2023, 'reported_children_receiving_art', 770, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6445, 52, 6, 2023, 'estimated_children_needing_art', 5300, NULL, 3800, 7100, 5300, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6446, 52, 6, 2023, 'estimated_children_art_coverage_percent', 14, NULL, 10, 19, 14, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6447, 53, 6, 2023, 'reported_children_receiving_art', 500, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6448, 53, 6, 2023, 'estimated_children_needing_art', 1300, NULL, 930, 2000, 1300, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6449, 53, 6, 2023, 'estimated_children_art_coverage_percent', 37, NULL, 26, 55, 37, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6453, 55, 6, 2023, 'reported_children_receiving_art', 8600, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6454, 55, 6, 2023, 'estimated_children_needing_art', 11000, NULL, 9400, 13000, 11000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6455, 55, 6, 2023, 'estimated_children_art_coverage_percent', 76, NULL, 63, 88, 76, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6456, 56, 6, 2023, 'reported_children_receiving_art', 21500, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6457, 56, 6, 2023, 'estimated_children_needing_art', 36000, NULL, 23000, 55000, 36000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6458, 56, 6, 2023, 'estimated_children_art_coverage_percent', 59, NULL, 38, 90, 59, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6466, 59, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6468, 60, 6, 2023, 'reported_children_receiving_art', 1900, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6469, 60, 6, 2023, 'estimated_children_needing_art', 3200, NULL, 2300, 4400, 3200, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6470, 60, 6, 2023, 'estimated_children_art_coverage_percent', 57, NULL, 41, 78, 57, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6471, 61, 6, 2023, 'reported_children_receiving_art', 550, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6472, 61, 6, 2023, 'estimated_children_needing_art', 1900, NULL, 1400, 2500, 1900, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6473, 61, 6, 2023, 'estimated_children_art_coverage_percent', 30, NULL, 23, 39, 30, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6478, 63, 6, 2023, 'estimated_children_needing_art', 200, NULL, 100, 200, 200, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6480, 64, 6, 2023, 'reported_children_receiving_art', 5900, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6481, 64, 6, 2023, 'estimated_children_needing_art', 30000, NULL, 23000, 37000, 30000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6482, 64, 6, 2023, 'estimated_children_art_coverage_percent', 20, NULL, 15, 25, 20, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6486, 66, 6, 2023, 'reported_children_receiving_art', 730, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6487, 66, 6, 2023, 'estimated_children_needing_art', 2000, NULL, 1800, 2200, 2000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6488, 66, 6, 2023, 'estimated_children_art_coverage_percent', 36, NULL, 33, 39, 36, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6489, 67, 6, 2023, 'reported_children_receiving_art', 2100, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6490, 67, 6, 2023, 'estimated_children_needing_art', 10000, NULL, 7900, 13000, 10000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6491, 67, 6, 2023, 'estimated_children_art_coverage_percent', 20, NULL, 15, 25, 20, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6492, 68, 6, 2023, 'reported_children_receiving_art', 350, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6493, 68, 6, 2023, 'estimated_children_needing_art', 5700, NULL, 4700, 6600, 5700, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6494, 68, 6, 2023, 'estimated_children_art_coverage_percent', 6, NULL, 5, 7, 6, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6495, 69, 6, 2023, 'reported_children_receiving_art', 110, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6496, 69, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6497, 69, 6, 2023, 'estimated_children_art_coverage_percent', 38, NULL, 31, 44, 38, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6498, 70, 6, 2023, 'reported_children_receiving_art', 3400, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6499, 70, 6, 2023, 'estimated_children_needing_art', 8700, NULL, 7000, 9900, 8700, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6500, 70, 6, 2023, 'estimated_children_art_coverage_percent', 40, NULL, 32, 45, 40, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6501, 71, 6, 2023, 'reported_children_receiving_art', 360, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6502, 71, 6, 2023, 'estimated_children_needing_art', 890, NULL, 710, 1100, 890, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6503, 71, 6, 2023, 'estimated_children_art_coverage_percent', 41, NULL, 33, 49, 41, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6513, 75, 6, 2023, 'reported_children_receiving_art', 3900, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6514, 75, 6, 2023, 'estimated_children_needing_art', 18000, NULL, 15000, 20000, 18000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6515, 75, 6, 2023, 'estimated_children_art_coverage_percent', 22, NULL, 19, 26, 22, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6516, 76, 6, 2023, 'reported_children_receiving_art', 510, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6517, 76, 6, 2023, 'estimated_children_needing_art', 880, NULL, 580, 1600, 880, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6518, 76, 6, 2023, 'estimated_children_art_coverage_percent', 58, NULL, 39, 95, 58, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6520, 77, 6, 2023, 'estimated_children_needing_art', 100, NULL, 100, 100, 100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6523, 78, 6, 2023, 'estimated_children_needing_art', 100, NULL, 100, 100, 100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6526, 79, 6, 2023, 'estimated_children_needing_art', 500, NULL, 200, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6528, 80, 6, 2023, 'reported_children_receiving_art', 140, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6529, 80, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6530, 80, 6, 2023, 'estimated_children_art_coverage_percent', 51, NULL, 46, 57, 51, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6537, 83, 6, 2023, 'reported_children_receiving_art', 430, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6538, 83, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6539, 83, 6, 2023, 'estimated_children_art_coverage_percent', 95, NULL, 95, 95, 95, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6540, 84, 6, 2023, 'reported_children_receiving_art', 74300, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6541, 84, 6, 2023, 'estimated_children_needing_art', 120000, NULL, 95000, 160000, 120000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6542, 84, 6, 2023, 'estimated_children_art_coverage_percent', 61, NULL, 47, 78, 61, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6546, 86, 6, 2023, 'reported_children_receiving_art', 450, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6547, 86, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6548, 86, 6, 2023, 'estimated_children_art_coverage_percent', 95, NULL, 95, 95, 95, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6549, 87, 6, 2023, 'reported_children_receiving_art', 280, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6550, 87, 6, 2023, 'estimated_children_needing_art', 700, NULL, 620, 820, 700, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6551, 87, 6, 2023, 'estimated_children_art_coverage_percent', 40, NULL, 35, 46, 40, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6558, 90, 6, 2023, 'reported_children_receiving_art', 8500, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6559, 90, 6, 2023, 'estimated_children_needing_art', 12000, NULL, 9500, 14000, 12000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6560, 90, 6, 2023, 'estimated_children_art_coverage_percent', 70, NULL, 55, 81, 70, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6561, 91, 6, 2023, 'reported_children_receiving_art', 680, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6562, 91, 6, 2023, 'estimated_children_needing_art', 3700, NULL, 3000, 4400, 3700, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6563, 91, 6, 2023, 'estimated_children_art_coverage_percent', 18, NULL, 14, 21, 18, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6564, 92, 6, 2023, 'reported_children_receiving_art', 80, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6565, 92, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6566, 92, 6, 2023, 'estimated_children_art_coverage_percent', 33, NULL, 30, 35, 33, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6573, 95, 6, 2023, 'reported_children_receiving_art', 90, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6574, 95, 6, 2023, 'estimated_children_needing_art', 1900, NULL, 1600, 2500, 1900, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6575, 95, 6, 2023, 'estimated_children_art_coverage_percent', 5, NULL, 4, 6, 5, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6576, 96, 6, 2023, 'reported_children_receiving_art', 45100, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6577, 96, 6, 2023, 'estimated_children_needing_art', 74000, NULL, 57000, 89000, 74000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6578, 96, 6, 2023, 'estimated_children_art_coverage_percent', 61, NULL, 47, 73, 61, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6579, 97, 6, 2023, 'reported_children_receiving_art', 400, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6580, 97, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 520, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6581, 97, 6, 2023, 'estimated_children_art_coverage_percent', 94, NULL, 77, 95, 94, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6585, 99, 6, 2023, 'reported_children_receiving_art', 3400, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6586, 99, 6, 2023, 'estimated_children_needing_art', 19000, NULL, 15000, 24000, 19000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6587, 99, 6, 2023, 'estimated_children_art_coverage_percent', 18, NULL, 14, 23, 18, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6591, 101, 6, 2023, 'reported_children_receiving_art', 180, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6592, 101, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6593, 101, 6, 2023, 'estimated_children_art_coverage_percent', 54, NULL, 46, 66, 54, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6594, 102, 6, 2023, 'reported_children_receiving_art', 40, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6595, 102, 6, 2023, 'estimated_children_needing_art', 100, NULL, 100, 200, 100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6596, 102, 6, 2023, 'estimated_children_art_coverage_percent', 45, NULL, 40, 50, 45, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6598, 103, 6, 2023, 'estimated_children_needing_art', 2300, NULL, 1900, 2600, 2300, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6606, 106, 6, 2023, 'reported_children_receiving_art', 670, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6607, 106, 6, 2023, 'estimated_children_needing_art', 560, NULL, 500, 770, 560, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6608, 106, 6, 2023, 'estimated_children_art_coverage_percent', 95, NULL, 88, 95, 95, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6609, 107, 6, 2023, 'reported_children_receiving_art', 86900, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6610, 107, 6, 2023, 'estimated_children_needing_art', 140000, NULL, 110000, 190000, 140000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6611, 107, 6, 2023, 'estimated_children_art_coverage_percent', 60, NULL, 45, 81, 60, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6612, 108, 6, 2023, 'reported_children_receiving_art', 7900, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6613, 108, 6, 2023, 'estimated_children_needing_art', 9800, NULL, 8400, 11000, 9800, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6614, 108, 6, 2023, 'estimated_children_art_coverage_percent', 80, NULL, 69, 93, 80, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6615, 109, 6, 2023, 'reported_children_receiving_art', 8600, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6616, 109, 6, 2023, 'estimated_children_needing_art', 11000, NULL, 8700, 13000, 11000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6617, 109, 6, 2023, 'estimated_children_art_coverage_percent', 78, NULL, 61, 89, 78, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6618, 110, 6, 2023, 'reported_children_receiving_art', 1300, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6619, 110, 6, 2023, 'estimated_children_needing_art', 1400, NULL, 1200, 1600, 1400, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6620, 110, 6, 2023, 'estimated_children_art_coverage_percent', 91, NULL, 80, 95, 91, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6627, 113, 6, 2023, 'reported_children_receiving_art', 120, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6628, 113, 6, 2023, 'estimated_children_needing_art', 500, NULL, 200, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6629, 113, 6, 2023, 'estimated_children_art_coverage_percent', 55, NULL, 41, 76, 55, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6630, 114, 6, 2023, 'reported_children_receiving_art', 1300, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6631, 114, 6, 2023, 'estimated_children_needing_art', 2500, NULL, 2100, 3200, 2500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6632, 114, 6, 2023, 'estimated_children_art_coverage_percent', 52, NULL, 42, 66, 52, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6633, 115, 6, 2023, 'reported_children_receiving_art', 50200, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6634, 115, 6, 2023, 'estimated_children_needing_art', 140000, NULL, 91000, 220000, 140000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6635, 115, 6, 2023, 'estimated_children_art_coverage_percent', 35, NULL, 22, 53, 35, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6642, 118, 6, 2023, 'reported_children_receiving_art', 610, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6643, 118, 6, 2023, 'estimated_children_needing_art', 5500, NULL, 4700, 6300, 5500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6644, 118, 6, 2023, 'estimated_children_art_coverage_percent', 11, NULL, 10, 13, 11, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6645, 119, 6, 2023, 'reported_children_receiving_art', 200, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6646, 119, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6647, 119, 6, 2023, 'estimated_children_art_coverage_percent', 76, NULL, 69, 84, 76, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6648, 120, 6, 2023, 'reported_children_receiving_art', 1400, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6649, 120, 6, 2023, 'estimated_children_needing_art', 2900, NULL, 2300, 3500, 2900, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6650, 120, 6, 2023, 'estimated_children_art_coverage_percent', 49, NULL, 39, 58, 49, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6651, 121, 6, 2023, 'reported_children_receiving_art', 170, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6652, 121, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 640, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6653, 121, 6, 2023, 'estimated_children_art_coverage_percent', 43, NULL, 28, 68, 43, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6654, 122, 6, 2023, 'reported_children_receiving_art', 740, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6655, 122, 6, 2023, 'estimated_children_needing_art', 1600, NULL, 1100, 2300, 1600, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6656, 122, 6, 2023, 'estimated_children_art_coverage_percent', 48, NULL, 34, 70, 48, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6657, 123, 6, 2023, 'reported_children_receiving_art', 90, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6658, 123, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 510, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6659, 123, 6, 2023, 'estimated_children_art_coverage_percent', 20, NULL, 16, 25, 20, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6664, 125, 6, 2023, 'estimated_children_needing_art', 100, NULL, 100, 100, 100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6666, 126, 6, 2023, 'reported_children_receiving_art', 0, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6672, 128, 6, 2023, 'reported_children_receiving_art', 130, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6673, 128, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 500, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6674, 128, 6, 2023, 'estimated_children_art_coverage_percent', 40, NULL, 30, 55, 40, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6678, 130, 6, 2023, 'reported_children_receiving_art', 170, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6679, 130, 6, 2023, 'estimated_children_needing_art', 100, NULL, 100, 100, 100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6680, 130, 6, 2023, 'estimated_children_art_coverage_percent', 95, NULL, 95, 95, 95, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6684, 132, 6, 2023, 'reported_children_receiving_art', 7500, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6685, 132, 6, 2023, 'estimated_children_needing_art', 12000, NULL, 8900, 15000, 12000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6686, 132, 6, 2023, 'estimated_children_art_coverage_percent', 63, NULL, 47, 80, 63, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6687, 133, 6, 2023, 'reported_children_receiving_art', 120, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6690, 134, 6, 2023, 'reported_children_receiving_art', 1400, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6691, 134, 6, 2023, 'estimated_children_needing_art', 4500, NULL, 3700, 5100, 4500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6692, 134, 6, 2023, 'estimated_children_art_coverage_percent', 31, NULL, 26, 35, 31, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6696, 136, 6, 2023, 'reported_children_receiving_art', 1100, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6697, 136, 6, 2023, 'estimated_children_needing_art', 6600, NULL, 5100, 8500, 6600, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6698, 136, 6, 2023, 'estimated_children_art_coverage_percent', 17, NULL, 13, 22, 17, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6708, 140, 6, 2023, 'reported_children_receiving_art', 190, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6709, 140, 6, 2023, 'estimated_children_needing_art', 1300, NULL, 1100, 1800, 1300, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6710, 140, 6, 2023, 'estimated_children_art_coverage_percent', 14, NULL, 12, 19, 14, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6711, 141, 6, 2023, 'reported_children_receiving_art', 163000, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6712, 141, 6, 2023, 'estimated_children_needing_art', 260000, NULL, 200000, 360000, 260000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6713, 141, 6, 2023, 'estimated_children_art_coverage_percent', 63, NULL, 49, 87, 63, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6714, 142, 6, 2023, 'reported_children_receiving_art', 1500, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6715, 142, 6, 2023, 'estimated_children_needing_art', 16000, NULL, 12000, 21000, 16000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6716, 142, 6, 2023, 'estimated_children_art_coverage_percent', 9, NULL, 7, 12, 9, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6718, 143, 6, 2023, 'estimated_children_needing_art', 100, NULL, 100, 200, 100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6723, 145, 6, 2023, 'reported_children_receiving_art', 620, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6724, 145, 6, 2023, 'estimated_children_needing_art', 4200, NULL, 2400, 6800, 4200, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6725, 145, 6, 2023, 'estimated_children_art_coverage_percent', 15, NULL, 8, 23, 15, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6726, 146, 6, 2023, 'reported_children_receiving_art', 50, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6727, 146, 6, 2023, 'estimated_children_needing_art', 100, NULL, 100, 100, 100, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6728, 146, 6, 2023, 'estimated_children_art_coverage_percent', 72, NULL, 45, 95, 72, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6738, 150, 6, 2023, 'reported_children_receiving_art', 750, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6739, 150, 6, 2023, 'estimated_children_needing_art', 540, NULL, 500, 630, 540, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6740, 150, 6, 2023, 'estimated_children_art_coverage_percent', 95, NULL, 95, 95, 95, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6741, 151, 6, 2023, 'reported_children_receiving_art', 2600, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6742, 151, 6, 2023, 'estimated_children_needing_art', 3200, NULL, 2600, 3800, 3200, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6743, 151, 6, 2023, 'estimated_children_art_coverage_percent', 83, NULL, 68, 95, 83, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6747, 153, 6, 2023, 'reported_children_receiving_art', 4200, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6748, 153, 6, 2023, 'estimated_children_needing_art', 12000, NULL, 11000, 14000, 12000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6749, 153, 6, 2023, 'estimated_children_art_coverage_percent', 34, NULL, 29, 38, 34, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6762, 158, 6, 2023, 'reported_children_receiving_art', 67100, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6763, 158, 6, 2023, 'estimated_children_needing_art', 100000, NULL, 88000, 110000, 100000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6764, 158, 6, 2023, 'estimated_children_art_coverage_percent', 66, NULL, 57, 74, 66, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6765, 159, 6, 2023, 'reported_children_receiving_art', 820, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6766, 159, 6, 2023, 'estimated_children_needing_art', 850, NULL, 750, 980, 850, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6767, 159, 6, 2023, 'estimated_children_art_coverage_percent', 95, NULL, 84, 95, 95, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6774, 162, 6, 2023, 'reported_children_receiving_art', 59600, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6775, 162, 6, 2023, 'estimated_children_needing_art', 92000, NULL, 72000, 110000, 92000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6776, 162, 6, 2023, 'estimated_children_art_coverage_percent', 65, NULL, 51, 80, 65, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6780, 164, 6, 2023, 'reported_children_receiving_art', 80, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6781, 164, 6, 2023, 'estimated_children_needing_art', 200, NULL, 100, 200, 200, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6782, 164, 6, 2023, 'estimated_children_art_coverage_percent', 64, NULL, 47, 90, 64, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6783, 165, 6, 2023, 'reported_children_receiving_art', 5500, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6784, 165, 6, 2023, 'estimated_children_needing_art', 6000, NULL, 5600, 6300, 6000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6785, 165, 6, 2023, 'estimated_children_art_coverage_percent', 93, NULL, 87, 95, 93, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6789, 167, 6, 2023, 'reported_children_receiving_art', 4600, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6790, 167, 6, 2023, 'estimated_children_needing_art', 5000, NULL, 4000, 5900, 5000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6791, 167, 6, 2023, 'estimated_children_art_coverage_percent', 92, NULL, 74, 95, 92, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6792, 168, 6, 2023, 'reported_children_receiving_art', 130, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6793, 168, 6, 2023, 'estimated_children_needing_art', 500, NULL, 500, 580, 500, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6794, 168, 6, 2023, 'estimated_children_art_coverage_percent', 33, NULL, 24, 50, 33, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6795, 169, 6, 2023, 'reported_children_receiving_art', 49100, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6796, 169, 6, 2023, 'estimated_children_needing_art', 62000, NULL, 52000, 74000, 62000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6797, 169, 6, 2023, 'estimated_children_art_coverage_percent', 79, NULL, 65, 93, 79, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6798, 170, 6, 2023, 'reported_children_receiving_art', 63900, NULL, NULL, NULL, NULL, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6799, 170, 6, 2023, 'estimated_children_needing_art', 84000, NULL, 65000, 100000, 84000, 'good', 'art_pediatric_coverage_by_country_clean.csv');
INSERT INTO health_indicators (id, country_id, indicator_type_id, year, value_type, value, value_text, confidence_min, confidence_max, confidence_median, data_quality, source_file) 
VALUES (6800, 170, 6, 2023, 'estimated_children_art_coverage_percent', 76, NULL, 59, 93, 76, 'good', 'art_pediatric_coverage_by_country_clean.csv');

-- Réinitialisation des séquences
SELECT setval('countries_id_seq', (SELECT MAX(id) FROM countries));
SELECT setval('indicator_types_id_seq', (SELECT MAX(id) FROM indicator_types));
SELECT setval('health_indicators_id_seq', (SELECT MAX(id) FROM health_indicators));
