@echo off
REM JAVA_HOME=%JAVA6HOME%
setlocal
REM cd /d %CODEBASE%
if not "%1"=="r" (call mvn clean install -DskipTests -Dinfra.all -Deig.avaloq %1 %2)
echo Exit Code = %ERRORLEVEL%
if not "%ERRORLEVEL%" == "0" exit /b
FOR %%f in (dist-assembly\target\eig-btp-*.zip) do (set /a count=count+1
set fname=%%~nf)
if %count%==1 (
REM rd /s/q gv-deployments\gv-dist\target\igv-console
Call :UnZipFile "%CD%\dist-assembly\target" "%CD%\dist-assembly\target\%fname%.zip"
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
if exist dist-assembly\target\%fname% (
rd /s/q E:\eig-console-backup
move E:\EIG E:\eig-console-backup
md E:\EIG
xcopy dist-assembly\target\%fname%\* E:\EIG /E/S
copy "C:\Users\abhisheksa\Desktop\Batch-Files\Exchange-Files\eig\*" E:\EIG\bin
)