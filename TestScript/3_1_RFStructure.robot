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
${USER1}          robot    # Scalar Variable Example
@{USER1}          robot    secret    # List Variable Example
&{USER2}          name=robot    pass=secret    # Dictionary Variable Example

*** Test Cases ***
TC1_RFStructure
    [Documentation]    example testcase
    [Setup]    Example_SETUP
    User Keyword    #Call User keyword
    [Teardown]    Example_TEARDOWN

*** Keywords ***
User Keyword
    [Documentation]    example keyword
    Log    Do User keyword
    [Teardown]    Keyword_TEARDOWN

TestSuite_SETUP
    log    1.TestSuite_SETUP

TestCase_SETUP
    log    2.TestCase_SETUP

Example_SETUP
    log    3.Example_SETUP

Keyword_TEARDOWN
    log    4. Keyword Teardown

Example_TEARDOWN
    log    5 .Example_TEARDOWN

TestCase_TEARDOWN
    log    6.TestCase_TEARDOWN

TestSuite_TEARDOWN
    log    7.TestSuite_TEARDOWN
