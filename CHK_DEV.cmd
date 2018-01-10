REM ****************************************************************************
REM File Name: CHK_DEV.CMD
REM Function:   CHECK DEVICE MANAGER
REM Envioroment:Windows
REM Version: V1.0 
REM Author: Sindy Gong
REM Modify History:
REM	2018/01/09 13:22,created
REM VerNo: 3 ,2018/01/09, Initial Build, Sindy Gong
REM ****************************************************************************

set VerNo=3
set File_Name=CHK_DEV.CMD
set ERROR_CODE=
set ERROR_LOG=

ECHO. 
REM ====================================================================Section_A
echo.
echo %Date% %time% START execute [%File_Name% VerNo:%VerNo%] >> %TESTDISK%\%TESTFOLDER%\tester.log

:start
C:
cd\prdv10
if exist c:\prdv10\CHKDEV.LOG goto CHK_AGN

echo./////////////////////////////////////////// >> C:\PRDV10\tester.log
echo.START CHECK DEVICE MANAGER >>C:\PRDV10\tester.log
echo./////////////////////////////////////////// >> C:\PRDV10\tester.log
CHKDM.EXE /a
if errorlevel 1 goto retest
echo.CHECK DEVICE MANAGER COMPLETED >>C:\PRDV10\tester.log
goto pass

:retest
echo./////////////////////////////////////////// >> C:\PRDV10\tester.log
echo.REBOOT FOR FIRST CHECK FAILURE >> C:\PRDV10\tester.log
echo./////////////////////////////////////////// >> C:\PRDV10\tester.log
echo. REBOOT FOR FIRST CHECK FAILURE > CHKDEV.LOG
WINWAIT 1000
shutdown -r -f -t 2
PAUSE

:CHK_AGN
echo./////////////////////////////////////////// >> C:\PRDV10\tester.log
echo.CHECK DEVICE MANAGER SECOND TIME >>C:\PRDV10\tester.log
echo./////////////////////////////////////////// >> C:\PRDV10\tester.log
CHKDM.EXE /a
if errorlevel 1 set ERROR_LOG=Device manager check fail && SET ERROR_CODE=DEVCHKXXXXPC0001 && goto fail
echo.CHECK DEVICE MANAGER SECOND TIME COMPLETED >>C:\PRDV10\tester.log
goto pass

REM ====================================================================Section_B

:PASS
SET ERROR_CODE=DEVCHKXXXXPC0000
REM Add create JSON log code here
echo %Date% %time% execute [%File_Name%] PASS>> %TESTDISK%\%TESTFOLDER%\tester.log
start /wait SendMSG64.exe 102 %1
if yesTRUE==yes%DEBUG% pause
goto end

REM ====================================================================Section_C

:FAIL
echo ERROR_LOG=%ERROR_LOG%>>%TESTDISK%\%TESTFOLDER%\tester.log
echo ERROR_CODE=%ERROR_CODE%>%TESTDISK%\%TESTFOLDER%\temp\errorcode.txt
echo ERROR_LOG=%ERROR_LOG%>>%TESTDISK%\%TESTFOLDER%\temp\errorcode.txt
REM Add create JSON log code here
REM Add VGA fixture code here
start /wait SendMSG64.exe 103 %1
if yesTRUE==yes%DEBUG% pause
goto end
REM ====================================================================Section_D

:END

REM =============================================================================

