@echo off
Echo Checking network connection, please wait....

:TEST
PING -n 1 192.168.1.254 | find "TTL=128" >NUL

IF NOT ERRORLEVEL 1 goto :SUCCESS
IF     ERRORLEVEL 1 goto :TRYAGAIN

:TRYAGAIN
PING 127.0.0.1 -n 10>nul REM waits given amount of time, set to 10 seconds
GOTO TEST

:SUCCESS
title RemoteServer_Common
python "C:\BuFF\TestLib\CommonLibrary.py" %1 8270

pause