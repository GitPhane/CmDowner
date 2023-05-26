@echo off
color a
title CmDowner 1.2   Where are you now: %cd%
cd /d "%~dp0"

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
echo                           version 1.2
echo                      Compiled on 5/25/2023
echo             Made with Python libs - spotdl, scdl, yt-dlp 
echo.

ver | findstr /i "5\.1\." > nul
if %errorLevel% == 0 (
    echo What are you even doing on XP??
    pause
    exit /b
) else (
    ver | findstr /i "6\.1\." > nul
    if %errorLevel% == 0 (
        echo Sorry, CmDowner doesn't support Windows 7.
        pause
        exit /b
    ) else (
        echo.
    )
)


ping -n 1 -w 50 www.google.com >nul
if errorlevel 1 (
    echo Looks like you're offline, please check your internet connection and
	pause
	cls
	goto :fmenu
) else (
    echo.
)



cd bin
cd rcheck
if exist "rcheck.check" (
    echo Welcome back! Flag file loaded at %cd%
) else (
    cls
    echo Looks like this is your first time here.
    echo Creating directories...
    mkdir bin
    echo bin
    cd bin
    mkdir preset
    echo preset
    mkdir rcheck
    echo rcheck
    cd rcheck
    echo this is a file that makes that the program knows its been ran before, do not delete this file. Generated at %date% at %time% > rcheck.check
    echo rcheck.check
    cd /d "%~dp0"
    mkdir downloads
    echo downloads
    cd downloads
    mkdir youtube
    echo youtube
    mkdir spotify
    echo spotify
    mkdir soundcloud
    echo soundcloud
    mkdir files
    echo files
    cd youtube
    mkdir music
    echo ytmusic
    mkdir videos
    echo ytvideos
   
    cd /d "%~dp0"

    timeout /t 3 >NUL
    echo.
    echo Relaunching..
    timeout /t 2 >NUL 
    cls
    cd py
    restart-thingy.bat
)

if exist "%~dp0/py" (
    echo.
) else (
    cls
    echo The py folder is missing! Please re-download the program.
    pause
    start https://github.com/rover-95/cmdowner
    exit
)


if exist "%~dp0/downloads" (
    echo.
) else (
    cls
    echo Why did you delete the downloads folder, what did it do to you?
	timeout /t 1 >NUL
	    cd /d "%~dp0"
	mkdir downloads
    echo downloads
    cd downloads
    mkdir youtube
    echo youtube
    mkdir spotify
    echo spotify
    mkdir soundcloud
    echo soundcloud
    cd youtube
    mkdir music
    echo ytmusic
    mkdir videos
    echo ytvideos
	echo.
	echo Relaunching...
	timeout /t 2 >NUL
	cls
	goto :fmenu
)
cd /d "%~dp0"
cd bin
cd preset
IF EXIST preset.bat (
    call preset.bat
    echo Your preset is loaded!
) else (
    echo Preset file not found!
)
echo.
echo Checking for Python...
where python > nul 2>&1
if %errorlevel% neq 0 (
cls
echo Python is not installed on this system. To use this script, install Python.
cd bin
cd rcheck
del rcheck.check
echo removing flg file
pause
exit
cls



python --version | findstr "3.[0-8]" > nul
if %errorlevel% equ 0 (
  echo Python 3.9 is required for the libraries to work, please install Python 3.9 or later.
  pause
  exit /b 1
)


) else (
  for /f "usebackq tokens=2,*" %%a in (`python --version 2^>^&1`) do (
    echo Found Python version %%a %%b.
  )
)
echo.


@echo off
where python > nul 2>&1
if %errorlevel% equ 0 (
    rem Python is in the PATH.
) else (
    cls
	echo Python is not added to PATH
	pause
	exit
)



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



rem Check if the operating system is 64-bit or 32-bit
rem fun fact: it doesn't matter if its 64 or 32 bit
if "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
    echo 64-bit OS Found
    set "FFMPEG_URL=https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip"
    set "FFMPEG_ZIP=%TEMP%\FFmpeg.zip"
    set "FFMPEG_DIR=%ProgramFiles%\"
) else (
    echo 32-bit OS Found
    set "FFMPEG_URL=https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl.zip"
    set "FFMPEG_ZIP=%TEMP%\FFmpeg.zip"
    set "FFMPEG_DIR=%ProgramFiles%\"
)

echo Downloading FFmpeg... (This can take a while, you will only need to do this once, FFmpeg is about 125MB)
powershell -command "Invoke-WebRequest -Uri '%FFMPEG_URL%' -OutFile '%FFMPEG_ZIP%'"

