@echo off
setlocal

:: ========================================
:: CONFIGURATION
:: ========================================
set "APP_NAME=framework-test"
set "WEB_DIR=webapp"
set "BUILD_DIR=build"
set "LIB_DIR=lib"
set "TOMCAT_WEBAPPS=C:\Users\Kanto\OneDrive\Documents\apache-tomcat-10.1.28\webapps"
set "SERVLET_API_JAR=%LIB_DIR%\servlet-api.jar"
set "FRONT_SERVLET_JAR=%LIB_DIR%\mon-framework.jar"

:: Chemins sprint2
set "SRC_SPRINT2=src\test\urlAnnotations"
set "BUILD_CLASSES=%BUILD_DIR%\WEB-INF\classes"

echo.
echo ========================================
echo   DEPLOIEMENT + TEST SPRINT2
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

if not exist "%SRC_SPRINT2%\Main.java" (
    echo [ERREUR] Main.java manquant dans %SRC_SPRINT2%\
    pause
    exit /b 1
)

:: ========================================
:: 2. COMPILATION SPRINT2 (dans WEB-INF/classes)
:: ========================================
echo Compilation du test sprint2...
mkdir "%BUILD_CLASSES%" 2>nul
javac -cp "%FRONT_SERVLET_JAR%" -d "%BUILD_CLASSES%" %SRC_SPRINT2%\*.java
if errorlevel 1 (
    echo.
    echo [ERREUR] Échec compilation sprint2
    pause
    exit /b 1
)

:: ========================================
:: 3. EXÉCUTION DU TEST (avant déploiement)
:: ========================================
echo.
echo ========================================
echo       RÉSULTAT DU TEST SPRINT2
echo ========================================
echo.
java -cp "%BUILD_CLASSES%;%FRONT_SERVLET_JAR%" test.urlAnnotations.Main

echo.
echo ========================================
echo         TEST TERMINÉ
echo ========================================
echo.

:: ========================================
:: 4. DÉPLOIEMENT WEB
:: ========================================
echo Déploiement de l'application web...

:: Copie librairie
mkdir "%BUILD_DIR%\WEB-INF\lib" 2>nul
copy /Y "%FRONT_SERVLET_JAR%" "%BUILD_DIR%\WEB-INF\lib\" >nul

:: Copie webapp/
xcopy /E /I /Y "%WEB_DIR%\*" "%BUILD_DIR%\" >nul

:: Création WAR
cd "%BUILD_DIR%"
jar -cvf "%APP_NAME%.war" * >nul
cd ..

:: Déploiement Tomcat
copy /Y "%BUILD_DIR%\%APP_NAME%.war" "%TOMCAT_WEBAPPS%\" >nul

:: Nettoyage
rmdir /s /q "%BUILD_DIR%"

:: ========================================
:: 5. FIN
:: ========================================
echo.
echo ========================================
echo     TOUT EST TERMINÉ !
echo ========================================
echo.
echo 1. Test sprint2 : AFFICHÉ CI-DESSUS
echo 2. Web app déployée :
echo    http://localhost:8080/%APP_NAME%/
echo.
echo Redémarre Tomcat si nécessaire.
echo.
pause