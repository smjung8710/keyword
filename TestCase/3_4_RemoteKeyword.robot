*** Settings ***
Resource          Resource/remote.robot

*** Variables ***

*** Test Cases ***
TC33_Remote_Count
    [Documentation]    Count Items in Directory
    [Tags]    remote    count
    ${items1} =    Remote.Count Items In Directory    ${CURDIR}
    ${items2} =    Remote.Count Items In Directory    ${TEMPDIR}
    Log    ${items1} items in '${CURDIR}' and ${items2} items in '${TEMPDIR}'

TC34_Remote_Win
    [Documentation]    Remote example testcase
    [Tags]    remote    win
    [Timeout]    40 minutes
    ${file}=    Set Variable    C:\\remote.txt
    remote.Create File    ${file}    this is the keyword world
    remote.File Should Exist    ${file}    No File
    ${contents}    Remote.Get File    ${file}
    Should Contain    ${contents}    this is the keyword world

TC35_Remote_Linux_MAC
    [Tags]    remote    linux
    ${dir}=    Set Variable    /tmp/keyword
    ${file}=    Set Variable    ${dir}/remote.txt
    remote.Create Directory    ${dir}
    remote.Create File    ${file}
    remote.Directory Should Exist    ${dir}
    remote.File Should Exist    ${file}    No FileManagement

TC36_Arg_Exit
    [Documentation]    3장 테스트 케이스로 실습시 주의 필요
    log    the first tc
    Fail

*** Keywords ***
