@echo off
echo ===================================
echo REBUILD BACKEND UNIQUEMENT
echo ===================================

echo.
echo [1/4] Suppression de l'ancienne image backend...
docker rmi mspr-backend:latest 2>nul || echo Aucune image backend à supprimer

echo.
echo [2/4] Build de la nouvelle image backend...
cd backend
docker build --no-cache -t mspr-backend:latest .
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Echec du build backend
    pause
    exit /b 1
)
cd ..

echo.
echo [3/4] Chargement de l'image dans Kind...
kind load docker-image mspr-backend:latest --name mspr
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Echec du chargement dans Kind
    pause
    exit /b 1
)

echo.
echo [4/4] Redémarrage du pod backend...
kubectl delete pods -l app=backend
if %ERRORLEVEL% neq 0 (
    echo ERREUR: Echec de la suppression des pods backend
    pause
    exit /b 1
)

echo.
echo Attente du redémarrage du pod backend...
kubectl wait --for=condition=ready pod -l app=backend --timeout=60s

echo.
echo ===================================
echo BACKEND REBUILD TERMINE !
echo ===================================
echo.
echo Vos changements backend sont maintenant actifs.
echo echo Demarrage du port-forward...
start "" cmd /k "kubectl port-forward svc/reverse-proxy-service 8080:80"
echo.
pause
