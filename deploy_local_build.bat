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
echo [1/6] Build des images PostgreSQL par pays
echo ============================
cd /d "%~dp0essaidocker"
echo Building PostgreSQL FR image...
docker build -f Dockerfile.postgres-fr -t mspr-postgres-fr:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image PostgreSQL FR.
    pause
    exit /b
)

echo Building PostgreSQL US image...
docker build -f Dockerfile.postgres-us -t mspr-postgres-us:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image PostgreSQL US.
    pause
    exit /b
)

echo Building PostgreSQL CH image...
docker build -f Dockerfile.postgres-ch -t mspr-postgres-ch:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image PostgreSQL CH.
    pause
    exit /b
)
cd ..

echo ============================
echo [2/6] Build des images applicatives (avec vos modifications)
echo ============================
cd backend
echo Building backend image (no cache)...
docker build --no-cache -t my_backend_image:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image backend.
    pause
    exit /b
)
cd ..

cd frontend
echo Building frontend image (no cache)...
docker build --no-cache -t my_frontend_image:latest .
if errorlevel 1 (
    echo [ERREUR] Echec du build de l'image frontend.
    pause
    exit /b
)
cd ..

echo ============================
echo [3/6] Chargement des images dans Kind
echo ============================
kind load docker-image mspr-postgres-fr:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image PostgreSQL FR dans Kind.
    pause
    exit /b
)
kind load docker-image mspr-postgres-us:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image PostgreSQL US dans Kind.
    pause
    exit /b
)
kind load docker-image mspr-postgres-ch:latest --name mspr
if errorlevel 1 (
    echo [ERREUR] Echec du chargement de l'image PostgreSQL CH dans Kind.
    pause
    exit /b
)
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
echo [4/6] Nettoyage des anciens deploiements
echo ============================
echo Suppression des anciens deployments et services...
kubectl delete deployment db-fr-deployment db-us-deployment db-ch-deployment --ignore-not-found=true
kubectl delete deployment backend-fr-deployment backend-us-deployment backend-ch-deployment --ignore-not-found=true
kubectl delete deployment frontend-deployment --ignore-not-found=true
kubectl delete deployment reverse-proxy-deployment --ignore-not-found=true

echo Suppression des anciens ConfigMaps (obsoletes)...
kubectl delete configmap initdb-sql init-us-sql init-ch-sql --ignore-not-found=true

echo Attente du nettoyage...
timeout /t 15

echo ============================
echo [5/6] Deploiement des manifests Kubernetes
echo ============================
kubectl apply -f k8s_manifests/
if errorlevel 1 (
    echo [ERREUR] Echec du deploiement des manifests.
    pause
    exit /b
)

echo ============================
echo [6/6] Statut final et lancement du service
echo ============================
echo Attente que tous les pods soient prets...
timeout /t 15

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
