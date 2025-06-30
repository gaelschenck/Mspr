#  Export CSV dans NewETL - Documentation

##  Objectif

Le script `NewETL.py` a été amélioré pour **générer des fichiers CSV dans le dossier `DatasetClean`** en plus de créer la base de données SQLite normalisée.

##  Améliorations apportées

### 1. **Nouvelle méthode `export_to_csv_files()`**

Cette méthode exporte automatiquement les données de la base SQLite vers des fichiers CSV :

```python
def export_to_csv_files(self, output_dir: str = None) -> List[str]:
    """
    Exporte les données de la base SQLite vers des fichiers CSV dans DatasetClean
    """
```

### 2. **Fichiers CSV générés**

Le processus ETL génère maintenant les fichiers suivants dans `DatasetClean/` :

| Fichier | Description | Format |
|---------|-------------|---------|
| `pays_clean.csv` | Liste des pays avec régions WHO | UTF-8, séparateur `;` |
| `type_statistique_clean.csv` | Types d'indicateurs de santé | UTF-8, séparateur `;` |
| `table_population_hiv.csv` | Données population VIH | UTF-8, séparateur `;` |
| `table_traitement.csv` | Données traitement antirétroviral | UTF-8, séparateur `;` |
| `table_transmission_mere_enfant.csv` | Données transmission mère-enfant | UTF-8, séparateur `;` |
| `table_mortalite.csv` | Données mortalité liée au SIDA | UTF-8, séparateur `;` |
| `table_statistique.csv` | Toutes les statistiques (fichier global) | UTF-8, séparateur `;` |
| `unite_clean.csv` | Types d'unités de mesure | UTF-8, séparateur `;` |

### 3. **Structure des fichiers CSV**

#### **Fichiers par indicateur** (ex: `table_population_hiv.csv`)
```csv
id,id_pays,pays,annee,valeur,type_valeur,confiance_min,confiance_max,confiance_median,qualite_donnees,fichier_source
1,1,France,2020,50000,Count,48000,52000,50000,High,art_coverage_by_country_clean.csv
```

#### **Fichier global** (`table_statistique.csv`)
```csv
id,id_pays,pays,region,id_type_statistique,type_statistique,annee,valeur,type_valeur,valeur_texte,confiance_min,confiance_max,confiance_median,qualite_donnees,fichier_source,date_creation
```

##  Utilisation

### **Lancement automatique**
L'export CSV se fait automatiquement lors de l'exécution du pipeline ETL :

```bash
cd backend/NewETL
python NewETL.py
```

### **Export CSV seul**
Pour exporter uniquement les CSV depuis une base existante :

```python
from NewETL import HealthDataETL

etl = HealthDataETL()
csv_files = etl.export_to_csv_files("../DatasetClean")
print(f"Fichiers créés: {csv_files}")
```

##  Intégration avec l'interface ETL

### **Endpoints mis à jour**

1. **`/etl/source-files/`** : Détecte automatiquement le séparateur (`,` ou `;`)
2. **`/etl/file-preview/{type}/{name}`** : Affiche correctement les nouveaux fichiers
3. **`/etl/run/`** : Inclut l'export CSV dans le processus

### **Interface utilisateur**

L'onglet ETL du dashboard affiche maintenant :
-  **Fichiers sources** (SourceData/) avec séparateur `,`
-  **Fichiers transformés** (DatasetClean/) avec séparateur `;`
-  **Détection automatique** du format lors de la prévisualisation

##  Cohérence des données

### **Ancien vs Nouveau format**

| Aspect | Anciens fichiers | Nouveaux fichiers |
|--------|------------------|-------------------|
| **Séparateur** | `;` | `;` (cohérent) |
| **Encodage** | UTF-8 | UTF-8 (cohérent) |
| **Structure** | `id,id_pays,annee,valeur,id_unite` | `id,id_pays,pays,annee,valeur,type_valeur,...` |
| **Données** | Format legacy | Format normalisé avec métadonnées |

### **Avantages du nouveau format**

 **Plus riche** : Inclut noms des pays, intervalles de confiance, qualité des données  
 **Normalisé** : Structure cohérente basée sur le schéma de base de données  
 **Traçable** : Fichier source d'origine, date de création  
 **Compatible** : Même séparateur (`;`) que les anciens fichiers  

##  Tests

### **Script de test**
```bash
python test_csv_export.py
```

### **Validation manuelle**
1. Lancer le processus ETL
2. Vérifier la présence des fichiers dans `DatasetClean/`
3. Ouvrir les fichiers CSV dans Excel/LibreOffice
4. Vérifier la cohérence des données

##  Résultat

Maintenant, le processus ETL produit :
-  **Base de données SQLite** normalisée (pour l'API)
-  **Fichiers CSV** structurés (pour l'analyse/export)
-  **Compatibilité** avec l'interface ETL existante
-  **Documentation** et logs détaillés

Cette approche offre le meilleur des deux mondes : une base de données performante pour l'API et des fichiers CSV facilement exploitables pour l'analyse de données.
