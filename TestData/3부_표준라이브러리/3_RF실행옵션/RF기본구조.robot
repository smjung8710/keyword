*** Settings ***
Documentation       Keyword Based Automation Test
Suite Setup         TS_SETUP
Suite Teardown      TS_TEARDOWN
Test Setup          TC_SETUP
Test Teardown       TC_TEARDOWN
Test Template
Test Timeout        1 hour 40 minutes 2 seconds
Resource            리소스.robot

*** Variables ***
${USER_NAME}        robot
${USER_PASS}        secret
@{USER1}            robot      secret
&{USER2}            name=robot      pass=secret

*** Test Cases ***
Example
      [Documentation]      example testcase
      [Setup]      SETUP
      Example keyword
      [Teardown]      TEARDOWN

Scalar Variable Item
      [Setup]      SETUP
      Log many      ${USER_NAME}      ${USER_PASS}
      Log      ${USER_NAME}
      [Teardown]      TEARDOWN

List Variable Item
      Log many      @{USER1}
      Log      @{USER1}[0]

Dict Variable Item
      Log many      &{USER2}
      Log      &{USER2}[name]

*** Keywords ***
Example keyword
      [Documentation]      example keyword
      Log      keyword
      [Teardown]      K_TEARDOWN

TS_SETUP
      log      1

TC_SETUP
      log      2

SETUP
      log      3

K_TEARDOWN
      log      4

TEARDOWN
      log      5

TC_TEARDOWN
      log      6

TS_TEARDOWN
      log      7
