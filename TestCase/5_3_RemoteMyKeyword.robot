*** Settings ***
Documentation     자체 제작한 ``CalculatorLibrary.py``라이브러리를 이용하여 테스트 케이스 작성한 사례입니다.
Force Tags        Self
Resource          Resource/remote.robot

*** Test Cases ***
TC72_My_Calc
    remote.Push Button    C
    remote.Result Should Be    ${EMPTY}
    Remote.Push Button    1
    Remote.Push Button    +
    Remote.Push Button    2
    Remote.Push Button    =
    Remote.Result Should Be    3

TC73_MY_ChangeName_remote
    remote.Change Under To Blank    c:\\test\\pdf    #underbar
    remote.Change Blank To Underbar    c:\\test\\csv    #blank

TC74_MY_ChangeName_local
    my.Change Under To Blank    ${FILES}
    my.Change Blank To Underbar    ${FILES}

TC75_My_Check_Platform
    [Documentation]    autoit library로 사용했던 방식을 유저 라이브러리로 작성
    ${arch}=    remote.Get_Platform_Info
    log    ${arch}

*** Keywords ***
