*** Settings ***
Documentation     Keyword Based Automation Test
Suite Setup       TestSuite_SETUP
Suite Teardown    TestSuite_TEARDOWN
Test Setup        TestCase_SETUP
Test Teardown     TestCase_TEARDOWN
Force Tags        basic
Test Template
Test Timeout      1 hour 40 minutes 2 seconds
Resource          Resource/common.robot

*** Variables ***
${USER_NAME}      robot    # Scalar Variable Example
${USER_PASS}      secret    # Scalar Variable Example
${HOST}           8.8.8.8

*** Test Cases ***
TC1_RF_TSFixture
    [Documentation]    RFStructure : 테스트 스윗 픽스쳐 기능 확인
    [Tags]    fixture
    Log    only TC    console=true

TC2_RF_Variable
    [Documentation]    RFStructure : 변수값 확인
    [Tags]    fixture
    Log many    user name is ${USER_NAME}    pass is ${USER_PASS}
    Log To Console    user name is ${USER_NAME}
    Log To Console    pass is ${USER_PASS}

TC3_RF_UserKeyword
    [Documentation]    RFStructure \ 사용자 키워드 사용
    [Tags]    fixture
    User Keyword    #Call User keyword

TC4_RF_MyFixture
    [Documentation]    RFStructure : 테스트 케이스 픽스쳐 기능 확인
    [Setup]    Example_SETUP
    [Tags]    fixture
    log    my fixture    console=true
    [Teardown]    Example_TEARDOWN

TC5_RF_TCFixture
    [Documentation]    픽스처 사용 오류 : syntax 만 있고 값이 없는 경우
    [Setup]
    Log    only TC    console=true
    [Teardown]

TC6_Arg_Tag_i
    [Documentation]    Tag 옵션 i
    [Tags]    ex
    Log    host-${HOST}    console=true

TC7_Arg_Tag_n
    [Documentation]    태그 옵션 n
    [Tags]    non
    log    must fail    console=true
    Fail

TC8_Arg_Variable
    [Documentation]    Vaiable example
    [Tags]    var
    ${local_host}=    Set Variable    9.9.9.9
    Log Many    global host-${HOST}    local host-${local_host}
    Log To Console    global host-${HOST}
    Log To Console    local host-${local_host

TC9_Arg_Log
    [Tags]    log
    log    change log level    console=true
    Set Log Level    TRACE
    Comment    Fail

*** Keywords ***
User Keyword
    [Documentation]    example keyword
    Log many    User keyword    user name is ${USER_NAME}
    [Teardown]    Keyword_TEARDOWN

TestSuite_SETUP
    log    1.TestSuite_SETUP    console=true

TestCase_SETUP
    log    2.TestSuite_TestCase_SETUP    console=true

Example_SETUP
    log    3.ExampleTC_SETUP    console=true

Keyword_TEARDOWN
    log    4. Keyword Teardown    console=true

Example_TEARDOWN
    log    5 .ExampleTC_TEARDOWN    console=true

TestCase_TEARDOWN
    log    6.TestSuite_TestCase_TEARDOWN    console=true

TestSuite_TEARDOWN
    log    7.TestSuite_TEARDOWN    console=true
