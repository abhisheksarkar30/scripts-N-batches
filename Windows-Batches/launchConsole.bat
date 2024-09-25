@echo off
REM JAVA_HOME=%JAVA6HOME%
setlocal
REM cd /d %CODEBASE%
if not "%1"=="r" (call mvn clean install -Dmaven.test.skip -Dall -Drest -Ddeployments=gv-aus %1 %2)
echo Exit Code = %ERRORLEVEL%
if not "%ERRORLEVEL%" == "0" exit /b
if exist gv-deployments\gv-dist\target\igv-console.zip (
rd /s/q gv-deployments\gv-dist\target\igv-console
Call :UnZipFile "%CD%\gv-deployments\gv-dist\target\igv-console" "%CD%\gv-deployments\gv-dist\target\igv-console.zip"
exit /b
:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%
)
REM cd /d %CODEBASE%
if exist gv-deployments\gv-dist\target\igv-console (
rd /s/q E:\igv-console-backup
move E:\igv-console E:\igv-console-backup
md E:\igv-console
xcopy gv-deployments\gv-dist\target\igv-console E:\igv-console /E/S
copy "C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\log4j-debug.properties" E:\igv-console\CONSOLE-INF\classes\log4j.properties
copy "C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\igv\*" E:\igv-console
)