REM ****************************************************************************
REM File Name: BOOT_HDD.CMD
REM Function:  SET BOOT DEVICE FROM HDD FOR TEST
REM Envioroment:32BitWinPE,64BitWinPE
REM Version: V1.0 
REM Author: Sindy Gong
REM Modify History:
REM	2017/12/11 16:44,created
REM VerNo: 3 ,2017-12-11, Initial Build, Sindy Gong
REM ****************************************************************************

if %PROCESSOR_ARCHITECTURE% == AMD64 SET OSBIT=64
if %PROCESSOR_ARCHITECTURE% == x86 SET OSBIT=32

set VerNo=3
SET LOC_DRV=X:
set File_Name=BOOT_HDD.CMD
set ERROR_CODE=
set ERROR_LOG=

ECHO. 
REM ====================================================================Section_A
echo.
echo %Date% %time% START execute [%File_Name% VerNo:%VerNo%] >> %CTL_DRV%\%MTSN%\tester.log

if exist %TESTDISK%\%TESTFOLDER%\bthtest.log goto pass

echo./////////////////////////////////////////// >> %CTL_DRV%\%MTSN%\tester.log
echo.COPY FLOWCTL.DAT TO LOCAL DISK >>%CTL_DRV%\%MTSN%\tester.log
echo./////////////////////////////////////////// >> %CTL_DRV%\%MTSN%\tester.log
copy %CTL_DRV%\%MTSN%\flowctl.dat %TESTDISK%\%TESTFOLDER%\flowctl.dat /y
ping 127.1 -n 5 >nul
copy %CTL_DRV%\%MTSN%\flowctl.dat %TESTDISK%\%TESTFOLDER%\flowctl.dat /y
ping 127.1 -n 5 >nul
copy %CTL_DRV%\%MTSN%\flowctl.dat %TESTDISK%\%TESTFOLDER%\flowctl.dat /y
ping 127.1 -n 5 >nul
echo SET PASS > %TESTDISK%\%TESTFOLDER%\bthtest.log
ping 127.1 -n 5 >nul
echo.COPY FLOWCTL.DAT TO LOCAL DISK Completed >> %CTL_DRV%\%MTSN%\tester.log
start /wait %TEST_DRV%\%PRDDIR%\sendmsg%OSBIT%.exe 102 %1
GOTO end

REM ====================================================================Section_B
:PASS
echo %Date% %time% execute [%File_Name%] PASS>> %CTL_DRV%\%MTSN%\tester.log
del %TESTDISK%\%TESTFOLDER%\bthtest.log
echo.DEL LOG FILE bthtest.log Completed >>  %TESTDISK%\%TESTFOLDER%\tester.log
%TESTDISK%\%TESTFOLDER%\sendmsg.exe 102 %1
if yesTRUE==yes%DEBUG% pause
goto end

REM ====================================================================Section_C

:FAIL
echo ERROR_LOG=%ERROR_LOG%>>%CTL_DRV%\%MTSN%\tester.log
echo ERROR_CODE=%ERROR_CODE%>%CTL_DRV%\%MTSN%\temp\errorcode.txt
echo ERROR_LOG=%ERROR_LOG%>>%CTL_DRV%\%MTSN%\temp\errorcode.txt
REM Add create JSON log code here
REM Add VGA fixture code here
start /wait %TEST_DRV%\%PRDDIR%\SendMSG%OSBIT%.exe 103 %1
if yesTRUE==yes%DEBUG% pause
goto end
REM ====================================================================Section_D

:END

REM =============================================================================