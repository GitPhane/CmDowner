@echo off
color a
cd bin
cd preset
IF EXIST preset.bat (
    echo Please wait...
    call preset.bat
	cls
) else (
    echo Preset not found, you can make a preset on the CmDowner's main menu.
)
title CmDowner's SoundCloud Downloader    Currently in: %cd%
echo Currenly in: look up
echo.
:menu
setlocal EnableDelayedExpansion
echo CmDowner SoundCloud Script, using scdl
echo.
echo Enter your selection:
echo 1. Download song
echo 2. Download playlist
echo.
echo 0. Return to CmDowner
set /p choice="> "

) else if "%choice%"=="0" (
cd ..
cls
CmDowner.bat
)

if "%choice%"=="1" (
    cls
    cd /d "%~dp0" 
    cd ..
    cd downloads/soundcloud
    echo Selected Song
    set /p downdir="Enter a directory for download (leave empty for CmDowner downloads folder): "
    cd !downdir!
    echo Using !downdir!
    set /p sd_link="Enter SoundCloud song link: "
    scdl -l !sd_link!
    echo.
    echo Done
    pause
   cls
    goto :menu
)

) else if "%choice%"=="2" (
    cls
    echo Selected Playlist
    cd /d "%~dp0"
	cd ..
    cd downloads/soundcloud
    set /p downdir="Enter a directory for download (leave empty for CmDowner downloads folder): "
    cd !downdir!
    echo Using !downdir!
    set /p sd_link="Enter SoundCloud playlist link: "
    scdl -l !sd_link!
    echo.
    echo Done
    pause
cls
    goto :menu
)

    
) else (
    echo Invalid selection. Please enter 1 or 2.
    goto :menu
)
