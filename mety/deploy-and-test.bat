@echo off
setlocal EnableDelayedExpansion

set "APP_NAME=mety33"
set "WEB_DIR=webapp"
set "BUILD_DIR=build"
set "LIB_DIR=lib"
set "TOMCAT_WEBAPPS=C:\Users\Kanto\OneDrive\Documents\apache-tomcat-10.1.28\webapps"
set "JAR=%LIB_DIR%\mon-framework.jar"
set "SERVLET_API=%LIB_DIR%\servlet-api.jar"
set "SRC=src\test\urlAnnotations"
set "CLASSES=%BUILD_DIR%\WEB-INF\classes"
set "TEST_CLASSES=%BUILD_DIR%\test-classes"

echo.
echo ========================================
echo   DEPLOIEMENT + TEST SPRINT3
echo ========================================
echo.

:: Vérif JAR
if not exist "%JAR%" (
    echo [ERREUR] mon-framework.jar manquant
    pause
    exit /b 1
)

if not exist "%SERVLET_API%" (
    echo [ERREUR] servlet-api.jar manquant
    pause
    exit /b 1
)

:: Nettoyage
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
mkdir "%CLASSES%" 2>nul
mkdir "%TEST_CLASSES%" 2>nul
mkdir "%BUILD_DIR%\WEB-INF\lib" 2>nul

:: ========================================
:: PARTIE 1 : TEST CONSOLE (comme Sprint 2)
:: ========================================
echo Compilation du test sprint3...

:: Construire la liste des fichiers Java
set "JAVA_FILES="
for %%f in ("%SRC%\*.java") do (
    set "JAVA_FILES=!JAVA_FILES! "%%f""
)

javac -cp "%JAR%;%SERVLET_API%" -d "%TEST_CLASSES%" %JAVA_FILES%
if errorlevel 1 (
    echo [ERREUR] Compilation test
    pause
    exit /b 1
)

echo.
echo ========================================
echo      RÉSULTAT DU TEST SPRINT3
echo ========================================
echo.
java -cp "%TEST_CLASSES%;%JAR%;%SERVLET_API%" test.urlAnnotations.TestScan

echo.
echo ========================================
echo         TEST TERMINÉ
echo ========================================
echo.

:: ========================================
:: PARTIE 2 : DÉPLOIEMENT WEB (comme Sprint 3)
:: ========================================
echo Déploiement de l'application web...

:: Copier les classes compilées pour le WAR
xcopy /E /I /Y "%TEST_CLASSES%\*" "%CLASSES%\" >nul

:: WAR
copy /Y "%JAR%" "%BUILD_DIR%\WEB-INF\lib\" >nul
xcopy /E /I /Y "%WEB_DIR%\*" "%BUILD_DIR%\" >nul
cd "%BUILD_DIR%"
jar -cvf "%APP_NAME%.war" * >nul
cd ..

:: Déploiement
copy /Y "%BUILD_DIR%\%APP_NAME%.war" "%TOMCAT_WEBAPPS%\" >nul
rmdir /s /q "%BUILD_DIR%"

:: ========================================
:: FIN
:: ========================================
echo.
echo ========================================
echo     TOUT EST TERMINÉ !
echo ========================================
echo.
echo 1. Test sprint3 : AFFICHÉ CI-DESSUS
echo 2. Web app déployée :
echo    http://localhost:8080/%APP_NAME%/test1
echo    http://localhost:8080/%APP_NAME%/test2
echo.
echo Redémarre Tomcat si nécessaire.
echo.
pause