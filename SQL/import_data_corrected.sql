-- =============================================================================
-- Script : import_data.sql
-- Description : Import des données depuis les fichiers CSV
-- Généré automatiquement le 28/06/2025
-- =============================================================================

-- Désactivation des contraintes de clés étrangères temporairement
PRAGMA foreign_keys = OFF;

-- Nettoyage des tables
DELETE FROM statistique;
DELETE FROM traitement;
DELETE FROM transmission_mere_enfant;
DELETE FROM mortalite;
DELETE FROM population_hiv;
DELETE FROM pays;
DELETE FROM type_statistique;
DELETE FROM type_traitement;
DELETE FROM unite;

-- =============================================================================
-- IMPORT DES TABLES DE REFERENCE
-- =============================================================================

-- Import unite
.mode csv
.headers on
.import '../DatasetClean/unite_clean.csv' unite

-- Vérification unite
SELECT 'Table unite:' as info, COUNT(*) as nb_lignes FROM unite;

-- Import type_statistique
.mode csv
.headers on
.import '../DatasetClean/type_statistique_clean.csv' type_statistique

-- Vérification type_statistique
SELECT 'Table type_statistique:' as info, COUNT(*) as nb_lignes FROM type_statistique;

-- Import type_traitement
.mode csv
.headers on
.import '../DatasetClean/type_traitement_clean.csv' type_traitement

-- Vérification type_traitement
SELECT 'Table type_traitement:' as info, COUNT(*) as nb_lignes FROM type_traitement;

-- Import pays
.mode csv
.headers on
.import '../DatasetClean/pays_clean.csv' pays

-- Vérification pays
SELECT 'Table pays:' as info, COUNT(*) as nb_lignes FROM pays;

-- =============================================================================
-- IMPORT DES TABLES DE DONNEES
-- =============================================================================

-- Import population_hiv
.mode csv
.headers on
.import '../DatasetClean/table_population_hiv.csv' population_hiv

-- Vérification population_hiv
SELECT 'Table population_hiv:' as info, COUNT(*) as nb_lignes FROM population_hiv;

-- Import mortalite
.mode csv
.headers on
.import '../DatasetClean/table_mortalite.csv' mortalite

-- Vérification mortalite
SELECT 'Table mortalite:' as info, COUNT(*) as nb_lignes FROM mortalite;

-- Import transmission_mere_enfant
.mode csv
.headers on
.import '../DatasetClean/table_transmission_mere_enfant.csv' transmission_mere_enfant

-- Vérification transmission_mere_enfant
SELECT 'Table transmission_mere_enfant:' as info, COUNT(*) as nb_lignes FROM transmission_mere_enfant;

-- Import traitement
.mode csv
.headers on
.import '../DatasetClean/table_traitement.csv' traitement

-- Vérification traitement
SELECT 'Table traitement:' as info, COUNT(*) as nb_lignes FROM traitement;

-- Import statistique
.mode csv
.headers on
.import '../DatasetClean/table_statistique.csv' statistique

-- Vérification statistique
SELECT 'Table statistique:' as info, COUNT(*) as nb_lignes FROM statistique;

-- Réactivation des contraintes de clés étrangères
PRAGMA foreign_keys = ON;

-- =============================================================================
-- VERIFICATION FINALE
-- =============================================================================

-- Résumé des tables
SELECT 'RESUME DES IMPORTS:' as section;
SELECT name as table_name, 
       (SELECT COUNT(*) FROM unite) as unite_count,
       (SELECT COUNT(*) FROM type_statistique) as type_stat_count,
       (SELECT COUNT(*) FROM type_traitement) as type_trait_count,
       (SELECT COUNT(*) FROM pays) as pays_count,
       (SELECT COUNT(*) FROM population_hiv) as pop_hiv_count,
       (SELECT COUNT(*) FROM mortalite) as mortalite_count,
       (SELECT COUNT(*) FROM transmission_mere_enfant) as transmission_count,
       (SELECT COUNT(*) FROM traitement) as traitement_count,
       (SELECT COUNT(*) FROM statistique) as statistique_count
FROM sqlite_master WHERE type='table' AND name='unite';

-- Test des jointures
SELECT 'TEST JOINTURES:' as section;
SELECT p.pays, COUNT(ph.id) as nb_population_hiv
FROM pays p
LEFT JOIN population_hiv ph ON p.id_pays = ph.id_pays
GROUP BY p.id_pays, p.pays
LIMIT 5;