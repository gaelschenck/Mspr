@echo off
echo ============================
echo VERIFICATION AVANT PUSH SONARCLOUD
echo ============================

echo 1. Verification des fichiers vides...
for /r %%f in (*.py *.js *.vue) do (
    if %%~zf == 0 (
        echo ATTENTION: Fichier vide detecte: %%f
    )
)

echo.
echo 2. Verification de la structure des tests...
if exist "backend\tests" (
    echo ✅ Dossier backend/tests trouve
) else (
    echo ❌ Dossier backend/tests manquant
)

if exist "frontend\tests" (
    echo ✅ Dossier frontend/tests trouve
) else (
    echo ❌ Dossier frontend/tests manquant
)

echo.
echo 3. Verification de la configuration SonarCloud...
if exist "sonar-project.properties" (
    echo ✅ sonar-project.properties trouve
    findstr "gaelschenck_Mspr" sonar-project.properties >nul
    if errorlevel 1 (
        echo ❌ Project key incorrect dans sonar-project.properties
    ) else (
        echo ✅ Project key correct
    )
) else (
    echo ❌ sonar-project.properties manquant
)

echo.
echo 4. Test rapide SonarCloud local...
if defined SONAR_TOKEN (
    echo ✅ Token SonarCloud configure
    echo Test de la configuration...
    echo sonar.projectKey=gaelschenck_Mspr > temp-sonar.properties
    echo sonar.organization=gaelschenck >> temp-sonar.properties
    echo sonar.sources=backend,frontend/src >> temp-sonar.properties
    echo sonar.exclusions=**/node_modules/**,**/tests/** >> temp-sonar.properties
    
    where sonar-scanner >nul 2>&1
    if errorlevel 1 (
        echo ⚠️ sonar-scanner non installe (optionnel pour GitHub Actions)
    ) else (
        echo ✅ sonar-scanner disponible
    )
    
    del temp-sonar.properties >nul 2>&1
) else (
    echo ⚠️ SONAR_TOKEN non configure (normal pour push, requis pour test local)
)

echo.
echo ============================
echo VERIFICATION TERMINEE
echo ============================
echo.
echo Pour pousser en toute securite:
echo   git add .
echo   git commit -m "fix: sonar configuration"
echo   git push origin addauth
echo.

pause
