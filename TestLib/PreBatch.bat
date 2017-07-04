@echo off

title Pre Batch File

rem write the command below this line
rem ----------------------------------------------------------------------------------------

start cmd python "C:\KeywordAutomation\TestLib\RemoteStandardLibrary.py" %1 8270
start cmd python "C:\KeywordAutomation\TestLib\AutoItLibrary.py" %1 8271
start cmd python "C:\KeywordAutomation\TestLib\Selenium2Library.py" %1 82712

rem ----------------------------------------------------------------------------------------
