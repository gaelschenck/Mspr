@echo off
REM Vérifier si Docker Desktop est lancé (optionnel, sinon message d'erreur)
docker info >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Docker Desktop n'est pas lance. Lance-le puis relance ce script.
    pause
    exit /b
)

REM Vérifier si le cluster Kind existe déjà
kind get clusters | findstr /i "mspr" >nul
if errorlevel 1 (
    echo Cluster Kind absent, creation en cours...
    kind create cluster --name mspr
    if errorlevel 1 (
        echo [ERREUR] Echec de la creation du cluster mspr.
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
call sauvegardes_bdd\back_up_postgres.bat
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
echo [2/7] Pull des images depuis Docker Hub
echo ============================
cd backend
docker pull gaelschenck/mspr-backend:latest
if errorlevel 1 (
    echo [ERREUR] Echec du pull de l'image backend.
    pause
    goto MENU
)
cd ..

cd frontend
docker pull gaelschenck/mspr-frontend:latest
if errorlevel 1 (
    echo [ERREUR] Echec du pull de l'image frontend.
    pause
    goto MENU
)
cd ..

echo ============================
echo [3/7] Tag des images pour Kind
echo ============================
docker tag gaelschenck/mspr-backend:latest my_backend_image:latest
if errorlevel 1 (
    echo [ERREUR] Echec du tag de l'image backend.
    pause
    goto MENU
)
docker tag gaelschenck/mspr-frontend:latest my_frontend_image:latest
if errorlevel 1 (
    echo [ERREUR] Echec du tag de l'image frontend.
    pause
    goto MENU
)

echo ============================
echo [4/7] Chargement des images dans Kind
echo ============================
kind load docker-image my_backend_image:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image backend dans Kind.
    pause
    goto MENU
)
kind load docker-image my_frontend_image:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image frontend dans Kind.
    pause
    goto MENU
)

echo ============================
echo [5/7] Deploiement des manifests Kubernetes
echo ============================
kubectl apply -f k8s_manifests/
if errorlevel 1 (
    echo [ERREUR] Echec du deploiement des manifests.
    pause
    goto MENU
)

echo ============================
echo [6/7] Redemarrage des pods de base de donnees
echo ============================
for /f "tokens=1" %%i in ('kubectl get pods -o name ^| findstr /i "database db-ch db-us"') do (
    kubectl delete %%i
)

echo ============================
echo [7/7] Statut final des pods et lancement du service
echo ============================
kubectl get pods
start "" cmd /k "kubectl port-forward svc/reverse-proxy-service 8080:80"

echo.
echo Deploiement termine !

REM ============================
REM [8/7] Sauvegarde des bases PostgreSQL après déploiement
REM ============================
echo Sauvegarde des bases PostgreSQL après déploiement...
call sauvegardes_bdd\back_up_postgres.bat
if errorlevel 1 (
    echo [ERREUR] La sauvegarde post-déploiement a échoué.
    pause
    goto MENU
)
echo Sauvegardes post-déploiement terminées.
echo ============================

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

for /f "skip=1 tokens=1" %%i in ('kubectl get pods --no-headers -o custom-columns="NAME:metadata.name"') do (
    echo Sauvegarde des logs de %%i
    kubectl logs %%i > "%LOG_DIR%\%%i.log"
)

echo Logs sauvegardes dans %LOG_DIR%
echo ============================

pause
goto MENU