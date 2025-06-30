@echo off
REM Script de test du système de sauvegarde automatique

echo ===============================================
echo TEST DU SYSTEME DE SAUVEGARDE AUTOMATIQUE
echo ===============================================

echo.
echo [1/6] Verification de la connexion Kubernetes...
kubectl cluster-info >nul 2>&1
if errorlevel 1 (
    echo [ERREUR] Impossible de contacter le cluster Kubernetes.
    pause
    exit /b 1
)
echo ✓ Cluster Kubernetes accessible

echo.
echo [2/6] Verification des services PostgreSQL...
kubectl get services | findstr "db-fr-service db-us-service db-ch-service"
if errorlevel 1 (
    echo [ERREUR] Services PostgreSQL non trouvés. Déployez d'abord l'application principale.
    pause
    exit /b 1
)
echo ✓ Services PostgreSQL trouvés

echo.
echo [3/6] Deploiement du système de sauvegarde...
kubectl apply -f k8s_manifests/backup/
if errorlevel 1 (
    echo [ERREUR] Échec du déploiement.
    pause
    exit /b 1
)
echo ✓ Manifests déployés

echo.
echo [4/6] Attente de la création des ressources (30s)...
timeout /t 30 >nul

echo.
echo [5/6] Verification des ressources créées...
echo.
echo PersistentVolume:
kubectl get pv backup-pv
echo.
echo PersistentVolumeClaim:
kubectl get pvc backup-pvc
echo.
echo Secret:
kubectl get secret postgres-backup-credentials
echo.
echo ConfigMap:
kubectl get configmap backup-scripts
echo.
echo CronJob:
kubectl get cronjob backup-cronjob

echo.
echo [6/6] Test d'execution manuelle d'une sauvegarde...
echo Creation d'un job de test...
kubectl create job backup-test-job --from=cronjob/backup-cronjob
if errorlevel 1 (
    echo [ERREUR] Échec de la création du job de test.
    pause
    exit /b 1
)

echo.
echo Attente de l'execution du job (60s)...
timeout /t 60 >nul

echo.
echo Statut du job de test:
kubectl get job backup-test-job

echo.
echo Logs du job de test:
for /f "tokens=1" %%i in ('kubectl get pods -l job-name=backup-test-job -o name ^| findstr /v "^$"') do (
    kubectl logs %%i
)

echo.
echo ===============================================
echo TEST TERMINE
echo ===============================================
echo.
echo Pour verifier les sauvegardes:
echo - kubectl get cronjob
echo - kubectl get jobs
echo - kubectl logs job/backup-test-job
echo.
echo Le CronJob s'executera automatiquement tous les jours a 2h du matin.
echo.
pause
