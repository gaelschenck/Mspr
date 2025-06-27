@echo off
REM Sauvegarde PostgreSQL pour Windows + kubectl (par nom de pod)

REM Formatage de la date pour Windows (YYYY-MM-DD_HH-MM-SS)
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set dt=%%I
set DATE=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%_%dt:~8,2%-%dt:~10,2%-%dt:~12,2%

set BACKUP_DIR=%~dp0dumps
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM Sauvegarde de la base FR
for /f "skip=1 tokens=1" %%i in ('kubectl get pods -o custom-columns="NAME:metadata.name" ^| findstr database') do (
    kubectl exec %%i -- pg_dump -U postgres bdd_mspr > "%BACKUP_DIR%\bdd_mspr_fr_%DATE%.sql"
)
REM Sauvegarde de la base US
for /f "skip=1 tokens=1" %%i in ('kubectl get pods -o custom-columns="NAME:metadata.name" ^| findstr db-us') do (
    kubectl exec %%i -- pg_dump -U postgres bdd_us > "%BACKUP_DIR%\bdd_us_%DATE%.sql"
)
REM Sauvegarde de la base CH
for /f "skip=1 tokens=1" %%i in ('kubectl get pods -o custom-columns="NAME:metadata.name" ^| findstr db-ch') do (
    kubectl exec %%i -- pg_dump -U postgres bdd_ch > "%BACKUP_DIR%\bdd_ch_%DATE%.sql"
)