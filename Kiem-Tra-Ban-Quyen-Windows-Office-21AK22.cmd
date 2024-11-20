chcp 65001 >nul
@echo off
Title KIEM TRA BAN QUYEN WINDOWS OFFICE BY 21AK22.COM
mode con: cols=96 lines=218
chcp 65001 >nul
@echo.
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo  Run CMD as Administrator...
    goto goUAC 
) else (
 goto goADMIN )

:goUAC
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:goADMIN
    pushd "%CD%"
    CD /D "%~dp0"

:CheckActivation
cls
color f0
echo.
echo        KIEM TRA BAN QUYEN WINDOWS OFFICE BY 21AK22.COM
echo.
ECHO ************************************************************
ECHO ***                 Ban quyen Windows                    ***
ECHO ************************************************************
COPY /Y %systemroot%\System32\slmgr.vbs "%temp%\slmgr.vbs" >NUL 2>&1
cscript //nologo "%temp%\slmgr.vbs" /dli
cscript //nologo "%temp%\slmgr.vbs" /xpr
DEL /F /Q "%temp%\slmgr.vbs" >NUL 2>&1

:office2016
IF EXIST %systemroot%\SysWOW64\cmd.exe (SET bit=64&SET wow=1) ELSE (SET bit=32&SET wow=0)
SET office=
FOR /F "tokens=2*" %%a IN ('"REG QUERY HKLM\SOFTWARE\Microsoft\Office\16.0\Common\InstallRoot /v Path" 2^>NUL') DO (SET "office=%%b")
IF EXIST "%office%\OSPP.VBS" (
ECHO.
ECHO ************************************************************
ECHO ***            Ban quyen Office 2016 %bit%-bit              ***
ECHO ************************************************************
cscript //nologo "%office%\OSPP.VBS" /dstatus
)
IF %wow%==0 GOTO :office2013
SET office=
FOR /F "tokens=2*" %%a IN ('"REG QUERY HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Common\InstallRoot /v Path" 2^>NUL') DO (SET "office=%%b")
IF EXIST "%office%\OSPP.VBS" (
ECHO.
ECHO ************************************************************
ECHO ***             Ban quyen Office 2016 32-bit             ***
ECHO ************************************************************
cscript //nologo "%office%\OSPP.VBS" /dstatus
)

:office2013
SET office=
FOR /F "tokens=2*" %%a IN ('"REG QUERY HKLM\SOFTWARE\Microsoft\Office\15.0\Common\InstallRoot /v Path" 2^>NUL') DO (SET "office=%%b")
IF EXIST "%office%\OSPP.VBS" (
ECHO.
ECHO ************************************************************
ECHO ***             Ban quyen Office 2013 %bit%-bit             ***
ECHO ************************************************************
cscript //nologo "%office%\OSPP.VBS" /dstatus
)
IF %wow%==0 GOTO :office2010
SET office=
FOR /F "tokens=2*" %%a IN ('"REG QUERY HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Common\InstallRoot /v Path" 2^>NUL') DO (SET "office=%%b")
IF EXIST "%office%\OSPP.VBS" (
ECHO.
ECHO ************************************************************
ECHO ***            Ban quyen Office 2013 32-bit              ***
ECHO ************************************************************
cscript //nologo "%office%\OSPP.VBS" /dstatus
)

:office2010
SET office=
FOR /F "tokens=2*" %%a IN ('"REG QUERY HKLM\SOFTWARE\Microsoft\Office\14.0\Common\InstallRoot /v Path" 2^>NUL') DO (SET "office=%%b")
IF EXIST "%office%\OSPP.VBS" (
ECHO.
ECHO ************************************************************
ECHO ***            Ban quyen Office 2010 %bit%-bit              ***
ECHO ************************************************************
cscript //nologo "%office%\OSPP.VBS" /dstatus
)
IF %wow%==0 GOTO :office2016C2R
SET office=
FOR /F "tokens=2*" %%a IN ('"REG QUERY HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\Common\InstallRoot /v Path" 2^>NUL') DO (SET "office=%%b")
IF EXIST "%office%\OSPP.VBS" (
ECHO.
ECHO ************************************************************
ECHO ***            Ban quyen Office 2010 32-bit              ***
ECHO ************************************************************
cscript //nologo "%office%\OSPP.VBS" /dstatus
)

:office2016C2R
REG QUERY HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath >NUL 2>&1 || GOTO :office2013C2R
SET office=
for /f "tokens=2*" %%a IN ('"REG QUERY HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath" 2^>NUL') do (set "office=%%b\Office16")
IF EXIST "%office%\OSPP.VBS" (
ECHO.
ECHO ************************************************************
ECHO ***      Ban quyen Office 2016/2019/2021/365 C2R         ***
ECHO ************************************************************
cscript //nologo "%office%\OSPP.VBS" /dstatus
)

:office2013C2R
REG QUERY HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun /v InstallPath >NUL 2>&1 || GOTO :office2010C2R
SET office=
IF EXIST "%ProgramFiles%\Microsoft Office\Office15\OSPP.VBS" (
  set "office=%ProgramFiles%\Microsoft Office\Office15"
) else IF EXIST "%ProgramFiles(x86)%\Microsoft Office\Office15\OSPP.VBS" (
  set "office=%ProgramFiles(x86)%\Microsoft Office\Office15"
)
IF EXIST "%office%\OSPP.VBS" (
ECHO.
ECHO ************************************************************
ECHO ***              Ban quyen Office 2013 C2R               ***
ECHO ************************************************************
cscript //nologo "%office%\OSPP.VBS" /dstatus
)

:office2010C2R
REG QUERY HKLM\SOFTWARE\Microsoft\Office\14.0\ClickToRun /v InstallPath >NUL 2>&1 || GOTO :End
SET office=
IF EXIST "%ProgramFiles%\Microsoft Office\Office14\OSPP.VBS" (
  set "office=%ProgramFiles%\Microsoft Office\Office14"
) else IF EXIST "%ProgramFiles(x86)%\Microsoft Office\Office14\OSPP.VBS" (
  set "office=%ProgramFiles(x86)%\Microsoft Office\Office14"
)
IF EXIST "%office%\OSPP.VBS" (
ECHO.
ECHO ************************************************************
ECHO ***              Ban quyen Office 2010 C2R               ***
ECHO ************************************************************
cscript //nologo "%office%\OSPP.VBS" /dstatus
)

:End
Echo.
ECHO ************************************************************
ECHO  Da kiem tra thanh cong. Nhan mot phim bat ky de thoat...
pause>nul
exit