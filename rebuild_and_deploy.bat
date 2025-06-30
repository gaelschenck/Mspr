@echo off
echo ========================================
echo REBUILD ET DEPLOIEMENT AVEC NOUVELLES DONNEES
echo ========================================
echo.

echo  Reconstruction des images PostgreSQL avec nouvelles données...
cd /d "%~dp0essaidocker"

echo.
echo  Build image postgres-fr...
docker build -f Dockerfile.postgres-fr -t postgres-fr:latest .

echo.
echo  Build image postgres-us...
docker build -f Dockerfile.postgres-us -t postgres-us:latest .

echo.
echo  Build image postgres-ch...
docker build -f Dockerfile.postgres-ch -t postgres-ch:latest .

echo.
echo  Images PostgreSQL reconstruites avec les nouvelles données!
echo.

echo  Pour redéployer, vous pouvez maintenant utiliser:
echo    deploy_local_build.bat
echo.

pause
