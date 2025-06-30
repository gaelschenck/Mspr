@echo off
echo ============================
echo DEPLOIEMENT AVEC SONARQUBE
echo ============================

REM Vérifier si Docker Desktop est lancé
docker info >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Docker Desktop n'est pas lance. Lance-le puis relance ce script.
    pause
    exit /b
)

echo ============================
echo [1/7] Nettoyage des conteneurs existants
echo ============================
cd /d "%~dp0essaidocker"
docker-compose down -v
echo Conteneurs arretes et volumes supprimes.
echo.

echo ============================
echo [2/7] Build des images backend et frontend
echo ============================
echo Building backend image...
docker build -t my_backend_image ../backend
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image backend.
    pause
    exit /b
)

echo Building frontend image...
docker build -t my_frontend_image ../frontend
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image frontend.
    pause
    exit /b
)

echo ============================
echo [3/7] Demarrage des bases de donnees
echo ============================
echo Demarrage des bases PostgreSQL...
docker-compose up -d db db_us db_ch db_sonar
echo Attente de l'initialisation des bases...
timeout /t 30 /nobreak >nul
echo.

echo ============================
echo [4/7] Demarrage de SonarQube
echo ============================
echo Demarrage de SonarQube...
docker-compose up -d sonarqube
echo Attente de l'initialisation de SonarQube (peut prendre 2-3 minutes)...
echo SonarQube sera accessible sur http://localhost:9000
echo Login par defaut: admin / admin (vous devrez changer le mot de passe au premier login)
timeout /t 60 /nobreak >nul
echo.

echo ============================
echo [5/7] Demarrage des backends
echo ============================
echo Demarrage des backends...
docker-compose up -d backend_fr backend_us backend_ch_de backend_ch_fr backend_ch_en backend_ch_it
echo Attente de l'initialisation des backends...
timeout /t 20 /nobreak >nul
echo.

echo ============================
echo [6/7] Demarrage du frontend
echo ============================
echo Demarrage du frontend...
docker-compose up -d frontend
timeout /t 10 /nobreak >nul
echo.

echo ============================
echo [7/7] Demarrage du reverse proxy
echo ============================
echo Demarrage du reverse proxy...
docker-compose up -d reverse_proxy
echo.

echo ============================
echo DEPLOIEMENT TERMINE
echo ============================
echo.
echo Services disponibles:
echo  Application web:     http://localhost
echo  SonarQube:          http://localhost:9000
echo  Backend FR:         http://localhost:8084
echo  Backend US:         http://localhost:8085
echo  Backend CH (DE):    http://localhost:8088
echo  Backend CH (FR):    http://localhost:8086
echo  Backend CH (EN):    http://localhost:8087
echo  Backend CH (IT):    http://localhost:8089
echo  Frontend:           http://localhost:3000
echo.
echo Status des conteneurs:
docker-compose ps
echo.
echo Logs en temps reel (Ctrl+C pour quitter):
docker-compose logs -f

pause
