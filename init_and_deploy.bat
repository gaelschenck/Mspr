@echo off
REM filepath: c:\Users\gaels\OneDrive\Documents\ECOLE-EPSI\Mspr\init_and_deploy.bat

REM Vérifier si Docker Desktop est lancé (optionnel, sinon message d'erreur)
docker info >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Docker Desktop n'est pas lance. Lance-le puis relance ce script.
    pause
    exit /b
)

REM Vérifier si le cluster Kind existe déjà
kind get clusters | findstr /i "mspr-cluster" >nul
if errorlevel 1 (
    echo Cluster Kind absent, creation en cours...
    kind create cluster --name mspr-cluster
    if errorlevel 1 (
        echo [ERREUR] Echec de la creation du cluster Kind.
        pause
        exit /b
    )
) else (
    echo Cluster Kind deja present.
)

REM Vérifier que le cluster est bien accessible
kubectl cluster-info >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Impossible de contacter le cluster Kubernetes. Verifie Docker Desktop et Kind.
    pause
    exit /b
)

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
if errorlevel 1 (
    echo [ERREUR] La sauvegarde a echoue.
    pause
    goto MENU
)
pause
goto MENU

:RESTORE
echo.
echo === RESTAURATION DES BASES ===
call sauvegardes_bdd\restore_postgres.bat
if errorlevel 1 (
    echo [ERREUR] La restauration a echoue.
    pause
    goto MENU
)
pause
goto MENU

:DEPLOY
echo.
REM ============================
REM [0/6] Sauvegarde des bases PostgreSQL
REM ============================
echo Sauvegarde des bases PostgreSQL...

set "BACKUP_DIR=sauvegardes_bdd\%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%"
if exist "%BACKUP_DIR%" rmdir /s /q "%BACKUP_DIR%"
mkdir "%BACKUP_DIR%"
if errorlevel 1 (
    echo [ERREUR] Impossible de creer le dossier de sauvegarde %BACKUP_DIR%.
    pause
    goto MENU
)

kubectl exec deploy/database -- pg_dump -U postgres bdd_mspr > "%BACKUP_DIR%\bdd_mspr_fr.sql"
if errorlevel 1 (
    echo [ERREUR] Echec de la sauvegarde de bdd_mspr_fr.
)
kubectl exec deploy/db-us -- pg_dump -U postgres bdd_us > "%BACKUP_DIR%\bdd_us.sql"
if errorlevel 1 (
    echo [ERREUR] Echec de la sauvegarde de bdd_us.
)
kubectl exec deploy/db-ch -- pg_dump -U postgres bdd_ch > "%BACKUP_DIR%\bdd_ch.sql"
if errorlevel 1 (
    echo [ERREUR] Echec de la sauvegarde de bdd_ch.
)

echo Sauvegardes terminees dans %BACKUP_DIR%
echo ============================

echo ============================
echo [1/6] Creation des ConfigMap SQL
echo ============================
cd /d "%~dp0essaidocker"
kubectl create configmap initdb-sql --from-file=initdb/dump.sql --dry-run=client -o yaml | kubectl apply -f -
if errorlevel 1 (
    echo [ERREUR] Echec creation ConfigMap initdb-sql.
)
kubectl create configmap init-us-sql --from-file=init_us/dumpus.sql --dry-run=client -o yaml | kubectl apply -f -
if errorlevel 1 (
    echo [ERREUR] Echec creation ConfigMap init-us-sql.
)
kubectl create configmap init-ch-sql --from-file=init_ch/dumpch.sql --dry-run=client -o yaml | kubectl apply -f -
if errorlevel 1 (
    echo [ERREUR] Echec creation ConfigMap init-ch-sql.
)
cd ..

echo ============================
echo [2/6] Build des images Docker backend et frontend
echo ============================
cd backend
docker build -t my_backend_image:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image backend.
    pause
    goto MENU
)
cd ..

cd frontend
docker build -t my_frontend_image:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image frontend.
    pause
    goto MENU
)
cd ..

echo ============================
echo [3/6] Chargement des images dans Kind
echo ============================
kind load docker-image my_backend_image:latest
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image backend dans Kind.
    pause
    goto MENU
)
kind load docker-image my_frontend_image:latest
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image frontend dans Kind.
    pause
    goto MENU
)

echo ============================
echo [4/6] Deploiement des manifests Kubernetes
echo ============================
kubectl apply -f k8s_manifests/
if errorlevel 1 (
    echo [ERREUR] Echec du deploiement des manifests.
    pause
    goto MENU
)

echo ============================
echo [5/6] Redemarrage des pods de base de donnees
echo ============================
for /f "tokens=1" %%i in ('kubectl get pods -o name ^| findstr /i "database db-ch db-us"') do (
    kubectl delete %%i
)

echo ============================
echo [6/6] Statut final des pods et lancement du service
echo ============================
kubectl get pods
start "" cmd /k "kubectl port-forward svc/reverse-proxy-service 8080:80"

echo.
echo Deploiement termine !

REM ============================
REM [7/7] Sauvegarde des logs de tous les pods
REM ============================
echo Sauvegarde des logs de tous les pods...

set "LOG_DIR=logs_pods\%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%"
if exist "%LOG_DIR%" rmdir /s /q "%LOG_DIR%"
mkdir "%LOG_DIR%"
if errorlevel 1 (
    echo [ERREUR] Impossible de creer le dossier de logs %LOG_DIR%.
    pause
    goto MENU
)

for /f "skip=1 tokens=1" %%i in ('kubectl get pods --no-headers -o custom-columns=":metadata.name"') do (
    echo Sauvegarde des logs de %%i
    kubectl logs %%i > "%LOG_DIR%\%%i.log"
)

echo Logs sauvegardes dans %LOG_DIR%
echo ============================

pause
goto MENU