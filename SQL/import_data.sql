-- =============================================================================
-- Script : import_data.sql
-- Description : 
-- Ce script importe toutes les données des fichiers CSV dans les tables :
-- - Import des données de référence en premier
-- - Import des données principales ensuite
-- - Vérification des contraintes d'intégrité
-- Les données proviennent du dossier DatasetClean.
-- =============================================================================

-- Désactiver temporairement les contraintes pour l'import
SET session_replication_role = 'replica';

-- Import des données de référence
\COPY pays(id_pays, nom_pays, region) FROM 'DatasetClean/pays_clean.csv' WITH CSV HEADER;
\COPY unite(id_unite, nom_unite) FROM 'DatasetClean/unite_clean.csv' WITH CSV HEADER;
\COPY type_statistique(id_type_statistique, nom_type_statistique) FROM 'DatasetClean/type_statistique_clean.csv' WITH CSV HEADER;
\COPY type_traitement(id_type_traitement, nom_type_traitement) FROM 'DatasetClean/type_traitement_clean.csv' WITH CSV HEADER;

-- Modification des séquences pour les tables de référence
SELECT setval('pays_id_pays_seq', (SELECT MAX(id_pays) FROM pays));
SELECT setval('unite_id_unite_seq', (SELECT MAX(id_unite) FROM unite));
SELECT setval('type_statistique_id_type_statistique_seq', (SELECT MAX(id_type_statistique) FROM type_statistique));
SELECT setval('type_traitement_id_type_traitement_seq', (SELECT MAX(id_type_traitement) FROM type_traitement));

-- Import des données principales en utilisant la valeur médiane
CREATE TEMP TABLE temp_population_hiv (
    id_pays INTEGER,
    annee INTEGER,
    population_min DECIMAL,
    population_median DECIMAL,
    population_max DECIMAL,
    id_unite INTEGER
);

\COPY temp_population_hiv FROM 'DatasetClean/table_population_hiv.csv' WITH CSV HEADER;

-- Vérification et import des données population_hiv
INSERT INTO population_hiv (id_pays, annee, valeur, id_unite)
SELECT 
    id_pays, 
    annee, 
    CASE 
        WHEN population_median < 0 THEN 0 
        ELSE population_median 
    END as valeur,
    id_unite
FROM temp_population_hiv
WHERE id_pays IN (SELECT id_pays FROM pays)
  AND id_unite IN (SELECT id_unite FROM unite);

-- Import des données mortalité
CREATE TEMP TABLE temp_mortalite (
    id_pays INTEGER,
    annee INTEGER,
    mortalite_min DECIMAL,
    mortalite_median DECIMAL,
    mortalite_max DECIMAL,
    id_unite INTEGER
);

\COPY temp_mortalite FROM 'DatasetClean/table_mortalite.csv' WITH CSV HEADER;

-- Vérification et import des données mortalité
INSERT INTO mortalite (id_pays, annee, valeur, id_unite)
SELECT 
    id_pays, 
    annee, 
    CASE 
        WHEN mortalite_median < 0 THEN 0 
        ELSE mortalite_median 
    END as valeur,
    id_unite
FROM temp_mortalite
WHERE id_pays IN (SELECT id_pays FROM pays)
  AND id_unite IN (SELECT id_unite FROM unite);

-- Import des données transmission mère-enfant
CREATE TEMP TABLE temp_transmission (
    id_transmission INTEGER,
    id_pays INTEGER,
    besoin_arv_min DECIMAL,
    besoin_arv_median DECIMAL,
    besoin_arv_max DECIMAL,
    pourcentage_recu_min DECIMAL,
    pourcentage_recu_median DECIMAL,
    pourcentage_recu_max DECIMAL
);

\COPY temp_transmission FROM 'DatasetClean/table_transmission_mere_enfant.csv' WITH CSV HEADER;

-- Vérification et import des données transmission
INSERT INTO transmission_mere_enfant (id_pays, valeur, id_unite)
SELECT 
    id_pays, 
    CASE 
        WHEN pourcentage_recu_median < 0 THEN 0
        WHEN pourcentage_recu_median > 100 THEN 100
        ELSE pourcentage_recu_median
    END as valeur,
    2  -- ID pour pourcentage
FROM temp_transmission
WHERE id_pays IN (SELECT id_pays FROM pays);

-- Import des données traitement
CREATE TEMP TABLE temp_traitement (
    id_traitement INTEGER,
    id_pays INTEGER,
    id_type_traitement INTEGER,
    couverture DECIMAL
);

\COPY temp_traitement FROM 'DatasetClean/table_traitement.csv' WITH CSV HEADER;

-- Vérification et import des données traitement
INSERT INTO traitement (id_pays, valeur, id_unite, id_type_traitement)
SELECT 
    id_pays, 
    CASE 
        WHEN couverture < 0 THEN 0
        WHEN couverture > 100 THEN 100
        ELSE couverture
    END as valeur,
    1,  -- ID pour pourcentage
    id_type_traitement
FROM temp_traitement
WHERE id_pays IN (SELECT id_pays FROM pays)
  AND id_type_traitement IN (SELECT id_type_traitement FROM type_traitement);

-- Import des données statistiques
CREATE TEMP TABLE temp_statistique (
    id_statistique INTEGER,
    id_pays INTEGER,
    annee INTEGER,
    id_type_statistique INTEGER,
    valeur DECIMAL,
    id_unite INTEGER
);

\COPY temp_statistique FROM 'DatasetClean/table_statistique.csv' WITH CSV HEADER;

-- Vérification et import des données statistiques
INSERT INTO statistique (id_pays, annee, valeur, id_unite, id_type_statistique)
SELECT 
    id_pays, 
    annee, 
    CASE 
        WHEN valeur < 0 THEN 0
        ELSE valeur
    END as valeur,
    id_unite,
    id_type_statistique
FROM temp_statistique
WHERE id_pays IN (SELECT id_pays FROM pays)
  AND id_unite IN (SELECT id_unite FROM unite)
  AND id_type_statistique IN (SELECT id_type_statistique FROM type_statistique);

-- Réactiver les contraintes
SET session_replication_role = 'origin';

-- Vérification finale des données
DO $$
BEGIN
    -- Vérifier qu'il n'y a pas de valeurs négatives
    IF EXISTS (
        SELECT 1 FROM population_hiv WHERE valeur < 0
        UNION ALL
        SELECT 1 FROM mortalite WHERE valeur < 0
        UNION ALL
        SELECT 1 FROM transmission_mere_enfant WHERE valeur < 0
        UNION ALL
        SELECT 1 FROM traitement WHERE valeur < 0
        UNION ALL
        SELECT 1 FROM statistique WHERE valeur < 0
    ) THEN
        RAISE EXCEPTION 'Des valeurs négatives ont été trouvées dans les données';
    END IF;

    -- Vérifier que les pourcentages sont entre 0 et 100
    IF EXISTS (
        SELECT 1 FROM transmission_mere_enfant WHERE valeur > 100
        UNION ALL
        SELECT 1 FROM traitement WHERE valeur > 100
    ) THEN
        RAISE EXCEPTION 'Des pourcentages invalides ont été trouvés dans les données';
    END IF;
END $$; 