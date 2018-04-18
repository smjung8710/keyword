*** Settings ***
Documentation     ch3
Force Tags        BVT
Default Tags      critical    patch5
Test Template
Test Timeout
Resource          Resource/common.robot

*** Variables ***
${USER_NAME}      robot    # Scalar Variable Example
${USER_PASS}      secret    # Scalar Variable Example
@{USER1}          robot    secret    # List Variable Example
&{USER2}          name=robot    pass=secret    # Dictionary Variable Example
${HOST}           8.8.8.8

*** Test Cases ***
TC2_Variable_Set
    [Documentation]    변수 선언 예시
    ...
    ...    2장 RF의 [3.3 Add Variable]의 변수 예제 테스트 케이스”Scalar Variable Item”, “List Variable Item”, “Dict Variable Item”입니다. ”Scalar Variable Item”, “List Variable Item”, “Dict Variable Item” 3개의 테스트 케이스를 1개의 테스트케이스로 합친 것입니다.
    [Tags]    Variable
    [Setup]
    #scalar variable
    Log many    Scalar:    ${USER_NAME}    ${USER_PASS}    name:${USER_NAME}
    #list variable
    Log many    List: @{USER1}    name: @{USER1}[0]    #리스트에서 배열 순서로 구분
    #dictionary variable
    Log many    Dictionary: &{USER2}    name: &{USER2}[name]    #딕셔너리 변수에서 이름으로 구분
    #지역변수로 변경
    ${USER_NAME}    ${USER_PASS}    Set Variable    keyword    automation
    #전역변수로 변경
    Set Global Variable    @{USER1}    keyword    automation
    #지역변수로 변경
    Set Global Variable    &{USER2}    name=keyword    pass=automation
    Log To Console    scalar:${USER_NAME}
    Log To Console    scalar:${USER_PASS}
    Log To Console    list:@{USER1}
    Log To Console    dic:&{USER2}
    [Teardown]

TC3_Variable_Check
    [Documentation]    variable option example
    [Tags]    Variable
    Log Many    scalar:${USER_NAME}    scalar:${USER_PASS}    list:@{USER1}    dic:&{USER2}
    Log To Console    scalar:${USER_NAME}
    Log To Console    scalar:${USER_PASS}
    Log To Console    list:@{USER1}
    Log To Console    dic:&{USER2}

TC4_Variable_List_Dic
    [Tags]    list
    #리스트 변수
    @{list} =    Set Variable    a    b    c
    @{list2} =    Create List    a    b    c
    #스칼라 변수를 리스트로
    ${scalar} =    Create List    a    b    c
    #리스트 변수 값을 숫자로
    ${ints} =    Create List    ${1}    ${2}    ${3}
    log many    @{list}    @{list2}    ${scalar}    ${ints}
    #딕셔너리 변수
    &{Dic}    Create Dictionary    table_id=0    device_id='12f123'    name=admin
    log many    &{Dic}

TC5_Template
    [Documentation]    test
    [Tags]    Template    continue    ftp
    [Template]    There is file.ext file in dir folder
    #file index    #ext    #dir
    1    txt    RF_Template
    2    docx    RF_Template
    3    xlsx    RF_Template
    4    png    RF_Template
    5    zip    RF_Template
    6    hwp    RF_Template
    7    py    RF_Template
    8    pyc    RF_Template
    9    ppt    RF_Template
    10    7zip    RF_Template

TC6_For Loop
    [Tags]    loop
    ${path}=    Set Variable    C:\\Python27
    @{elements}    OS.List Directories In Directory    ${path}
    : FOR    ${directory}    IN    @{elements}
    \    ${file_count}    Count Files    ${path}\\${directory}
    \    &{list}=    Create Dictionary    path=${directory}    count=${file_count}
    \    log many    &{list}

TC7_Loop_condition
    [Tags]    loop
    ${output}=    Connect Share Folder    ${SHARE_IP}    ${SHARE_ID}    ${SHARE_PWD}
    Run Keyword If    '${output}'!='0'    Fatal Error    Pass Execution
    Exit For Loop

TC8_Loop_continue
    [Tags]    loop    continue
    @{files}    OS.List Files In Directory    C:\\RF_Template
    : FOR    ${count}    IN    @{files}
    \    Log To Console    ${count}
    \    Continue For Loop If    '${count}'=='1.txt'
    \    OS.Remove File    C:\\RF_Template\\${count}
    Should Exist    C:\\RF_Template\\1.txt

TC8_Loop_Repeat
    [Tags]    loop
    Repeat Keyword    5    OS.Run And Return Rc    net use \\\\${IP} /user:${ID} ${PWD} /PERSISTENT:YES

TC9_Argument_Tag
    [Documentation]    tag example
    [Tags]    host-${HOST}
    Log    host-${HOST}

TC10_Argument_Variable
    [Documentation]    Vaiable example
    [Tags]
    ${local_host}=    Set Variable    9.9.9.9
    Log Many    global host-${HOST}    local host-${local_host}
    Log To Console    global host-${HOST}
    Log To Console    local host-${local_host}

*** Keywords ***
There is file.ext file in dir folder
    [Arguments]    ${file}    ${ext}    ${dir}
    ${ret}=    Run Keyword And Return Status    OS.Directory Should Exist    C:\\${dir}
    Run Keyword If    '${ret}'=='False'    OS.Create Directory    C:\\${dir}
    OS.Directory Should Exist    C:\\${dir}    No Directory
    OS.Create File    C:\\${dir}\\${file}.${ext}
    OS.File Should Exist    C:\\${dir}\\${file}.${ext}    No Files
