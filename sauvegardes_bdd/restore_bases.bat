@echo off
echo =============================================
echo RESTAURATION DES BASES DE DONNEES MSPR
echo =============================================

set BACKUP_DIR=%~dp0dumps

echo.
echo === SAUVEGARDES DISPONIBLES ===
dir "%BACKUP_DIR%\*corrigee*.sql" /B

echo.
echo === CHOIX DE L'ACTION ===
echo 1. Restaurer TOUTES les bases avec les sauvegardes corrigees
echo 2. Restaurer seulement la base FR
echo 3. Restaurer seulement la base CH  
echo 4. Restaurer seulement la base US
echo 5. Annuler
echo.
set /p CHOICE="Votre choix (1-5): "

if "%CHOICE%"=="1" goto restore_all
if "%CHOICE%"=="2" goto restore_fr
if "%CHOICE%"=="3" goto restore_ch
if "%CHOICE%"=="4" goto restore_us
if "%CHOICE%"=="5" goto end
goto end

:restore_all
echo.
echo === RESTAURATION DE TOUTES LES BASES ===
call :restore_database database-8469446dc7-ssdqz bdd_mspr "%BACKUP_DIR%\bdd_mspr_fr_corrigee_2025-06-28.sql" FR
call :restore_database db-ch-6c564cc4b9-2bdmk bdd_ch "%BACKUP_DIR%\bdd_ch_corrigee_2025-06-28.sql" CH
call :restore_database db-us-b76946d5b-b84xw bdd_us "%BACKUP_DIR%\bdd_us_corrigee_2025-06-28.sql" US
goto verify_all

:restore_fr
call :restore_database database-8469446dc7-ssdqz bdd_mspr "%BACKUP_DIR%\bdd_mspr_fr_corrigee_2025-06-28.sql" FR
goto end

:restore_ch
call :restore_database db-ch-6c564cc4b9-2bdmk bdd_ch "%BACKUP_DIR%\bdd_ch_corrigee_2025-06-28.sql" CH
goto end

:restore_us
call :restore_database db-us-b76946d5b-b84xw bdd_us "%BACKUP_DIR%\bdd_us_corrigee_2025-06-28.sql" US
goto end

:restore_database
set POD_NAME=%1
set DB_NAME=%2
set BACKUP_FILE=%3
set REGION=%4

echo.
echo Restauration de la base %REGION% (%DB_NAME%)...
echo Pod: %POD_NAME%
echo Fichier: %BACKUP_FILE%

:: Copier le fichier de sauvegarde dans le pod
kubectl cp "%BACKUP_FILE%" default/%POD_NAME%:/tmp/restore.sql

:: Supprimer et recréer la base
kubectl exec %POD_NAME% -- env PGPASSWORD=admin psql -U postgres -c "DROP DATABASE IF EXISTS %DB_NAME%;"
kubectl exec %POD_NAME% -- env PGPASSWORD=admin psql -U postgres -c "CREATE DATABASE %DB_NAME%;"

:: Restaurer la base
kubectl exec %POD_NAME% -- env PGPASSWORD=admin psql -U postgres -d %DB_NAME% -f /tmp/restore.sql

echo Base %REGION% restauree avec succes !
goto :eof

:verify_all
echo.
echo === VERIFICATION DES RESTAURATIONS ===
echo.
echo Base FR:
kubectl exec database-8469446dc7-ssdqz -- env PGPASSWORD=admin psql -U postgres -d bdd_mspr -c "SELECT 'FR' as base, COUNT(*) as transmission FROM transmission_mere_enfant;"

echo.
echo Base CH:
kubectl exec db-ch-6c564cc4b9-2bdmk -- env PGPASSWORD=admin psql -U postgres -d bdd_ch -c "SELECT 'CH' as base, COUNT(*) as transmission FROM transmission_mere_enfant;"

echo.
echo Base US:
kubectl exec db-us-b76946d5b-b84xw -- env PGPASSWORD=admin psql -U postgres -d bdd_us -c "SELECT 'US' as base, COUNT(*) as transmission FROM transmission_mere_enfant;"

echo.
echo =============================================
echo RESTAURATION TERMINEE
echo =============================================

:end
echo.
pause
