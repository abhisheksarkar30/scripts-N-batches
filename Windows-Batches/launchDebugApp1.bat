@echo off


REM $Id$

REM   Copyright (C) 2000-2004 Nomura Securities Co., Ltd.
REM   All Rights Reserved.


REM Invoke JAVA Command (via run.bat)
"%~dp0\run.bat" -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=8000,suspend=y com.nri.xenos.inf.console.launcher.ConsoleLauncher %*
