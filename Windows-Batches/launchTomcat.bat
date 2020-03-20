@echo off
set JAVA_HOME=%JAVA6HOME%
setlocal
REM cd /d %CODEBASE%
if not "%1"=="r" (call build clean install -Dmaven.test.skip -Dall -Ddeployments=gv-aus %1 %2)
echo Exit Code = %ERRORLEVEL%
if not "%ERRORLEVEL%" == "0" exit /b
if exist gv-deployments\gv-dist\target\igv-tomcat.war (
del %CATALINA_HOME%\webapps\igv-*.war
rd /s/q %CATALINA_HOME%\webapps\igv-tomcat
copy gv-deployments\gv-dist\target\igv-tomcat.war %CATALINA_HOME%\webapps
copy "C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\log4j-debug.properties" E:\apache-tomcat-7.0.57\webapps\igv-tomcat\WEB-INF\classes\log4j.properties
)