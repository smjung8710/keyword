*** Settings ***
Documentation     Keyword Based Automation Test
Suite Setup       TS_SETUP
Suite Teardown    TS_TEARDOWN
Test Setup        TC_SETUP
Test Teardown     TC_TEARDOWN
Test Template
Test Timeout      1 hour 40 minutes 2 seconds
Resource          리소스.robot

*** Variables ***
${USER_NAME}      robot
${USER_PASS}      secret
@{USER1}          robot    secret
&{USER2}          name=robot    pass=secret

*** Test Cases ***
Example
    [Documentation]    example testcase
    [Setup]    Example_SETUP
    Example keyword
    [Teardown]    Example_TEARDOWN

Scalar Variable Item
    [Setup]    Example_SETUP
    Log many    ${USER_NAME}    ${USER_PASS}
    Log    ${USER_NAME}
    [Teardown]    Example_TEARDOWN

List Variable Item
    Log many    @{USER1}
    Log    @{USER1}[0]

Dict Variable Item
    Log many    &{USER2}
    Log    &{USER2}[name]

*** Keywords ***
Example keyword
    [Documentation]    example keyword
    Log    keyword
    [Teardown]    K_TEARDOWN

TS_SETUP
    log    1

TC_SETUP
    log    2

Example_SETUP
    log    3

K_TEARDOWN
    log    4

Example_TEARDOWN
    log    5

TC_TEARDOWN
    log    6

TS_TEARDOWN
    log    7
