@echo off
color a
title CmDowner 1.0

:fmenu
echo.                                              
echo                      ###                                               
echo                      ###                                               
echo  #####   ##  ##    #####    ####    ##  ##   #####     ####    #####   
echo ###      ######   ##  ##   ##  ##   ##  ##   ######   ######   ### ##  
echo ###      ##  ##   ##  ##   ##  ##   ######   ##  ##   ###      ##      
echo  #####   ##  ##    #####    ####    ##  ##   ##  ##    ####    ##                                                                  
echo -----------------------------------------------------------------------
echo                        WELCOME TO CMDOWNER
echo                           version 1.0
echo             Made with Python libs - spotdl, pytube, scdl
echo.

cd bin
cd rcheck
if exist "rcheck.check" (
    echo Welcome back! Flag file loaded at %cd%
) else (
    echo Looks like this is your first time here.
    echo Creating flag file...
    echo this is a file that makes that the program knows its been ran before, do not delete this file > rcheck.check
)
echo.
echo Checking for Python...
where python > nul 2>&1
if %errorlevel% neq 0 (

echo Python is not installed on this system. To use this script, install Python.
pause
exit
) else (
  for /f "usebackq tokens=2,*" %%a in (`python --version 2^>^&1`) do (
    echo Found Python version %%a %%b.
  )
)


echo.

echo Checking for FFmpeg...
setlocal EnableExtensions EnableDelayedExpansion

rem Check if FFmpeg is already installed
set "FFMPEG_EXE=ffmpeg.exe"
where /q %FFMPEG_EXE%
if %errorLevel% == 0 (
    echo FFmpeg is already installed.
    goto :continue
) else (
    echo FFmpeg is not installed.
)

rem Check if script is running with admin privileges
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with admin privileges...
) else (
    echo ERROR: Script must be run with admin privileges.
    pause
    exit /b
)



rem Download and extract FFmpeg
set "FFMPEG_URL=https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip"
set "FFMPEG_ZIP=%TEMP%\ffmpeg-master-latest-win64-gpl.zip"
set "FFMPEG_DIR=%ProgramFiles%\FFmpeg\ffmpeg-master-latest-win64-gpl"
set "FFMPEG_BIN_DIR=%FFMPEG_DIR%\ffmpeg-master-latest-win64-gpl\bin"
set "FFMPEG_EXE=%FFMPEG_BIN_DIR%\ffmpeg.exe"

echo Downloading FFmpeg... (This can take a while, you will only need to do this once)
powershell -command "Invoke-WebRequest -Uri '%FFMPEG_URL%' -OutFile '%FFMPEG_ZIP%'"

echo Extracting FFmpeg...
powershell -command "Expand-Archive -Path '%FFMPEG_ZIP%' -DestinationPath '%FFMPEG_DIR%' -Force"

rem Add FFmpeg binary directory to the PATH environment variable
echo Adding FFmpeg to PATH...
setx PATH "%FFMPEG_BIN_DIR%;%PATH%"

:continue
echo FFmpeg is installed and ready to use.






echo.

echo Checking for spotdl...

REM check if spotdl is installed
python -c "import spotdl" > nul 2>&1

REM if errorlevel is 0, spotdl is installed
if %errorlevel% EQU 0 (
    echo Found spotdl!
) else (
    echo spotdl is not installed
    cls
    echo INSTALLING SPOTDL, DO NOT CLOSE THE WINDOW UNTIL THE INSTALLATION HAS FINISHED!!
    timeout /t 1
    pip install spotdl
    cls
    echo Finished!
    goto :continue
    timeout /t 1	
)

echo.

echo Checking for pytube...

REM check if spotdl is installed
python -c "import pytube" > nul 2>&1

REM if errorlevel is 0, pytube is installed
if %errorlevel% EQU 0 (
    echo Found pytube!
) else (
    echo pytube is not installed
    cls
    echo INSTALLING PYTUBE, DO NOT CLOSE THE WINDOW UNTIL THE INSTALLATION HAS FINISHED!!
    timeout /t 1
    pip install pytube
    cls
    echo Finished!
    goto :continue
    timeout /t 1

)

echo.

echo Checking for scdl...

REM check if sc-d is installed
python -c "import scdl" > nul 2>&1

REM if errorlevel is 0, pytube is installed
if %errorlevel% EQU 0 (
    echo Found scdl!
) else (
    echo scdl is not installed
    cls
    echo INSTALLING SCDL, DO NOT CLOSE THE WINDOW UNTIL THE INSTALLATION HAS FINISHED!!
    timeout /t 1
    pip install scdl
    cls
    echo Finished!
    goto :continue
    timeout /t 1

)

timeout /t 3
cls
:menu
cd /d "%~dp0"
echo Currently in: %cd%
echo.                                              
echo                      ###                                               
echo                      ###                                               
echo  #####   ##  ##    #####    ####    ##  ##   #####     ####    #####   
echo ###      ######   ##  ##   ##  ##   ##  ##   ######   ######   ### ##  
echo ###      ##  ##   ##  ##   ##  ##   ######   ##  ##   ###      ##      
echo  #####   ##  ##    #####    ####    ##  ##   ##  ##    ####    ##                                                               
echo -----------------------------------------------------------------------
echo                        WELCOME TO CMDOWNER
echo                           version 1.0
echo             Made with Python libs - spotdl, pytube, scdl
echo.

setlocal EnableDelayedExpansion

echo Enter your selection:
echo 1. Download Spotify tracks/playlists
echo 2. Download YouTube Songs (mp3)
echo 3. Download YouTube Videos (mp4)
echo 4. Download SoundCloud Songs
set /p choice="> "

if "%choice%"=="1" (
    cls
    echo Selected Spotify Track/Playlist
    set /p downdir="Enter a directory for download: "
    cd !downdir!
    echo Using !downdir!
    set /p spot_link="Enter Spotify link (song or playlist): "
    spotdl download !spot_link!
    echo.
    cls
    echo Done
    goto :menu
    
) else if "%choice%"=="3" (
    cls
    call py\mp4script.py
    cls 
    goto :menu

) else if "%choice%"=="4" (
cls
 call py\scdlscript.bat
cls
goto :menu

) else if "%choice%"=="2" (
cls
    call py\mpscript.py
    cls
    echo Script Launched!
    echo NOTE: If you previously downloaded something from Spotify with CMDOWNER you will need to restart the program (only do this if you get an error saying Cannot find specified file)
    echo Going back to the selection menu in 10 seconds.
    timeout /t 10 >nul
    cls
    echo Script Launched!
    goto :menu
    
    
) else (
    echo Invalid selection. Please enter 1, 2 or 3.
    goto :menu
)
:end