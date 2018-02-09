*** Settings ***
Documentation       리모트 서버를 이용하여 리모트 라이브러리와 통신하는 예제입니다.
Resource            ../Resource2.robot

*** Test Cases ***
Example Remote
      [Documentation]      Remote example testcase
      [Setup]
      [Timeout]      40 minutes
      STD.Create File      D:\\remote.txt
      STD.File Should Exist      D:\\remote.txt      No FileManagement
      STD.run      notepad.exe D:\\remote.txt

