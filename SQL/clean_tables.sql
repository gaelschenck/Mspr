-- Désactiver temporairement les contraintes de clé étrangère
SET session_replication_role = 'replica';

-- Nettoyage des tables principales
TRUNCATE TABLE statistique CASCADE;
TRUNCATE TABLE traitement CASCADE;
TRUNCATE TABLE transmission_mere_enfant CASCADE;
TRUNCATE TABLE mortalite CASCADE;
TRUNCATE TABLE population_hiv CASCADE;

-- Nettoyage des tables de référence
TRUNCATE TABLE pays CASCADE;
TRUNCATE TABLE unite CASCADE;
TRUNCATE TABLE type_statistique CASCADE;
TRUNCATE TABLE type_traitement CASCADE;

-- Réactiver les contraintes de clé étrangère
SET session_replication_role = 'origin'; 