@echo off
echo =================================
echo   Configuration SonarQube Host
echo =================================

echo Detecter votre configuration...

echo.
echo Options disponibles :
echo 1. Local (developpement)     : http://localhost:9000
echo 2. Via reverse proxy         : http://localhost/sonar
echo 3. Serveur distant           : Entrer manuellement
echo 4. Tunnel ngrok (pour CI/CD) : Configuration automatique

echo.
set /p choice="Choisissez une option (1-4) : "

if "%choice%"=="1" (
    set SONAR_HOST=http://localhost:9000
    echo Configuration : Developpement local
    echo SONAR_HOST=%SONAR_HOST%
) else if "%choice%"=="2" (
    set SONAR_HOST=http://localhost/sonar
    echo Configuration : Via reverse proxy nginx
    echo SONAR_HOST=%SONAR_HOST%
    echo Note: Assurez-vous que nginx est demarre avec la nouvelle config
) else if "%choice%"=="3" (
    set /p SONAR_HOST="Entrez l'URL complete de votre serveur SonarQube : "
    echo Configuration : Serveur distant
    echo SONAR_HOST=%SONAR_HOST%
) else if "%choice%"=="4" (
    echo Configuration ngrok...
    where ngrok >nul 2>&1
    if %errorlevel% neq 0 (
        echo ❌ ngrok n'est pas installe
        echo Telechargez ngrok depuis https://ngrok.com/download
        pause
        exit /b 1
    )
    echo Demarrage du tunnel ngrok...
    start /B ngrok http 9000
    timeout /t 3 /nobreak
    echo Recuperation de l'URL ngrok...
    powershell -Command "(Invoke-RestMethod http://localhost:4040/api/tunnels).tunnels[0].public_url" > ngrok_url.tmp
    set /p SONAR_HOST=<ngrok_url.tmp
    del ngrok_url.tmp
    echo Configuration : Tunnel ngrok
    echo SONAR_HOST=%SONAR_HOST%
) else (
    echo Option invalide
    pause
    exit /b 1
)

echo.
echo ✅ Configuration terminee !
echo.
echo Pour utiliser cette configuration :
echo - Tests locaux : Utilisez SONAR_HOST=%SONAR_HOST%
echo - GitHub Secrets : Ajoutez SONAR_HOST_URL=%SONAR_HOST%
echo.

echo Voulez-vous tester la connexion ? (y/n)
set /p test="Reponse : "

if /i "%test%"=="y" (
    echo Test de connexion...
    curl -s "%SONAR_HOST%/api/system/status" 2>nul | findstr "UP" >nul
    if %errorlevel% equ 0 (
        echo  SonarQube est accessible !
    ) else (
        echo  SonarQube n'est pas accessible
        echo Verifiez que SonarQube est demarre
    )
)

echo.
echo Variables d'environnement pour ce script :
echo set SONAR_HOST=%SONAR_HOST%
echo.

pause
