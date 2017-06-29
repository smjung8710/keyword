@echo off
Echo Checking network connection, please wait....


:TRYAGAIN
PING 127.0.0.1 -n 10>nul REM waits given amount of time, set to 10 seconds
GOTO TEST

:SUCCESS
title RemoteServer_AutoIT
python "C:\BuFF\TestLib\AutoItLib.py" %1 8271

pause