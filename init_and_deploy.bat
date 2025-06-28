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
call sauvegardes_bdd\restore_bases.bat
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
echo [1/6] Build des images PostgreSQL personnalisees par base
echo ============================
cd /d "%~dp0essaidocker"

REM Build de l'image PostgreSQL pour la base FR
echo [INFO] Construction de l'image PostgreSQL FR...
docker build -f Dockerfile.postgres-fr -t mspr-postgres-fr:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image PostgreSQL FR.
    pause
    goto MENU
)

REM Build de l'image PostgreSQL pour la base US
echo [INFO] Construction de l'image PostgreSQL US...
docker build -f Dockerfile.postgres-us -t mspr-postgres-us:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image PostgreSQL US.
    pause
    goto MENU
)

REM Build de l'image PostgreSQL pour la base CH
echo [INFO] Construction de l'image PostgreSQL CH...
docker build -f Dockerfile.postgres-ch -t mspr-postgres-ch:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image PostgreSQL CH.
    pause
    goto MENU
)

REM Chargement des images dans Kind
echo [INFO] Chargement des images PostgreSQL dans Kind...
kind load docker-image mspr-postgres-fr:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image PostgreSQL FR dans Kind.
    goto MENU
)
kind load docker-image mspr-postgres-us:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image PostgreSQL US dans Kind.
    goto MENU
)
kind load docker-image mspr-postgres-ch:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image PostgreSQL CH dans Kind.
    goto MENU
)

echo [INFO] Images PostgreSQL construites et chargees avec succes
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
echo [5/7] Nettoyage et deploiement des manifests Kubernetes
echo ============================

REM Supprimer les anciens déploiements de bases de données pour forcer la re-création avec les nouvelles images
echo [INFO] Suppression des anciens deployments de bases de donnees...
kubectl delete deployment db-fr db-us db-ch --ignore-not-found=true

REM Supprimer les anciens ConfigMaps qui ne sont plus utilisés
echo [INFO] Suppression des anciens ConfigMaps...
kubectl delete configmap initdb-sql init-us-sql init-ch-sql --ignore-not-found=true

REM Attendre que les suppressions soient effectives
echo [INFO] Attente de la suppression des ressources...
timeout /t 10 /nobreak

REM Deployer tous les manifests
echo [INFO] Deploiement des manifests Kubernetes...
kubectl apply -f k8s_manifests/
if errorlevel 1 (
    echo [ERREUR] Echec du deploiement des manifests.
    pause
    goto MENU
)

echo ============================
echo [6/7] Redemarrage des pods de base de donnees
echo ============================
for /f "tokens=1" %%i in ('kubectl get pods -o name ^| findstr /i "db-fr db-ch db-us"') do (
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