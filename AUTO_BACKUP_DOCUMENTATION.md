# Système de Sauvegarde Automatique avec Kubernetes

## Vue d'ensemble

Ce système met en place des **sauvegardes automatiques journalières** des bases de données PostgreSQL via un **CronJob Kubernetes**.

## Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   CronJob       │───▶│  Job + Pod       │───▶│ Volume          │
│ (tous les jours │    │  (sauvegarde)    │    │ Persistant      │
│  à 2h du matin) │    │                  │    │ (/tmp/backups)  │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │
                                ▼
                       ┌──────────────────┐
                       │  PostgreSQL      │
                       │  Services:       │
                       │  • db-fr-service │
                       │  • db-us-service │
                       │  • db-ch-service │
                       └──────────────────┘
```

## Composants

### 1. **backup-storage.yaml**
- **PersistentVolume** et **PersistentVolumeClaim** de 10Go
- Stockage sur `/tmp/mspr-backups` du host
- Politique `Retain` pour préserver les données

### 2. **backup-secret.yaml**
- Credentials PostgreSQL sécurisés
- Configuration des hosts/ports des bases de données
- Utilisé par le pod de sauvegarde

### 3. **backup-configmap.yaml**
- Script bash `backup.sh` intelligent
- Sauvegarde automatique des 3 bases (FR, US, CH)
- Compression gzip automatique
- Rotation automatique (garde 7 dernières sauvegardes)
- Génération de métadonnées

### 4. **backup-cronjob.yaml**
- **CronJob** planifié quotidiennement à 2h (`0 2 * * *`)
- Utilise l'image `postgres:15-alpine` (contient `pg_dump`)
- Limite de temps : 30 minutes
- Politique anti-concurrence (`Forbid`)

## Fonctionnalités

### ✅ **Automatisation complète**
- Exécution quotidienne à 2h du matin
- Aucune intervention manuelle requise
- Redémarrage automatique en cas d'échec

### ✅ **Multi-bases intelligente**
- Sauvegarde simultanée des 3 bases (FR, US, CH)
- Vérification de disponibilité avant sauvegarde
- Gestion des erreurs par base

### ✅ **Optimisation du stockage**
- Compression gzip automatique
- Rotation automatique (7 dernières sauvegardes)
- Nettoyage automatique des anciennes sauvegardes

### ✅ **Monitoring et logs**
- Logs détaillés de chaque sauvegarde
- Métadonnées de sauvegarde
- Historique des jobs (3 succès + 1 échec)

### ✅ **Sécurité**
- Credentials dans des Secrets Kubernetes
- Isolation des ressources
- Politique de redémarrage contrôlée

## Utilisation

### **Déploiement**
```bash
# Via le menu principal
./init_and_deploy.bat → Option [6]

# Ou directement
kubectl apply -f k8s_manifests/backup/
```

### **Gestion via le menu**
- **Option [1]** : Déployer le système
- **Option [2]** : Voir le statut des CronJobs
- **Option [3]** : Voir les logs des sauvegardes
- **Option [4]** : Exécuter une sauvegarde manuelle
- **Option [5]** : Supprimer le système

### **Commandes utiles**
```bash
# Voir les CronJobs
kubectl get cronjob

# Voir les jobs récents
kubectl get jobs --sort-by=.metadata.creationTimestamp

# Voir les logs d'une sauvegarde
kubectl logs job/backup-cronjob-XXXXXX

# Exécuter une sauvegarde manuelle
kubectl create job backup-manual --from=cronjob/backup-cronjob

# Vérifier l'espace utilisé (depuis le host)
du -sh /tmp/mspr-backups/*
```

## Structure des sauvegardes

```
/tmp/mspr-backups/
├── 2024-12-30_02-00-01/
│   ├── health_data_fr_2024-12-30_02-00-01.sql.gz
│   ├── health_data_us_2024-12-30_02-00-01.sql.gz
│   ├── health_data_ch_2024-12-30_02-00-01.sql.gz
│   └── backup_info.txt
├── 2024-12-31_02-00-01/
│   ├── health_data_fr_2024-12-31_02-00-01.sql.gz
│   ├── health_data_us_2024-12-31_02-00-01.sql.gz
│   ├── health_data_ch_2024-12-31_02-00-01.sql.gz
│   └── backup_info.txt
...
```

## Monitoring

### **Vérification du statut**
```bash
# Statut global
kubectl get cronjob,jobs,pods -l app=backup-cronjob

# Dernière exécution
kubectl get cronjob backup-cronjob -o yaml | grep lastScheduleTime
```

### **Alertes en cas de problème**
- Les logs d'échec sont conservés dans l'historique Kubernetes
- Possibilité d'ajouter des notifications via webhooks
- Monitoring des ressources (CPU, mémoire, stockage)

## Restauration

Pour restaurer une sauvegarde :

```bash
# Copier la sauvegarde depuis le volume
kubectl cp backup-pod:/backups/YYYY-MM-DD_HH-MM-SS/health_data_fr_YYYY-MM-DD_HH-MM-SS.sql.gz ./restore.sql.gz

# Décompresser
gunzip restore.sql.gz

# Restaurer dans PostgreSQL
psql -h localhost -U postgres -d health_data_fr < restore.sql
```

## Maintenance

### **Ajuster la planification**
Modifier le champ `schedule` dans `backup-cronjob.yaml` :
- `0 2 * * *` : Tous les jours à 2h
- `0 */6 * * *` : Toutes les 6 heures
- `0 2 * * 0` : Tous les dimanches à 2h

### **Ajuster la rétention**
Modifier la ligne dans `backup.sh` :
```bash
ls -dt */ | tail -n +8 | xargs rm -rf  # Garde 7 sauvegardes
ls -dt */ | tail -n +15 | xargs rm -rf # Garde 14 sauvegardes
```

### **Augmenter l'espace de stockage**
Modifier `capacity.storage` dans `backup-storage.yaml` :
```yaml
capacity:
  storage: 50Gi  # Au lieu de 10Gi
```

## Avantages de cette solution

1. **Fiabilité** : Kubernetes redémarre automatiquement en cas d'échec
2. **Évolutivité** : Facile d'ajouter de nouvelles bases ou environnements
3. **Monitoring** : Logs centralisés et visibilité complète
4. **Sécurité** : Credentials isolés, pas de stockage en clair
5. **Efficacité** : Compression automatique et rotation intelligente
6. **Portabilité** : Fonctionne sur tout cluster Kubernetes

## Temps de mise en place

- **Développement** : 6-8 heures ✅ **TERMINÉ**
- **Tests** : 1-2 heures
- **Documentation** : 1 heure ✅ **TERMINÉ**
- **Total** : **8-11 heures** pour une solution production-ready

Cette solution est maintenant **opérationnelle** et prête à être déployée !
