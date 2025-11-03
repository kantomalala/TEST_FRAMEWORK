@echo off
setlocal EnableDelayedExpansion

:: ========================================
:: CONFIGURATION
:: ========================================
set "APP_NAME=framework-test"
set "WEB_DIR=webapp"
set "BUILD_DIR=build"
set "LIB_DIR=lib"
set "TOMCAT_WEBAPPS=C:\Users\Kanto\OneDrive\Documents\apache-tomcat-10.1.28\webapps"
set "FRONT_SERVLET_JAR=%LIB_DIR%\mon-framework.jar"

:: Chemins sprint2
:: Compile all sources under src so helper classes (e.g. framework.annotations) are included
set "SRC_SPRINT2=src"
set "BUILD_CLASSES=%BUILD_DIR%\WEB-INF\classes"

echo.
echo ========================================
echo     DEPLOIEMENT FRAMEWORK WEB
echo ========================================
echo.

:: ========================================
:: 1. VÉRIFICATIONS
:: ========================================
if not exist "%FRONT_SERVLET_JAR%" (
    echo [ERREUR] mon-framework.jar manquant dans %LIB_DIR%\
    pause
    exit /b 1
)

if not exist "%WEB_DIR%\WEB-INF\web.xml" (
    echo [ERREUR] web.xml manquant dans %WEB_DIR%\WEB-INF\
    pause
    exit /b 1
)

:: ========================================
:: 2. COMPILATION DES CONTRÔLEURS
:: ========================================
echo Compilation des controleurs...

:: Nettoyage
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
mkdir "%BUILD_CLASSES%" 2>nul
mkdir "%BUILD_DIR%\WEB-INF\lib" 2>nul

:: Liste tous les .java sous le dossier (récursif) into a temp sources file
set "SOURCES_FILE=%BUILD_DIR%\sources.txt"
if exist "%SOURCES_FILE%" del /q "%SOURCES_FILE%"
for /r "%SRC_SPRINT2%" %%f in (*.java) do (
    echo %%~f>>"%SOURCES_FILE%"
)

:: Si aucun fichier → erreur
if not exist "%SOURCES_FILE%" (
    echo [ERREUR] Aucun fichier .java trouve dans %SRC_SPRINT2%\
    pause
    exit /b 1
)
for %%I in ("%SOURCES_FILE%") do set "_SRC_SIZE=%%~zI"
if "%_SRC_SIZE%"=="0" (
    echo [ERREUR] Aucun fichier .java trouve dans %SRC_SPRINT2%\
    pause
    exit /b 1
)

:: Compilation using javac @sources.txt to avoid quoting pitfalls
javac -cp "%FRONT_SERVLET_JAR%" -d "%BUILD_CLASSES%" @"%SOURCES_FILE%"
if errorlevel 1 (
    echo.
    echo [ERREUR] Echec compilation des controleurs
    pause
    exit /b 1
)

:: ========================================
:: 3. DÉPLOIEMENT WEB
:: ========================================
echo.
echo Creation du WAR...

:: Copie du JAR
copy /Y "%FRONT_SERVLET_JAR%" "%BUILD_DIR%\WEB-INF\lib\" >nul

:: Copie webapp/
xcopy /E /I /Y "%WEB_DIR%\*" "%BUILD_DIR%\" >nul

:: Création WAR
cd "%BUILD_DIR%"
jar -cvf "%APP_NAME%.war" * >nul
cd ..

:: Déploiement
copy /Y "%BUILD_DIR%\%APP_NAME%.war" "%TOMCAT_WEBAPPS%\" >nul

:: Nettoyage
rmdir /s /q "%BUILD_DIR%"

:: ========================================
:: 4. FIN + OUVERTURE NAVIGATEUR
:: ========================================
echo.
echo ========================================
echo     DEPLOIEMENT TERMINE !
echo ========================================
echo.
echo Application deployee :
echo    http://localhost:8080/%APP_NAME%/
echo.
echo Testez :
echo   - http://localhost:8080/%APP_NAME%/routes
echo   - http://localhost:8080/%APP_NAME%/test1
echo.
start http://localhost:8080/%APP_NAME%/routes

echo Redemarre Tomcat si necessaire.
echo.
pause