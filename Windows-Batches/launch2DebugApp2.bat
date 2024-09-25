@ECHO OFF

set "CURRENT_DIR=%cd%"
set "CONSOLE_HOME=%CURRENT_DIR%"
if exist "%CONSOLE_HOME%\bin\launch2.bat" goto okHome
cd ..
set "CONSOLE_HOME=%cd%"
cd "%CURRENT_DIR%"
:okHome

SET JAVA_OPTS=-Dfinch.log.dir=%CONSOLE_HOME%\logs

SET JAVA_CMD="%JAVA_HOME%"\bin\java.exe -Djava.net.preferIPv4Stack=true
SET EIG_CLASSPATH=%CONSOLE_HOME%\conf;%CONSOLE_HOME%\lib\*

%JAVA_CMD% -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=4000,suspend=y -Dcsdhome=%CONSOLE_HOME% -classpath %EIG_CLASSPATH% %JAVA_OPTS% com.nri.csd.inf.console.BatchLauncher %*