@echo off
rem This is used for CmDowners restarts, thats about it.
cd ..
CmDowner.bat
timeout /t 2 >NUL
exit