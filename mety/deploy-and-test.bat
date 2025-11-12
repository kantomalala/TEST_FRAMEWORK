@echo off
setlocal EnableDelayedExpansion

set "APP_NAME=mety"
set "WEB_DIR=webapp"
set "BUILD_DIR=build"
set "LIB_DIR=lib"
set "TOMCAT_WEBAPPS=C:\Users\Kanto\OneDrive\Documents\apache-tomcat-10.1.28\webapps"
set "JAR=%LIB_DIR%\mon-framework.jar"
set "SRC=src\test\urlAnnotations"
set "CLASSES=%BUILD_DIR%\WEB-INF\classes"

echo.
echo ========================================
echo     DEPLOIEMENT DIRECT - NAVIGATEUR
echo ========================================
echo.

:: Vérif JAR
if not exist "%JAR%" (
    echo [ERREUR] mon-framework.jar manquant
    pause
    exit /b 1
)

:: Nettoyage
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
mkdir "%CLASSES%" 2>nul
mkdir "%BUILD_DIR%\WEB-INF\lib" 2>nul

:: Compilation
echo Compilation du controleur...
set "JAVA_FILES="
for /f "delims=" %%f in ('dir /b "%SRC%\*.java" 2^>nul') do (
    set "JAVA_FILES=!JAVA_FILES! "%SRC%\%%f""
)

javac -cp "%JAR%" -d "%CLASSES%" %JAVA_FILES%
if errorlevel 1 (
    echo [ERREUR] Compilation
    pause
    exit /b 1
)

:: WAR
echo Creation du WAR...
copy /Y "%JAR%" "%BUILD_DIR%\WEB-INF\lib\" >nul
xcopy /E /I /Y "%WEB_DIR%\*" "%BUILD_DIR%\" >nul
cd "%BUILD_DIR%"
jar -cvf "%APP_NAME%.war" * >nul
cd ..

:: Déploiement
copy /Y "%BUILD_DIR%\%APP_NAME%.war" "%TOMCAT_WEBAPPS%\" >nul
rmdir /s /q "%BUILD_DIR%"

:: OUVERTURE DIRECTE /test1
echo.
echo DEPLOYE ! OUVERTURE DE /test1
echo http://localhost:8080/%APP_NAME%/test1
echo.
start http://localhost:8080/%APP_NAME%/test1

echo Redemarre Tomcat si necessaire.
echo.
pause