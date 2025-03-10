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

INSERT INTO population_hiv (id_pays, annee, valeur, id_unite)
SELECT id_pays, annee, population_median, id_unite
FROM temp_population_hiv;

-- Répéter le même processus pour les autres tables
CREATE TEMP TABLE temp_mortalite (
    id_pays INTEGER,
    annee INTEGER,
    mortalite_min DECIMAL,
    mortalite_median DECIMAL,
    mortalite_max DECIMAL,
    id_unite INTEGER
);

\COPY temp_mortalite FROM 'DatasetClean/table_mortalite.csv' WITH CSV HEADER;

INSERT INTO mortalite (id_pays, annee, valeur, id_unite)
SELECT id_pays, annee, mortalite_median, id_unite
FROM temp_mortalite;

-- Import des données de transmission mère-enfant
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

INSERT INTO transmission_mere_enfant (id_pays, valeur, id_unite)
SELECT 
    id_pays, 
    COALESCE(pourcentage_recu_median, 0), 
    2
FROM temp_transmission;

-- Import des données de traitement
CREATE TEMP TABLE temp_traitement (
    id_traitement INTEGER,
    id_pays INTEGER,
    id_type_traitement INTEGER,
    couverture DECIMAL
);

\COPY temp_traitement FROM 'DatasetClean/table_traitement.csv' WITH CSV HEADER;

INSERT INTO traitement (id_pays, valeur, id_unite, id_type_traitement)
SELECT id_pays, couverture, 1, id_type_traitement
FROM temp_traitement;

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

INSERT INTO statistique (id_pays, annee, valeur, id_unite, id_type_statistique)
SELECT id_pays, annee, valeur, id_unite, id_type_statistique
FROM temp_statistique; 