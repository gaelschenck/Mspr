#  Sauvegarde et Restauration des Bases MSPR

##  Sauvegardes Disponibles

Vous disposez maintenant de **3 sauvegardes corrigées** avec les données transmission_mere_enfant :

| Base | Fichier | Taille | Status |
|------|---------|---------|---------|
| **FR/PRINCIPALE** | `bdd_mspr_fr_corrigee_2025-06-28.sql` | 29 KB |  100 enregistrements |
| **CH/SUISSE** | `bdd_ch_corrigee_2025-06-28.sql` | 29 KB |  100 enregistrements |
| **US** | `bdd_us_corrigee_2025-06-28.sql` | 29 KB |  100 enregistrements |

##  Scripts Disponibles

### 1. **Création de nouvelles sauvegardes**
```cmd
back_up_postgres.bat
```
- Sauvegarde automatique des 3 bases
- Horodatage automatique des fichiers
- Vérification des pods disponibles

### 2. **Restauration des bases**
```cmd
restore_bases.bat
```
- Menu interactif pour choisir quelle(s) base(s) restaurer
- Restauration complète ou individuelle
- Vérification automatique après restauration

##  Utilisation

### Pour sauvegarder l'état actuel :
```cmd
cd sauvegardes_bdd
back_up_postgres.bat
```

### Pour restaurer les bases corrigées :
```cmd
cd sauvegardes_bdd
restore_bases.bat
```
Puis choisir l'option 1 pour restaurer toutes les bases.

##  Ce que contiennent les sauvegardes corrigées

###  **Structure correcte**
- Table `transmission_mere_enfant` avec toutes les colonnes ARV
- Relations fonctionnelles avec les pays
- Utilisateurs par région (FR, CH, US)

###  **Données complètes**
- 170 pays
- 100 enregistrements transmission_mere_enfant
- 4 unités, 5 types statistiques, 3 types traitements
- Utilisateurs distincts par région

###  **Compatibilité**
- Modèle Python corrigé
- API endpoints fonctionnels
- Frontend Vue.js mis à jour

##  Processus de Migration

1. **Sauvegarde actuelle** → Créer un backup de l'état actuel
2. **Restauration corrigée** → Appliquer les sauvegardes avec structure corrigée
3. **Vérification** → Tester l'API et le frontend
4. **Validation** → Confirmer que tout fonctionne

##  Important

- Les sauvegardes incluent les **utilisateurs spécifiques à chaque région**
- La structure `transmission_mere_enfant` est **définitivement corrigée**
- Les données sont **cohérentes entre les 3 bases**
- L'architecture **multi-régions est préservée**

##  Avantages

 **Bases de référence stables** pour développement  
 **Retour rapide à un état fonctionnel** en cas de problème  
 **Architecture multi-régions préservée**  
 **Données complètes et cohérentes**  
 **Structure optimisée** pour l'API et le frontend
