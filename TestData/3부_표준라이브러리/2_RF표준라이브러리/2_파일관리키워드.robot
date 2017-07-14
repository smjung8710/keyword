*** Settings ***
Documentation       standard library example testsuite
Test Template
Test Timeout
Resource            리소스.robot

*** Variables ***

*** Test Cases ***
File Management
      OS.Directory Should Exist      C:\\Python27      No Python27
      OS.Create Directory      C:\\Python27\\FileManagement
      OS.Directory Should Exist      C:\\Python27\\FileManagement      No FileManagement
      ${dir}=      Set Variable      C:\\Python27\\FileManagement
      OS.Create File      ${dir}\\Files.txt      this is file management
      OS.File Should Exist      ${dir}\\Files.txt
      OS.File Should Not Be Empty      ${dir}\\Files.txt
      ${ret}      OS.Run And Return Rc      notepad.exe ${dir}\\Files.txt
      Pass Execution If      '${ret}'=='0'      PASS

HostsFile Control
      ${dir}=      Set Variable      C:\\Windows\\System32\\drivers\\etc
      ${ret}=      Run Keyword And Return Status      OS.File Should Exist      ${dir}\\hosts
      Run Keyword If      '${ret}'=='True'      OS.Append To File      ${dir}\\hosts      127.0.0.1 keywordautomation.com
      OS.run      notepad.exe ${dir}\\hosts

*** Keywords ***
