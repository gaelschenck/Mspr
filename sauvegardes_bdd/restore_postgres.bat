@echo off
REM Fichier : restore_postgres.bat
REM Restaure les trois bases (FR, US, CH)

set BACKUP_DIR=C:\Users\gaels\OneDrive\Documents\ECOLE-EPSI\Mspr\sauvegardes_bdd\dumps

REM --- Base FR ---
set FILE_FR=bdd_mspr_fr_YYYY-MM-DD_HH-MM-SS.sql
kubectl exec -i deploy/database -- psql -U postgres -d bdd_mspr < "%BACKUP_DIR%\%FILE_FR%"

REM --- Base US ---
set FILE_US=bdd_us_YYYY-MM-DD_HH-MM-SS.sql
kubectl exec -i deploy/db-us -- psql -U postgres -d bdd_us < "%BACKUP_DIR%\%FILE_US%"

REM --- Base CH ---
set FILE_CH=bdd_ch_YYYY-MM-DD_HH-MM-SS.sql
kubectl exec -i deploy/db-ch -- psql -U postgres -d bdd_ch < "%BACKUP_DIR%\%FILE_CH%"