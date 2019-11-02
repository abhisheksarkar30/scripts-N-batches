FOR /d /r . %%d IN ("CVS") DO @IF EXIST "%%d" rd /s /q "%%d"
pause