*** Settings ***
Documentation       standard library example testsuite
Test Timeout        2 hours
Resource            ../Resource2.robot

*** Test Cases ***
Example Remote
      [Documentation]      Remote example testcase
      [Setup]
      [Timeout]      40 minutes
      STD.Create File      D:\\remote.txt
      STD.File Should Exist      D:\\remote.txt      No FileManagement
      STD.run      notepad.exe D:\\remote.txt

*** Keywords ***
Example keyword
      [Documentation]      example keyword

Timeout
      [Documentation]      standard library example keyword
      [Timeout]      1 hour 40 minutes 30 seconds
