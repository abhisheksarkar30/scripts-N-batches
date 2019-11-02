@echo off
echo Enter following:
echo -s:quit when completed,
echo -b:show all running in same tab,
echo else:show all running in separate tab
set /P sw=Enter Choice: 
set dir=E:\igv-console
if not "%sw%"=="-s" (set sep=start cmd /k -new_console) else (set sep=call)
if "%sw%"=="-b" (set sep=start /b
set sw=)
echo -------------------------
echo    Service Controller
echo -------------------------
%sep% %dir%\launch ServiceController
timeout 10 > NUL
echo -------------------------------------------
echo    MessageRouter REF ITF TRD STL CAM NCM GLE
echo -------------------------------------------
%sep% %dir%\launch MessageRouter %sw% REF ITF TRD STL CAM NCM GLE CAX
echo -----------------------
echo    MonitorService REF
echo -----------------------
%sep% %dir%\launch MonitorService %sw% -c REF
echo -----------------------
echo    MonitorService ITF
echo -----------------------
%sep% %dir%\launch MonitorService %sw% -c ITF
echo -----------------------
echo    MonitorService CAX
echo -----------------------
%sep% %dir%\launch MonitorService %sw% -c CAX
echo -----------------------
echo    MonitorService TRD
echo -----------------------
%sep% %dir%\launch MonitorService %sw% -c TRD
echo -----------------------
echo    MonitorService STL
echo -----------------------
%sep% %dir%\launch MonitorService %sw% -c STL
echo -----------------------
echo    MonitorService CAM
echo -----------------------
%sep% %dir%\launch MonitorService %sw% -c CAM
echo -----------------------
echo    MonitorService NCM
echo -----------------------
%sep% %dir%\launch MonitorService %sw% -c NCM
echo -----------------------
echo    MonitorService GLE
echo -----------------------
%sep% %dir%\launch MonitorService %sw% -c GLE
if "%sw%"=="-s" pause