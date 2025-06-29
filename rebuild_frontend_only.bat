@echo off
echo ===================================
echo REBUILD FRONTEND UNIQUEMENT
echo ===================================

echo.
echo [1/4] Suppression de l'ancienne image frontend...
docker rmi mspr-frontend:latest 2>nul || echo Aucune image frontend à supprimer

echo.
echo [2/4] Build de la nouvelle image frontend...
cd frontend
docker build --no-cache -t mspr-frontend:latest .
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Echec du build frontend
    pause
    exit /b 1
)
cd ..

echo.
echo [3/4] Chargement de l'image dans Kind...
kind load docker-image mspr-frontend:latest --name mspr
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Echec du chargement dans Kind
    pause
    exit /b 1
)

echo.
echo [4/4] Redémarrage du pod frontend...
kubectl delete pods -l app=frontend
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Echec de la suppression des pods frontend
    pause
    exit /b 1
)

echo.
echo Attente du redémarrage du pod frontend...
kubectl wait --for=condition=ready pod -l app=frontend --timeout=60s

echo.
echo ===================================
echo FRONTEND REBUILD TERMINE !
echo ===================================
echo.
echo Vos changements frontend sont maintenant actifs.
echo echo Demarrage du port-forward...
start "" cmd /k "kubectl port-forward svc/reverse-proxy-service 8080:80"
echo.
pause
