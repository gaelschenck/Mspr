#!/bin/bash
# filepath: /home/backup/restore_postgres.sh

# Exemple pour la base FR
kubectl exec -i deploy/database -- psql -U postgres -d bdd_mspr < /home/backup/dumps/bdd_mspr_fr_YYYY-MM-DD_HH-MM-SS.sql