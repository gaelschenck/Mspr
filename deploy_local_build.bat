@echo off
echo ============================
echo DEPLOIEMENT LOCAL (BUILD LOCAL)
echo ============================

REM Vérifier si Docker Desktop est lancé
docker info >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Docker Desktop n'est pas lance. Lance-le puis relance ce script.
    pause
    exit /b
)

echo ============================
echo [1/6] Creation des ConfigMap SQL
echo ============================
cd /d "%~dp0essaidocker"
kubectl create configmap initdb-sql --from-file=initdb/dump.sql --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap init-us-sql --from-file=init_us/dumpus.sql --dry-run=client -o yaml | kubectl apply -f -
kubectl create configmap init-ch-sql --from-file=init_ch/dumpch.sql --dry-run=client -o yaml | kubectl apply -f -
cd ..

echo ============================
echo [2/6] Build des images locales (avec vos modifications)
echo ============================
cd backend
echo Building backend image...
docker build -t my_backend_image:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image backend.
    pause
    exit /b
)
cd ..

cd frontend
echo Building frontend image...
docker build -t my_frontend_image:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image frontend.
    pause
    exit /b
)
cd ..

echo ============================
echo [3/6] Chargement des images dans Kind
echo ============================
kind load docker-image my_backend_image:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image backend dans Kind.
    pause
    exit /b
)
kind load docker-image my_frontend_image:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image frontend dans Kind.
    pause
    exit /b
)

echo ============================
echo [4/6] Deploiement des manifests Kubernetes
echo ============================
kubectl apply -f k8s_manifests/
if errorlevel 1 (
    echo [ERREUR] Echec du deploiement des manifests.
    pause
    exit /b
)

echo ============================
echo [5/6] Redemarrage des pods backend et DB
echo ============================
echo Suppression des pods backend...
for /f "tokens=1" %%i in ('kubectl get pods -o name ^| findstr /i "backend-"') do (
    kubectl delete %%i
)

echo Suppression des pods DB...
for /f "tokens=1" %%i in ('kubectl get pods -o name ^| findstr /i "db-fr db-ch db-us"') do (
    kubectl delete %%i
)

echo Attente du redemarrage des pods...
timeout /t 10

echo ============================
echo [6/6] Statut final et lancement du service
echo ============================
kubectl get pods
echo.
echo Demarrage du port-forward...
start "" cmd /k "kubectl port-forward svc/reverse-proxy-service 8080:80"

echo.
echo ============================
echo DEPLOIEMENT LOCAL TERMINE !
echo Vos modifications sont maintenant deployees.
echo Acces: http://localhost:8080
echo ============================
pause
