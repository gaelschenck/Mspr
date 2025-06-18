# Sauvegarde et restauration des bases PostgreSQL

## Sauvegarde automatique

- Un script Bash (`backup_postgres.sh`) sauvegarde chaque base dans `/home/backup/dumps/`.
- La sauvegarde est planifiée via cron chaque nuit à 2h.

## Restauration

- Utiliser le script `restore_postgres.sh` pour restaurer une base à partir d’un dump.
- Exemple :  
  ```sh
  kubectl exec -i deploy/database -- psql -U postgres -d bdd_mspr < /home/backup/dumps/bdd_mspr_fr_2025-06-17_02-00-00.sql
  ```

## Test de restauration

- Supprimer des données, restaurer, vérifier l’intégrité.

## Conseils

- Vérifier régulièrement l’espace disque.
- Tester la restauration sur un environnement de test avant production.