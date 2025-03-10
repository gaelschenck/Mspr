DROP VIEW IF EXISTS vue_powerbi CASCADE;
DROP VIEW IF EXISTS vue_indicateurs_pays CASCADE;
DROP VIEW IF EXISTS vue_evolution_temporelle CASCADE;

CREATE OR REPLACE VIEW vue_powerbi_complete AS
WITH annees_disponibles AS (
    SELECT DISTINCT annee 
    FROM mortalite 
    WHERE annee IN (SELECT annee FROM population_hiv)
)
SELECT DISTINCT ON (p.id_pays, COALESCE(ph.annee, m.annee, s.annee))
    -- Informations pays
    p.id_pays,
    p.nom_pays,
    p.region,
    
    -- Année de référence
    COALESCE(ph.annee, m.annee, s.annee) as annee,
    
    -- Données HIV
    ph.valeur as population_hiv,
    u_ph.nom_unite as unite_population_hiv,
    
    -- Données mortalité
    m.valeur as mortalite,
    u_m.nom_unite as unite_mortalite,
    
    -- Transmission mère-enfant
    tme.valeur as transmission_mere_enfant,
    u_tme.nom_unite as unite_transmission,
    
    -- Traitements
    tr_adulte.valeur as traitement_adulte,
    tr_enfant.valeur as traitement_enfant,
    u_tr.nom_unite as unite_traitement,
    
    -- Statistiques
    s.valeur as valeur_statistique,
    ts.nom_type_statistique as type_statistique,
    u_s.nom_unite as unite_statistique,
    
    -- Calculs supplémentaires pour analyses
    CASE 
        WHEN LAG(ph.valeur) OVER (PARTITION BY p.id_pays ORDER BY ph.annee) IS NOT NULL 
        THEN ph.valeur - LAG(ph.valeur) OVER (PARTITION BY p.id_pays ORDER BY ph.annee)
    END as evolution_population_hiv,
    
    CASE 
        WHEN LAG(m.valeur) OVER (PARTITION BY p.id_pays ORDER BY m.annee) IS NOT NULL 
        THEN m.valeur - LAG(m.valeur) OVER (PARTITION BY p.id_pays ORDER BY m.annee)
    END as evolution_mortalite,
    
    -- Moyennes régionales pour comparaison
    AVG(ph.valeur) OVER (PARTITION BY p.region, ph.annee) as moyenne_population_hiv_region,
    AVG(m.valeur) OVER (PARTITION BY p.region, m.annee) as moyenne_mortalite_region,
    AVG(tme.valeur) OVER (PARTITION BY p.region) as moyenne_transmission_region,
    AVG(tr_adulte.valeur) OVER (PARTITION BY p.region) as moyenne_traitement_adulte_region,
    AVG(tr_enfant.valeur) OVER (PARTITION BY p.region) as moyenne_traitement_enfant_region

FROM pays p
LEFT JOIN population_hiv ph ON p.id_pays = ph.id_pays
LEFT JOIN unite u_ph ON ph.id_unite = u_ph.id_unite

LEFT JOIN mortalite m ON p.id_pays = m.id_pays AND m.annee = ph.annee
LEFT JOIN unite u_m ON m.id_pays = m.id_pays

LEFT JOIN transmission_mere_enfant tme ON p.id_pays = tme.id_pays
LEFT JOIN unite u_tme ON tme.id_unite = u_tme.id_unite

LEFT JOIN traitement tr_adulte ON p.id_pays = tr_adulte.id_pays AND tr_adulte.id_type_traitement = 1
LEFT JOIN traitement tr_enfant ON p.id_pays = tr_enfant.id_pays AND tr_enfant.id_type_traitement = 2
LEFT JOIN unite u_tr ON tr_adulte.id_unite = u_tr.id_unite

LEFT JOIN statistique s ON p.id_pays = s.id_pays AND s.annee = COALESCE(ph.annee, m.annee)
LEFT JOIN type_statistique ts ON s.id_type_statistique = ts.id_type_statistique
LEFT JOIN unite u_s ON s.id_unite = u_s.id_unite

WHERE ph.annee IN (SELECT annee FROM annees_disponibles)
ORDER BY p.id_pays, COALESCE(ph.annee, m.annee, s.annee), population_hiv;

-- Vue des indicateurs par pays (sans dimension temporelle)
CREATE OR REPLACE VIEW vue_indicateurs_pays AS
SELECT 
    p.id_pays,
    p.nom_pays,
    p.region,
    tme.valeur as taux_transmission_mere_enfant,
    tr_adulte.valeur as taux_traitement_adulte,
    tr_enfant.valeur as taux_traitement_enfant
FROM pays p
LEFT JOIN transmission_mere_enfant tme ON p.id_pays = tme.id_pays
LEFT JOIN traitement tr_adulte ON p.id_pays = tr_adulte.id_pays AND tr_adulte.id_type_traitement = 1
LEFT JOIN traitement tr_enfant ON p.id_pays = tr_enfant.id_pays AND tr_enfant.id_type_traitement = 2;

-- Vue des évolutions temporelles par pays
CREATE OR REPLACE VIEW vue_evolution_temporelle AS
SELECT 
    p.id_pays,
    p.nom_pays,
    p.region,
    ph.annee,
    ph.valeur as population_hiv,
    m.valeur as mortalite,
    s.valeur as valeur_statistique,
    ts.nom_type_statistique
FROM pays p
LEFT JOIN population_hiv ph ON p.id_pays = ph.id_pays
LEFT JOIN mortalite m ON p.id_pays = m.id_pays AND m.annee = ph.annee
LEFT JOIN statistique s ON p.id_pays = s.id_pays AND s.annee = ph.annee
LEFT JOIN type_statistique ts ON s.id_type_statistique = ts.id_type_statistique; 