@echo off
color a

echo Currently in: %cd%

echo.
:menu
setlocal EnableDelayedExpansion
echo CmDowner SoundCloud Script, using scdl
echo.
echo Enter your selection:
echo 1. Download song
echo 2. Download playlist
set /p choice="> "

if "%choice%"=="1" (
    cls
    echo Selected Song
    set /p downdir="Enter a directory for download: "
    cd !downdir!
    echo Using !downdir!
    set /p sd_link="Enter SoundCloud song link: "
    scdl -l !sd_link!
    echo.
    cls
    echo Done
    goto :menu
)


) else if "%choice%"=="2" (
    cls
    echo Selected Playlist
    set /p downdir="Enter a directory for download: "
    cd !downdir!
    echo Using !downdir!
    set /p sd_link="Enter SoundCloud playlist link: "
    cls
    scdl -l !sd_link!
    echo.
    cls
    echo Done
    goto :menu
)


    
) else (
    echo Invalid selection. Please enter 1 or 2.
    goto :menu
)
