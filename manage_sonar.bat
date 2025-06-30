@echo off
echo ============================
echo GESTION SONARQUBE
echo ============================

cd /d "%~dp0essaidocker"

:MENU
echo.
echo [1] Demarrer SonarQube uniquement
echo [2] Arreter SonarQube
echo [3] Reinitialiser SonarQube (supprime toutes les donnees)
echo [4] Voir les logs de SonarQube
echo [5] Status de SonarQube
echo [6] Quitter
echo.
set /p choix="Votre choix (1-6): "

if "%choix%"=="1" goto START_SONAR
if "%choix%"=="2" goto STOP_SONAR
if "%choix%"=="3" goto RESET_SONAR
if "%choix%"=="4" goto LOGS_SONAR
if "%choix%"=="5" goto STATUS_SONAR
if "%choix%"=="6" exit
goto MENU

:START_SONAR
echo.
echo Demarrage de la base SonarQube...
docker-compose up -d db_sonar
timeout /t 10 /nobreak >nul

echo Demarrage de SonarQube...
docker-compose up -d sonarqube
echo.
echo SonarQube est en cours de demarrage...
echo Il sera accessible dans 1-2 minutes sur: http://localhost:9000
echo Login par defaut: admin / admin
echo.
echo Verification du status...
timeout /t 30 /nobreak >nul
docker-compose logs --tail=10 sonarqube
goto MENU

:STOP_SONAR
echo.
echo Arret de SonarQube...
docker-compose stop sonarqube db_sonar
echo SonarQube arrete.
goto MENU

:RESET_SONAR
echo.
echo ATTENTION: Cette operation va supprimer toutes les donnees SonarQube!
set /p confirm="Confirmer (oui/non): "
if not "%confirm%"=="oui" goto MENU

echo Arret et suppression des conteneurs SonarQube...
docker-compose down sonarqube db_sonar
echo Suppression des volumes SonarQube...
docker volume rm essaidocker_sonarqube_data essaidocker_sonarqube_logs essaidocker_sonarqube_extensions essaidocker_postgresql_sonar 2>nul
echo SonarQube reinitialise.
goto MENU

:LOGS_SONAR
echo.
echo === LOGS SONARQUBE (Ctrl+C pour quitter) ===
docker-compose logs -f sonarqube
goto MENU

:STATUS_SONAR
echo.
echo === STATUS SONARQUBE ===
docker-compose ps sonarqube db_sonar
echo.
echo === ACCES RESEAU ===
curl -s -o nul -w "SonarQube HTTP Status: %%{http_code}\n" http://localhost:9000 2>nul || echo "SonarQube non accessible"
goto MENU
