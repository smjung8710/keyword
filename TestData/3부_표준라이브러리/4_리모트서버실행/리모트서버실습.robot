*** Settings ***
Documentation       ����Ʈ ������ �̿��Ͽ� ����Ʈ ���̺귯���� ����ϴ� �����Դϴ�.
Resource            ../Resource2.robot

*** Test Cases ***
Example Remote
      [Documentation]      Remote example testcase
      [Setup]
      [Timeout]      40 minutes
      STD.Create File      D:\\remote.txt
      STD.File Should Exist      D:\\remote.txt      No FileManagement
      STD.run      notepad.exe D:\\remote.txt

