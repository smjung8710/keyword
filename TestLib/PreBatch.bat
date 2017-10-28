@echo off

title Pre Batch File

rem write the command below this line
rem ----------------------------------------------------------------------------------------

start cmd python "C:\Users\automation\keyword\TestLib\RemoteStandardLibrary.py" %1 8270
start cmd python "C:\Users\automation\keyword\TestLibb\AutoItLibrary.py" %1 8271
start cmd python "C:\Users\automation\keyword\TestLib\Selenium2Library.py" %1 82712

rem ----------------------------------------------------------------------------------------
