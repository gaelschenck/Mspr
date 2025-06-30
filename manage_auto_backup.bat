@echo off
REM Script de gestion des sauvegardes automatiques avec CronJob Kubernetes

:MENU_AUTO_BACKUP
cls
echo ============================
echo GESTION SAUVEGARDES AUTOMATIQUES
echo ============================
echo  [1] Deployer le systeme de sauvegarde automatique
echo  [2] Voir le statut des CronJobs
echo  [3] Voir les logs des sauvegardes
echo  [4] Executer une sauvegarde manuelle
echo  [5] Supprimer le systeme de sauvegarde automatique
echo  [6] Retour au menu principal
echo ============================
set /p choix_auto="Votre choix : "

if "%choix_auto%"=="1" goto DEPLOY_AUTO_BACKUP
if "%choix_auto%"=="2" goto STATUS_CRONJOB
if "%choix_auto%"=="3" goto LOGS_BACKUP
if "%choix_auto%"=="4" goto MANUAL_BACKUP
if "%choix_auto%"=="5" goto REMOVE_AUTO_BACKUP
if "%choix_auto%"=="6" exit /b
goto MENU_AUTO_BACKUP

:DEPLOY_AUTO_BACKUP
echo.
echo === DEPLOIEMENT DU SYSTEME DE SAUVEGARDE AUTOMATIQUE ===
echo.
echo Deploiement des manifests de sauvegarde automatique...
kubectl apply -f k8s_manifests/backup/
if errorlevel 1 (
    echo [ERREUR] Echec du deploiement des manifests de sauvegarde.
    pause
    goto MENU_AUTO_BACKUP
)

echo.
echo Verification du deploiement...
kubectl get cronjob
kubectl get pv backup-pv
kubectl get pvc backup-pvc

echo.
echo [SUCCESS] Systeme de sauvegarde automatique deploye !
echo Les sauvegardes auront lieu tous les jours a 2h du matin.
echo Les sauvegardes sont stockees sur un volume persistant.
pause
goto MENU_AUTO_BACKUP

:STATUS_CRONJOB
echo.
echo === STATUT DES CRONJOBS ===
echo.
echo CronJobs actifs :
kubectl get cronjob
echo.
echo Jobs recents :
kubectl get jobs --sort-by=.metadata.creationTimestamp
echo.
echo Pods de sauvegarde :
kubectl get pods -l app=backup-cronjob --sort-by=.metadata.creationTimestamp
pause
goto MENU_AUTO_BACKUP

:LOGS_BACKUP
echo.
echo === LOGS DES SAUVEGARDES ===
echo.
echo Recherche du dernier pod de sauvegarde...
for /f "tokens=1" %%i in ('kubectl get pods -l app=backup-cronjob --sort-by=.metadata.creationTimestamp -o name ^| findstr /v "^$" ^| tail -1') do (
    echo Logs du pod %%i :
    kubectl logs %%i
)
pause
goto MENU_AUTO_BACKUP

:MANUAL_BACKUP
echo.
echo === EXECUTION MANUELLE D'UNE SAUVEGARDE ===
echo.
echo Creation d'un Job de sauvegarde manuel...
kubectl create job backup-manual-job --from=cronjob/backup-cronjob
if errorlevel 1 (
    echo [ERREUR] Echec de la creation du job manuel.
    pause
    goto MENU_AUTO_BACKUP
)

echo.
echo Attente de l'execution du job...
timeout /t 5 >nul
kubectl get jobs backup-manual-job
echo.
echo Pour voir les logs en temps reel : kubectl logs job/backup-manual-job -f
pause
goto MENU_AUTO_BACKUP

:REMOVE_AUTO_BACKUP
echo.
echo === SUPPRESSION DU SYSTEME DE SAUVEGARDE AUTOMATIQUE ===
echo.
echo ATTENTION : Cette action va supprimer :
echo - Le CronJob de sauvegarde automatique
echo - Les volumes persistants (et donc les sauvegardes stockees)
echo - Tous les jobs et pods associes
echo.
set /p confirm="Etes-vous sur ? (oui/non) : "
if not "%confirm%"=="oui" goto MENU_AUTO_BACKUP

echo.
echo Suppression en cours...
kubectl delete -f k8s_manifests/backup/
if errorlevel 1 (
    echo [ERREUR] Echec de la suppression.
    pause
    goto MENU_AUTO_BACKUP
)

echo.
echo [SUCCESS] Systeme de sauvegarde automatique supprime.
pause
goto MENU_AUTO_BACKUP
