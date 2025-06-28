@echo off
REM Sauvegarde PostgreSQL pour Windows + kubectl (par nom de pod)

REM Formatage de la date pour Windows (YYYY-MM-DD_HH-MM-SS)
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set dt=%%I
set DATE=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%_%dt:~8,2%-%dt:~10,2%-%dt:~12,2%

set BACKUP_DIR=%~dp0dumps
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM Sauvegarde de la base FR
for /f "tokens=1" %%i in ('kubectl get pods --no-headers ^| findstr database') do (
    echo Sauvegarde de la base FR via pod %%i...
    kubectl exec %%i -- env PGPASSWORD=admin pg_dump -U postgres bdd_mspr > "%BACKUP_DIR%\bdd_mspr_fr_%DATE%.sql"
    echo Sauvegarde FR terminee: bdd_mspr_fr_%DATE%.sql
)
REM Sauvegarde de la base US
for /f "tokens=1" %%i in ('kubectl get pods --no-headers ^| findstr db-us') do (
    echo Sauvegarde de la base US via pod %%i...
    kubectl exec %%i -- env PGPASSWORD=admin pg_dump -U postgres bdd_us > "%BACKUP_DIR%\bdd_us_%DATE%.sql"
    echo Sauvegarde US terminee: bdd_us_%DATE%.sql
)
REM Sauvegarde de la base CH
for /f "tokens=1" %%i in ('kubectl get pods --no-headers ^| findstr db-ch') do (
    echo Sauvegarde de la base CH via pod %%i...
    kubectl exec %%i -- env PGPASSWORD=admin pg_dump -U postgres bdd_ch > "%BACKUP_DIR%\bdd_ch_%DATE%.sql"
    echo Sauvegarde CH terminee: bdd_ch_%DATE%.sql
)

echo.
echo ======================================
echo SAUVEGARDES TERMINEES
echo ======================================
echo Dossier: %BACKUP_DIR%
echo Date: %DATE%
echo.
dir "%BACKUP_DIR%\*%DATE%*.sql" /B 2>nul
echo.
echo Les 3 bases de donnees ont ete sauvegardees avec succes !
echo Vous pouvez maintenant utiliser ces sauvegardes comme bases de reference.
echo.
pause