*** Settings ***
Documentation     Builtin Keyword example
Resource          Resource/common.robot

*** Variables ***
${USER_NAME}      robot    # Scalar Variable Example
${USER_PASS}      secret    # Scalar Variable Example
@{USER1}          robot    secret    # List Variable Example
&{USER2}          name=robot    pass=secret    # Dictionary Variable Example
${HOST}           8.8.8.8

*** Test Cases ***
TC10_Builtin_Variable_Set
    [Documentation]    변수 선언 예시
    [Tags]    var
    #scalar variable
    Log    scalar:${USER_NAME}    console=true
    Log    scalar:${USER_PASS}    console=true
    Log    name:${USER_NAME}    console=true
    #list variable
    Log    list: @{USER1}    console=true
    Log    name: @{USER1}[0]    console=true
    #dictionary variable
    Log    dic: &{USER2}    console=true
    Log    name: &{USER2}[name]    console=true
    #지역변수로 변경
    Set Test Variable    ${USER_NAME}    keyword
    ${USER_PASS}    Set Variable    automation
    #전역변수로 변경
    Set Suite Variable    @{USER1}    keyword    automation
    Set Global Variable    &{USER2}    name=keyword    pass=automation

TC11_Builtin_Variable_Check
    [Documentation]    variable option example
    [Tags]    var
    Log Many    scalar:${USER_NAME}    scalar:${USER_PASS}    list:@{USER1}    dic:&{USER2}
    Log To Console    scalar:${USER_NAME}
    Log To Console    scalar:${USER_PASS}
    Log To Console    list:@{USER1}
    Log To Console    dic:&{USER2}

TC12_Builtin_Variable_List_Dic
    [Documentation]    리스트, 사전 변수 실습
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

TC13_Builtin_Variable_String_Number
    #String
    ${string} =    Set Variable    abc
    Log    ${string.upper()}    # Logs 'ABC'
    Log    ${string * 2}    # Logs 'abcabc'
    Log    ${string}
    #Number
    ${number} =    Set Variable    ${-2}
    Log    ${number * 10}    # Logs -20
    Log    ${number.__abs__()}    # Logs 2
    Log    ${number}

TC14_Builtin_Template
    [Documentation]    템플릿 실습
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

TC15_Builtin_For Loop
    [Documentation]    반복문 실습
    [Tags]    loop
    ${path}=    Set Variable    C:\\Python27
    @{elements}    OS.List Directories In Directory    ${path}
    : FOR    ${directory}    IN    @{elements}
    \    ${file_count}    Count Files    ${path}\\${directory}
    \    &{list}=    Create Dictionary    path=${directory}    count=${file_count}
    \    log many    &{list}

TC16_Builtin_Loop_Range
    [Setup]    account
    ${output}=    Connect Share Folder    ${SHARE_IP}    ${SHARE_ID}    ${SHARE_PW}
    Run Keyword If    '${output}'!='0'    Fail    Pass Execution

TC17_Builtin_Loop_Simple
    [Tags]    loop
    [Setup]    account
    ${output}=    Connect Share Folder Simple    ${SHARE_IP}    ${SHARE_ID}    ${SHARE_PW}
    Run Keyword If    '${output}'!='0'    Fail    Pass Execution

TC18_Builtin_Loop_Continue
    [Tags]    loop    continue
    @{files}    OS.List Files In Directory    C:\\RF_Template
    : FOR    ${count}    IN    @{files}
    \    Log To Console    ${count}
    \    Continue For Loop If    '${count}'=='1.txt'
    \    OS.Remove File    C:\\RF_Template\\${count}
    Should Exist    C:\\RF_Template\\1.txt
    Should Not Exist    C:\\RF_Template\\2.docx

TC19_Builtin_Loop_Repeat
    [Tags]    loop
    ${count}    Set Variable    3
    Repeat Keyword    ${count}    log    반복횟수를 이용한 경우
    ${count}    Set Variable    5ms
    Repeat Keyword    ${count}    log    반복 시간을 이용한 경우

TC20_Builtin_Should_Be_Equal
    [Documentation]    Count Items in Directory fail example
    [Tags]    remote
    ${path}=    Set Variable    C:\\Python27    #for windows
    ${ret}=    OS.Count Files In Directory    ${path}
    Should Be Equal As Integers    ${ret}    36
    Should Be Equal    ${ret}    36

TC21_Builtin_Convert To Integer
    [Documentation]    Count Items In Directory pass example
    [Tags]    remote
    ${path}=    Set Variable    C:\\Python27    #for windows
    ${ret}=    OS.Count Files In Directory    ${path}
    # 비교 대상의 타입 변환
    ${int1}    Convert To Integer    ${ret}
    ${int2}    Convert To Integer    36
    Should Be Equal    ${int1}    ${int2}
    #변환해주는 검증 키워드
    Should Be Equal As Integers    ${ret}    36

TC22_Builtin_Evaluate
    ${count}=    Set Variable    99
    ${ret}=    Evaluate    ${count}-1
    Log To Console    99-98 = ${ret}
    Should Be Equal As Numbers    ${ret}    98

*** Keywords ***
There is file.ext file in dir folder
    [Arguments]    ${file}    ${ext}    ${dir}
    ${ret}=    Run Keyword And Return Status    OS.Directory Should Exist    C:\\${dir}
    Run Keyword If    '${ret}'=='False'    OS.Create Directory    C:\\${dir}
    OS.Directory Should Exist    C:\\${dir}    No Directory
    OS.Create File    C:\\${dir}\\${file}.${ext}
    OS.File Should Exist    C:\\${dir}\\${file}.${ext}    No Files

account
    Set Global Variable    ${SHARE_IP}    1.1.1.1
    Set Global Variable    ${SHARE_ID}    robot
    Set Global Variable    ${SHARE_PW}    secret
