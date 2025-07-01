@echo off
echo =================================
echo   SCRIPT DE DEBUG - init_and_deploy
echo =================================

echo.
echo 1. Test Docker...
docker --version
if errorlevel 1 (
    echo [ERREUR] Docker n'est pas installe ou accessible.
    pause
    exit /b
)
echo Docker OK.

echo.
echo 2. Test Kind...
kind --version
if errorlevel 1 (
    echo [ERREUR] Kind n'est pas installe ou accessible.
    pause
    exit /b
)
echo Kind OK.

echo.
echo 3. Test kubectl...
kubectl version --client
if errorlevel 1 (
    echo [ERREUR] kubectl n'est pas installe ou accessible.
    pause
    exit /b
)
echo kubectl OK.

echo.
echo 4. Liste des clusters Kind...
kind get clusters
echo.

echo 5. Info Docker...
docker info
echo.

echo =================================
echo   Tests termines
echo =================================
pause
