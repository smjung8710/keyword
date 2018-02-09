*** Settings ***
Documentation     Keyword Based Automation Test
Suite Setup       TS_SETUP
Suite Teardown    TS_TEARDOWN
Test Setup        TC_SETUP
Test Teardown     TC_TEARDOWN
Test Template
Test Timeout      1 hour 40 minutes 2 seconds
Resource          ../../common.robot

*** Variables ***
${USER_NAME}      robot
${USER_PASS}      secret
@{USER1}          robot    secret
&{USER2}          name=robot    pass=secret

*** Test Cases ***
Ex1_RF
    [Documentation]    example testcase
    [Setup]    Example_SETUP
    Example keyword
    #scalar variable
    Log many    ${USER_NAME}    ${USER_PASS}
    Log    Welcome ${USER_NAME}
    #list variable
    Log many    @{USER1}
    Log    Welcome @{USER1}[0]
    #dictionary variable
    Log many    &{USER2}
    Log    Welcome &{USER2}[name]
    [Teardown]    Example_TEARDOWN

*** Keywords ***
Example keyword
    [Documentation]    example keyword
    Log    doing keyword.....
    [Teardown]    Keyword_TEARDOWN

TS_SETUP
    log    1.TS_SETUP

TC_SETUP
    log    2.TC_SETUP

Example_SETUP
    log    3.Example_SETUP

Keyword_TEARDOWN
    log    4.Keyword_TEARDOWN

Example_TEARDOWN
    log    5.Example_TEARDOWN

TC_TEARDOWN
    log    6.TC_TEARDOWN

TS_TEARDOWN
    log    7.TS_TEARDOWN
