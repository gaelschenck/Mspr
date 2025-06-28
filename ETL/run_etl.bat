@echo off
setlocal enabledelayedexpansion

REM =============================================================================
REM Script : run_etl.bat
REM Description : 
REM Ce script exécute tous les scripts ETL dans l'ordre logique :
REM 1. Tables de référence
REM 2. Tables principales
REM Version optimisée avec gestion d'erreurs améliorée
REM =============================================================================

echo Debut du processus ETL global
echo ===============================
echo %date% %time%

REM Vérification de l'existence de Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python n'est pas installé ou accessible
    pause
    exit /b 1
)

REM Fonction pour exécuter un script Python et vérifier son statut
goto :main

:run_etl_script
echo.
echo [%time%] Execution de %~1...
python "%~1"
if %errorlevel% neq 0 (
    echo [ERROR] Erreur lors de l'execution de %~1 - Code: %errorlevel%
    echo [ERROR] Processus ETL interrompu
    pause
    exit /b 1
) else (
    echo [SUCCESS] %~1 termine avec succes
    echo -----------------------------
)
goto :eof

:main
echo 1. Tables de reference
echo -----------------------------
call :run_etl_script "etl_table_unite.py"
if %errorlevel% neq 0 exit /b 1

call :run_etl_script "etl_table_type_statistique.py"
if %errorlevel% neq 0 exit /b 1

call :run_etl_script "etl_table_type_traitement.py"
if %errorlevel% neq 0 exit /b 1

echo.
echo 2. Tables principales
echo -----------------------------
call :run_etl_script "etl_table_pays.py"
if %errorlevel% neq 0 exit /b 1

call :run_etl_script "etl_table_population_hiv.py"
if %errorlevel% neq 0 exit /b 1

call :run_etl_script "etl_table_mortalite.py"
if %errorlevel% neq 0 exit /b 1

call :run_etl_script "etl_table_transmission_mere_enfant.py"
if %errorlevel% neq 0 exit /b 1

call :run_etl_script "etl_table_traitement.py"
if %errorlevel% neq 0 exit /b 1

call :run_etl_script "etl_table_statistique.py"
if %errorlevel% neq 0 exit /b 1

echo.
echo [SUCCESS] Processus ETL global termine avec succes
echo Temps de fin: %date% %time%
echo ===============================
echo.
echo Fichiers generes dans ../DatasetClean/
dir "..\DatasetClean\*.csv" /b 2>nul
echo.
pause
