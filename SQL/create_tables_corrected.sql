-- =============================================================================
-- Script : create_tables.sql
-- Description : Création des tables conformes aux modèles SQLAlchemy
-- Généré automatiquement le 28/06/2025
-- =============================================================================

-- Suppression des tables existantes (dans l'ordre des dépendances)
DROP TABLE IF EXISTS statistique;
DROP TABLE IF EXISTS traitement;
DROP TABLE IF EXISTS transmission_mere_enfant;
DROP TABLE IF EXISTS mortalite;
DROP TABLE IF EXISTS population_hiv;
DROP TABLE IF EXISTS pays;
DROP TABLE IF EXISTS type_statistique;
DROP TABLE IF EXISTS type_traitement;
DROP TABLE IF EXISTS unite;

-- =============================================================================
-- TABLES DE REFERENCE
-- =============================================================================

-- Table: unite
CREATE TABLE unite (
    id_unite INTEGER PRIMARY KEY,
    unite VARCHAR(50) NOT NULL
);

-- Table: type_statistique
CREATE TABLE type_statistique (
    id_type_statistique INTEGER PRIMARY KEY,
    nom_type_statistique VARCHAR(100) NOT NULL
);

-- Table: type_traitement
CREATE TABLE type_traitement (
    id_type_traitement INTEGER PRIMARY KEY,
    nom_type_traitement VARCHAR(100) NOT NULL
);

-- =============================================================================
-- TABLE PRINCIPALE
-- =============================================================================

-- Table: pays
CREATE TABLE pays (
    id_pays INTEGER PRIMARY KEY,
    pays VARCHAR(100) NOT NULL,
    region_who VARCHAR(100)
);

-- =============================================================================
-- TABLES DE DONNEES
-- =============================================================================

-- Table: population_hiv
CREATE TABLE population_hiv (
    id INTEGER PRIMARY KEY,
    id_pays INTEGER,
    annee INTEGER,
    valeur DECIMAL(10,2),
    id_unite INTEGER,
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays),
    FOREIGN KEY (id_unite) REFERENCES unite(id_unite)
);

-- Table: mortalite
CREATE TABLE mortalite (
    id INTEGER PRIMARY KEY,
    id_pays INTEGER,
    annee INTEGER,
    valeur DECIMAL(10,2),
    id_unite INTEGER,
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays),
    FOREIGN KEY (id_unite) REFERENCES unite(id_unite)
);

-- Table: transmission_mere_enfant
CREATE TABLE transmission_mere_enfant (
    id_transmission INTEGER PRIMARY KEY,
    id_pays INTEGER,
    besoin_arv_min DECIMAL(10,2),
    besoin_arv_median DECIMAL(10,2),
    besoin_arv_max DECIMAL(10,2),
    pourcentage_recu_min DECIMAL(5,2),
    pourcentage_recu_median DECIMAL(5,2),
    pourcentage_recu_max DECIMAL(5,2),
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays)
);

-- Table: traitement
CREATE TABLE traitement (
    id INTEGER PRIMARY KEY,
    id_pays INTEGER,
    valeur DECIMAL(10,2),
    id_unite INTEGER,
    id_type_traitement INTEGER,
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays),
    FOREIGN KEY (id_unite) REFERENCES unite(id_unite),
    FOREIGN KEY (id_type_traitement) REFERENCES type_traitement(id_type_traitement)
);

-- Table: statistique
CREATE TABLE statistique (
    id INTEGER PRIMARY KEY,
    id_pays INTEGER,
    annee INTEGER,
    valeur DECIMAL(10,2),
    id_unite INTEGER,
    id_type_statistique INTEGER,
    FOREIGN KEY (id_pays) REFERENCES pays(id_pays),
    FOREIGN KEY (id_unite) REFERENCES unite(id_unite),
    FOREIGN KEY (id_type_statistique) REFERENCES type_statistique(id_type_statistique)
);
