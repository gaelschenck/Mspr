@echo off
REM filepath: c:\Users\gaels\OneDrive\Documents\ECOLE-EPSI\Mspr\init_and_deploy.bat

:MENU
cls
echo ============================
echo  [1] Sauvegarde des bases PostgreSQL
echo  [2] Restauration des bases PostgreSQL
echo  [3] Deploiement complet (build, apply, logs, etc.)
echo  [4] Quitter
echo ============================
set /p choix="Votre choix : "

if "%choix%"=="1" goto BACKUP
if "%choix%"=="2" goto RESTORE
if "%choix%"=="3" goto DEPLOY
if "%choix%"=="4" exit
goto MENU

:BACKUP
echo.
echo === SAUVEGARDE DES BASES ===
call sauvegardes_bdd\backup_postgres.bat
pause
goto MENU

:RESTORE
echo.
echo === RESTAURATION DES BASES ===
call sauvegardes_bdd\restore_postgres.bat
pause
goto MENU

:DEPLOY
echo.
REM ============================
REM [0/6] Sauvegarde des bases PostgreSQL
REM ============================
echo Sauvegarde des bases PostgreSQL...

set "BACKUP_DIR=sauvegardes_bdd\%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%"
mkdir "%BACKUP_DIR%"

kubectl exec deploy/database -- pg_dump -U postgres bdd_mspr > "%BACKUP_DIR%\bdd_mspr_fr.sql"
kubectl exec deploy/db-us -- pg_dump -U postgres bdd_us > "%BACKUP_DIR%\bdd_us.sql"
kubectl exec deploy/db-ch -- pg_dump -U postgres bdd_ch > "%BACKUP_DIR%\bdd_ch.sql"

echo Sauvegardes terminées dans %BACKUP_DIR%
echo ============================

echo ============================
echo [1/6] Création des ConfigMap SQL
echo ============================
cd /d "%~dp0essaidocker"
kubectl create configmap initdb-sql --from-file=initdb/dump.sql --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap init-us-sql --from-file=init_us/dumpus.sql --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap init-ch-sql --from-file=init_ch/dumpch.sql --dry-run=client -o yaml | kubectl apply -f -
cd ..

echo ============================
echo [2/6] Build des images Docker backend et frontend
echo ============================
cd backend
docker build -t my_backend_image:latest .
cd ..

cd frontend
docker build -t my_frontend_image:latest .
cd ..

echo ============================
echo [3/6] Chargement des images dans Kind
echo ============================
kind load docker-image my_backend_image:latest
kind load docker-image my_frontend_image:latest

echo ============================
echo [4/6] Déploiement des manifests Kubernetes
echo ============================
kubectl apply -f k8s_manifests/

echo ============================
echo [5/6] Redémarrage des pods de base de données
echo ============================
for /f "tokens=1" %%i in ('kubectl get pods -o name ^| findstr /i "database db-ch db-us"') do (
    kubectl delete %%i
)

echo ============================
echo [6/6] Statut final des pods
echo ============================
kubectl get pods

echo.
echo Déploiement terminé !

REM ============================
REM [7/7] Sauvegarde des logs de tous les pods
REM ============================
echo Sauvegarde des logs de tous les pods...

set "LOG_DIR=logs_pods\%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%"
mkdir "%LOG_DIR%"

for /f "skip=1 tokens=1" %%i in ('kubectl get pods --no-headers -o custom-columns=":metadata.name"') do (
    echo Sauvegarde des logs de %%i
    kubectl logs %%i > "%LOG_DIR%\%%i.log"
)

echo Logs sauvegardés dans %LOG_DIR%
echo ============================

pause
goto MENU