echo Extracting FFmpeg...
powershell -command "Expand-Archive -Path '%FFMPEG_ZIP%' -DestinationPath '%FFMPEG_DIR%' -Force"

rem Add FFmpeg binary directory to the PATH environment variable
echo Adding FFmpeg to PATH...
setx PATH "C:\Program Files\ffmpeg-master-latest-win64-gpl\bin;%PATH%"

:continue
echo FFmpeg is installed and ready to use.
timeout /t 1 >NUL

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
    timeout /t 1 >NUL
    cls	
)

echo.

echo Checking for yt-dlp...

REM check if spotdl is installed
python -c "import yt_dlp" > nul 2>&1

REM if errorlevel is 0, pytube is installed
if %errorlevel% EQU 0 (
    echo Found yt-dlp!
) else (
    echo yt-dlp is not installed
    cls
    echo INSTALLING YT-DLP, DO NOT CLOSE THE WINDOW UNTIL THE INSTALLATION HAS FINISHED!!
    timeout /t 1
    pip install yt-dlp
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
cls
:menu
cd /d "%~dp0"
echo Currently in: %cd%

cd bin
cd preset
IF EXIST preset.bat (
    call preset.bat
    echo Preset found!
) else (
    echo Preset not found!
)

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    echo 64-bit OS found
) else (
    echo 32-bit OS found
)



cd /d "%~dp0"
echo.                                              
echo                      ###                                               
echo                      ###                                               
echo  #####   ##  ##    #####    ####    ##  ##   #####     ####    #####   
echo ###      ######   ##  ##   ##  ##   ##  ##   ######   ######   ### ##  
echo ###      ##  ##   ##  ##   ##  ##   ######   ##  ##   ###      ##      
echo  #####   ##  ##    #####    ####    ##  ##   ##  ##    ####    ##                                                               
echo -----------------------------------------------------------------------
echo                        WELCOME TO CMDOWNER
echo                           version 1.2
echo                       Compiled on 5/25/2023
echo            Made with Python libs - spotdl, scdl, yt-dlp
echo.

setlocal EnableDelayedExpansion

echo Enter your selection:
echo 1. Download Spotify tracks/playlists
echo 2. Download YouTube Songs (mp3)
echo 3. Download YouTube Videos (mp4)
echo 4. Download SoundCloud Songs
echo 5. Download Files
echo.
echo 6. Freedom
echo 7. Make a preset file

set /p choice="> "


if "%choice%"=="1" (
    cls
    cd /d "%~dp0"
    cd downloads/spotify
    echo Selected Spotify Track/Playlist
    set /p downdir="Enter a directory for download (leave blank for the CmDowner downloads path): "
    cd !downdir!
    echo Using !downdir!
    set /p spot_link="Enter Spotify link (song or playlist): "
    spotdl download !spot_link!
    echo.
    echo Done
    pause
    cls
    goto :menu
    
) else if "%choice%"=="3" (
    cls
    call py\mp4script.py
    pause
    cls 
    goto :menu

) else if "%choice%"=="4" (
cls
 call py\scdlscript.bat
cls
goto :menu

) else if "%choice%"=="5" (
cls
 call py\filescript.py
pause
cls
goto :menu

) else if "%choice%"=="6" (
cls
echo Type "exit" to get to the main menu
echo.
cmd
cls
goto :menu
  

) else if "%choice%"=="2" (
cls
    call py\mpscript.py
    pause
    cls
    goto :menu

) else if "%choice%"=="7" (
cls
echo Presets can be used for commands that will be started when you launch CmDowner. For example, you don't like the green text? Change it to something you like! (type "color" in the freedom mode to see all the colors avalible)
echo To use presets, you will need to edit a file located in bin/preset/preset.bat. Simply type out a command that you want to be ran on startup.
echo.
cd /d "%~dp0"
cd bin/preset
IF EXIST preset.bat (
    CHOICE /M "It seems like the preset file already exists! Do you want to overwrite it?"

IF ERRORLEVEL 2 (
    cd /d "%~dp0"
    cls
    goto :menu
) else (
    del preset.bat
	echo rem This is a preset file created by CmDowner on %date%, write your code on a next line > preset.bat
	cd /d "%~dp0"
	echo Successfully overwritted preset.bat, CmDowner will restart if you
	pause
	cd py
	    cls
	call restart-thingy.bat
)

) else (
    echo rem This is a preset file created by CmDowner on %date%, write your code on a next line > preset.bat
    echo A file called preset.bat has been created in bin/preset, edit it and
	pause
	cd /d "%~dp0"
	cd py
	    cls
	call restart-thingy.bat
)
cls
goto :menu

) else (
    echo Invalid selection.
    goto :menu
)

:end