@echo off
echo Verification de Docker Desktop...
REM Vérifier si Docker Desktop est lancé (optionnel, sinon message d'erreur)
docker info >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Docker Desktop n'est pas lance. Lance-le puis relance ce script.
    pause
    exit /b
)
echo Docker Desktop OK.

echo Verification du cluster Kind...
REM Vérifier si le cluster Kind existe déjà
kind get clusters 2>nul | findstr /i "mspr" >nul
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

echo Verification de l'acces au cluster...
REM Vérifier que le cluster est bien accessible
kubectl cluster-info >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Impossible de contacter le cluster Kubernetes. Verifie Docker Desktop et Kind.
    pause
    exit /b
)
echo Cluster Kubernetes accessible.

:MENU
cls
echo ============================
echo  [1] Sauvegarde des bases PostgreSQL
echo  [2] Restauration des bases PostgreSQL
echo  [3] Deploiement complet (build, apply, logs, etc.)
echo  [4] Deploiement avec SonarQube (Docker Compose)
echo  [5] Gestion SonarQube uniquement
echo  [6] Gestion des sauvegardes automatiques (CronJob)
echo  [7] Quitter
echo ============================
set /p choix="Votre choix : "

if "%choix%"=="1" goto BACKUP
if "%choix%"=="2" goto RESTORE
if "%choix%"=="3" goto DEPLOY
if "%choix%"=="4" goto DEPLOY_SONAR
if "%choix%"=="5" goto MANAGE_SONAR
if "%choix%"=="6" goto AUTO_BACKUP
if "%choix%"=="7" exit
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
echo [1/5] Pull images PostgreSQL et Build Backend/Frontend
echo ============================

echo  Pull des images PostgreSQL depuis Docker Hub...
docker pull gaelschenck/mspr-postgres-fr:latest
if errorlevel 1 (
    echo [ERREUR] Echec du pull de l'image PostgreSQL FR.
    pause
    goto MENU
)
docker tag gaelschenck/mspr-postgres-fr:latest mspr-postgres-fr:latest

docker pull gaelschenck/mspr-postgres-us:latest
if errorlevel 1 (
    echo [ERREUR] Echec du pull de l'image PostgreSQL US.
    pause
    goto MENU
)
docker tag gaelschenck/mspr-postgres-us:latest mspr-postgres-us:latest

docker pull gaelschenck/mspr-postgres-ch:latest
if errorlevel 1 (
    echo [ERREUR] Echec du pull de l'image PostgreSQL CH.
    pause
    goto MENU
)
docker tag gaelschenck/mspr-postgres-ch:latest mspr-postgres-ch:latest

echo.
echo  Build image backend...
cd backend
docker build -t my_backend_image:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image backend.
    pause
    goto MENU
)
cd ..

echo.
echo  Build image frontend...
cd frontend
docker build -t my_frontend_image:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image frontend.
    pause
    goto MENU
)
cd ..

echo ============================
echo [2/5] Chargement des images dans Kind
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

echo Chargement des images PostgreSQL...
kind load docker-image mspr-postgres-fr:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image PostgreSQL FR dans Kind.
    pause
    goto MENU
)
kind load docker-image mspr-postgres-ch:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image PostgreSQL CH dans Kind.
    pause
    goto MENU
)
kind load docker-image mspr-postgres-us:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image PostgreSQL US dans Kind.
    pause
    goto MENU
)

echo ============================
echo [3/5] Deploiement des manifests Kubernetes
echo ============================
kubectl apply -f k8s_manifests/
if errorlevel 1 (
    echo [ERREUR] Echec du deploiement des manifests.
    pause
    goto MENU
)

echo ============================
echo [4/5] Redemarrage des pods de base de donnees, frontend et backend
echo ============================
echo Redemarrage des pods de base de donnees...
for /f "tokens=1" %%i in ('kubectl get pods -o name ^| findstr /i "db-fr db-ch db-us"') do (
    kubectl delete %%i
)

echo Redemarrage des pods backend...
for /f "tokens=1" %%i in ('kubectl get pods -o name ^| findstr /i "backend-"') do (
    kubectl delete %%i
)

echo Redemarrage du pod frontend...
for /f "tokens=1" %%i in ('kubectl get pods -o name ^| findstr /i "frontend"') do (
    kubectl delete %%i
)

echo ============================
echo [5/5] Statut final des pods et lancement du service
echo ============================
kubectl get pods
start "" cmd /k "kubectl port-forward svc/reverse-proxy-service 8080:80"

echo.
echo Deploiement termine !

REM ============================
REM [6/5] Sauvegarde des bases PostgreSQL après déploiement
REM ============================
echo Sauvegarde des bases PostgreSQL après déploiement...
call sauvegardes_bdd\back_up_postgres.bat
if errorlevel 1 (
    echo [ERREUR] La sauvegarde post-déploiement a échoué.
    pause
    goto MENU
)
echo Sauvegardes post-déploiement terminées.

REM ============================
REM [7/5] Sauvegarde des logs de tous les pods
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

:DEPLOY_SONAR
echo.
echo === DEPLOIEMENT AVEC SONARQUBE (DOCKER COMPOSE) ===
call deploy_with_sonar.bat
if errorlevel 1 (
    echo [ERREUR] Le deploiement avec SonarQube a echoue.
    pause
    goto MENU
)
pause
goto MENU

:MANAGE_SONAR
echo.
echo === GESTION SONARQUBE ===
call manage_sonar.bat
if errorlevel 1 (
    echo [ERREUR] La gestion SonarQube a echoue.
    pause
    goto MENU
)
goto MENU

:AUTO_BACKUP
echo.
echo === GESTION DES SAUVEGARDES AUTOMATIQUES ===
call manage_auto_backup.bat
if errorlevel 1 (
    echo [ERREUR] La gestion des sauvegardes automatiques a echoue.
    pause
    goto MENU
)
goto MENU