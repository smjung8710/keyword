@echo off

title Pre Batch File

rem write the command below this line
rem ----------------------------------------------------------------------------------------

start cmd python "E:\KeywordAutomation\TestLib\StdLib.py" %1 8270
start cmd python "E:\KeywordAutomation\TestLib\AutoItLib.py" %1 8271

rem ----------------------------------------------------------------------------------------
