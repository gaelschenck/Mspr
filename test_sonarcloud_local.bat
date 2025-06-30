@echo off
echo ============================
echo TEST SONARCLOUD LOCAL
echo ============================

REM Vérifier si le token SonarQube est défini
if not defined SONAR_TOKEN (
    echo ERREUR: Variable d'environnement SONAR_TOKEN non definie
    echo.
    echo Pour configurer le token:
    echo 1. Allez sur https://sonarcloud.io/account/security/
    echo 2. Generez un token
    echo 3. Executez: set SONAR_TOKEN=votre_token
    echo 4. Ou ajoutez-le dans les variables d'environnement systeme
    echo.
    pause
    exit /b
)

echo Token SonarQube detecte: %SONAR_TOKEN:~0,8%...
echo.

REM Vérifier si sonar-scanner est installé
where sonar-scanner >nul 2>&1
if errorlevel 1 (
    echo ERREUR: sonar-scanner non trouve dans le PATH
    echo.
    echo Pour installer sonar-scanner:
    echo 1. Telecharger depuis: https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/
    echo 2. Extraire et ajouter bin/ au PATH
    echo 3. Ou utiliser: npm install -g sonarqube-scanner
    echo.
    pause
    exit /b
)

echo sonar-scanner detecte: 
sonar-scanner --version
echo.

echo ============================
echo LANCEMENT DE L'ANALYSE
echo ============================

REM Générer la couverture de test d'abord
echo Generation de la couverture backend...
cd backend
if exist "coverage.xml" del coverage.xml
pip install pytest pytest-cov >nul 2>&1
pytest --cov=. --cov-report=xml --cov-report=html >nul 2>&1
if not exist "coverage.xml" (
    echo ATTENTION: Impossible de generer coverage.xml pour le backend
)
cd ..

echo Generation de la couverture frontend...
cd frontend
if exist "coverage\" rmdir /s /q coverage
npm ci >nul 2>&1
npm run test -- --run --coverage >nul 2>&1
if not exist "coverage\lcov.info" (
    echo ATTENTION: Impossible de generer lcov.info pour le frontend
)
cd ..

echo Lancement de l'analyse SonarCloud...
sonar-scanner ^
  -Dsonar.host.url=https://sonarcloud.io ^
  -Dsonar.token=%SONAR_TOKEN% ^
  -Dsonar.projectKey=gaelschenck_Mspr ^
  -Dsonar.organization=gaelschenck

if errorlevel 1 (
    echo.
    echo ERREUR: L'analyse SonarCloud a echoue
    echo Verifiez:
    echo 1. Le token SONAR_TOKEN
    echo 2. La connexion internet
    echo 3. Les fichiers sonar-project.properties
    pause
    exit /b
)

echo.
echo ============================
echo ANALYSE TERMINEE AVEC SUCCES
echo ============================
echo.
echo Resultats disponibles sur:
echo https://sonarcloud.io/project/overview?id=gaelschenck_Mspr
echo.

pause
