@echo off

REM Version history
REM 2/11/2020 version 0.1   - created the tool
REM 3/11/2020 version 0.1.1 - minor fix: added pauses to error messages
REM 3/11/2020 version 0.1.2 - minor addition: added version history
REM                         - minor edit: Renaming table elements
REM 4/11/2020 version 0.2   - removed editing unnecessary files
REM                         - added check if enabled and disabled file has the same status

REM this is the location of the GTA V exe file. Modify if necessary.
set launchGta="C:\Program Files\Rockstar Games\Grand Theft Auto V\PlayGTAV.exe"

:mainMenu
cls
if exist dinput8.dll (set existDinput=1) else (set existDinput=0)
if exist dinput8.dll.disable (set existDinputDis=1) else (set existDinputDis=0)
if %existDinputDis% equ %existDinput% goto endSameExistence

REM shameless self promotion
echo.
echo  __^| ^|________________________________^| ^|__
echo (__   ________________________________   __)
echo    ^| ^|                                ^| ^|
echo    ^| ^|   ModToggler 0.2 for GTA V     ^| ^|
echo    ^| ^|         by Frogthroat          ^| ^|
echo    ^| ^| gta5-mods.com/users/frogthroat ^| ^|
echo  __^| ^|________________________________^| ^|__
echo (__   ________________________________   __)
echo    ^| ^|                                ^| ^|
echo.

REM display the status of the files
echo           =========================
if %existDinput% equ 1 echo                  Mods are ON
if %existDinput% equ 0 echo                  Mods are OFF
echo           =========================
echo.
goto menuToggler

REM this is your menu
:menuToggler
if %existDinput% equ 1 set onOff=OFF
if %existDinput% equ 0 set onOff=ON
echo           Available options
echo              1 - Turn mods %onOff%
echo              2 - Launch GTA V
echo              3 - Exit
echo.
choice /n /c:123 /M "Please make a selection (1-3) "
if %ERRORLEVEL%==1 goto turn%onOff%
if %ERRORLEVEL%==2 goto startGame
if %ERRORLEVEL%==3 goto endSuccess
goto endError

:startGame
echo.
echo Launching GTA V . . .
if exist %launchGta% (call %launchGta%) else (goto endMissingExe)
goto endSuccess

REM verify that the disabled mod files exist and turn them on
:turnON
if %existDinputDis% gtr %existDinput% (
rename dinput8.dll.disable dinput8.dll
) else (echo.
echo Warning! Disabled mod files not found! Cannot enable mods!
echo Make sure you have mods enabled before first time use
echo of ModToggler!
echo.
pause)
goto mainMenu

REM turn off mods
:turnOFF
if %existDinputDis% lss %existDinput% (
rename dinput8.dll dinput8.dll.disable
)
goto mainMenu

REM if both files have the same existence
:endSameExistence
set /a "fileCount=%existDinput%+%existDinputDis%"
echo.
if %fileCount% equ 0 echo You have no Enabled or Disabled mods.
if %fileCount% equ 2 echo File exists in both Enabled and Disabled state!
echo.
echo Exiting . . .
echo.
pause
goto endFin

:endError
echo.
echo Unknown error! Exiting . . .
echo.
pause
goto endFin

REM remember to configure the launchGta variable to wherever your GTA V installation is
:endMissingExe
echo.
echo WARNING! GTA V executable is missing or incorrectly configured!
echo Make sure GTA V is installed and the batch file has the correct
echo path to the executable.
echo.
echo Exiting . . .
echo.
pause
goto endFin

:endSuccess
echo.
echo Exiting ModToggler . . .
goto endFin

REM this is the end
:endFin