@echo off
echo ============================
echo DEMARRAGE RAPIDE SONARQUBE
echo ============================

cd /d "%~dp0essaidocker"

echo Demarrage de la base SonarQube...
docker-compose up -d db_sonar

echo Attente de l'initialisation de la base...
timeout /t 10 /nobreak >nul

echo Demarrage de SonarQube...
docker-compose up -d sonarqube

echo.
echo ============================
echo SONARQUBE EN COURS DE DEMARRAGE
echo ============================
echo.
echo SonarQube sera accessible dans 1-2 minutes sur:
echo   http://localhost:9000
echo.
echo Identifiants par defaut:
echo   Login: admin
echo   Password: admin
echo   (vous devrez changer le mot de passe au premier login)
echo.
echo Pour voir les logs: docker-compose logs -f sonarqube
echo Pour arreter: docker-compose stop sonarqube
echo.

pause
