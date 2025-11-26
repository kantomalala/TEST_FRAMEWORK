@echo off
setlocal EnableDelayedExpansion

set "APP_NAME=mety6"
set "WEB_DIR=webapp"
set "BUILD_DIR=build"
set "LIB_DIR=lib"
set "TOMCAT_HOME=C:\Users\Kanto\OneDrive\Documents\apache-tomcat-10.1.28"
set "TOMCAT_WEBAPPS=%TOMCAT_HOME%\webapps"
set "JAR=%LIB_DIR%\mon-framework.jar"
set "SERVLET_API=%LIB_DIR%\servlet-api.jar"
set "SRC=src\test\urlAnnotations"
set "CLASSES=%BUILD_DIR%\WEB-INF\classes"
set "TEST_CLASSES=%BUILD_DIR%\test-classes"

echo.
echo ========================================
echo   DEPLOIEMENT + TEST SPRINT 4 BIS
echo ========================================
echo.

:: Vérif JAR
if not exist "%JAR%" (
    echo [ERREUR] mon-framework.jar manquant
    pause
    exit /b 1
)

if not exist "%SERVLET_API%" (
    echo [ERREUR] servlet-api.jar manquant dans %LIB_DIR%
    pause
    exit /b 1
)

:: Vérif JSP
if not exist "%WEB_DIR%\WEB-INF\views\test.jsp" (
    echo [ERREUR] test.jsp manquant dans %WEB_DIR%\WEB-INF\views\
    pause
    exit /b 1
)

:: Nettoyage BUILD local
if exist "%BUILD_DIR%" rmdir /s /q "%BUILD_DIR%"
mkdir "%CLASSES%" 2>nul
mkdir "%TEST_CLASSES%" 2>nul
mkdir "%BUILD_DIR%\WEB-INF\lib" 2>nul

:: Nettoyage TOMCAT
echo Nettoyage de l'ancien deploiement...
if exist "%TOMCAT_WEBAPPS%\%APP_NAME%.war" del /f /q "%TOMCAT_WEBAPPS%\%APP_NAME%.war"
if exist "%TOMCAT_WEBAPPS%\%APP_NAME%" rmdir /s /q "%TOMCAT_WEBAPPS%\%APP_NAME%"
if exist "%TOMCAT_HOME%\work\Catalina\localhost\%APP_NAME%" rmdir /s /q "%TOMCAT_HOME%\work\Catalina\localhost\%APP_NAME%"

:: Compilation AVEC servlet-api.jar
echo Compilation du controleur...
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

:: Test console
echo.
echo ========================================
echo      TEST CONSOLE
echo ========================================
echo.
java -cp "%TEST_CLASSES%;%JAR%;%SERVLET_API%" test.urlAnnotations.TestScan

echo.
echo ========================================
echo         TEST TERMINÉ
echo ========================================
echo.

:: Déploiement WEB
echo Deploiement de l'application web...

:: Copier classes + JAR
xcopy /E /I /Y "%TEST_CLASSES%\*" "%CLASSES%\" >nul
copy /Y "%JAR%" "%BUILD_DIR%\WEB-INF\lib\" >nul

:: Copier webapp (web.xml + JSP)
xcopy /E /I /Y "%WEB_DIR%\*" "%BUILD_DIR%\" >nul

:: Vérification structure
echo.
echo === VERIFICATION : Structure du BUILD ===
if exist "%BUILD_DIR%\WEB-INF\views\test.jsp" (
    echo [OK] test.jsp present dans BUILD
) else (
    echo [ERREUR] test.jsp ABSENT dans BUILD !
    pause
    exit /b 1
)

:: Création WAR
cd "%BUILD_DIR%"
jar -cvf "%APP_NAME%.war" * >nul
cd ..

:: Déploiement Tomcat
copy /Y "%BUILD_DIR%\%APP_NAME%.war" "%TOMCAT_WEBAPPS%\" >nul
rmdir /s /q "%BUILD_DIR%"

echo Attente deploiement (5 sec)...
timeout /t 5 /nobreak >nul

echo.
echo ========================================
echo     DEPLOIEMENT TERMINE !
echo ========================================
echo.
echo Test console : AFFICHE CI-DESSUS
echo.
echo URLs disponibles :
echo   http://localhost:8080/%APP_NAME%/test1  (String)
echo   http://localhost:8080/%APP_NAME%/test2  (ModelView + JSP)
echo.
echo Verifie les logs Tomcat si probleme !
echo.
pause