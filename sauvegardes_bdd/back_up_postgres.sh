#!/bin/bash
# filepath: /home/backup/backup_postgres.sh

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="/home/backup/dumps"
mkdir -p "$BACKUP_DIR"

# Sauvegarde de chaque base (adapte les noms si besoin)
kubectl exec deploy/database -- pg_dump -U postgres bdd_mspr > "$BACKUP_DIR/bdd_mspr_fr_$DATE.sql"
kubectl exec deploy/db-us -- pg_dump -U postgres bdd_us > "$BACKUP_DIR/bdd_us_$DATE.sql"
kubectl exec deploy/db-ch -- pg_dump -U postgres bdd_ch > "$BACKUP_DIR/bdd_ch_$DATE.sql"