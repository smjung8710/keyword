*** Settings ***
Documentation     A test suite containing tests related to invalid login.
...
...               These tests are data-driven by their nature. They use a single
...               keyword, specified with Test Template setting, that is called
...               with different arguments to cover different scenarios.
...
...               This suite also demonstrates using setups and teardowns in
...               different levels.
Test Template     Login With Invalid Credentials Should Fail
Resource          resource.robot

*** Test Cases ***    USER NAME        PASSWORD
Invalid Username      invalid          ${VALID PASSWORD}

Invalid Password      ${VALID USER}    invalid

Invalid Username And Password
                      invalid          whatever

Empty Username        ${EMPTY}         ${VALID PASSWORD}

Empty Password        ${VALID USER}    ${EMPTY}

Empty Username And Password
                      ${EMPTY}         ${EMPTY}

Invalid Login         invalid          ${VALID PASSWORD}    #Invalid Username
                      ${VALID USER}    invalid              #Invalid Password
                      invalid          whatever             #Invalid Username And Password
                      ${EMPTY}         ${VALID PASSWORD}    #Empty Username
                      ${VALID USER}    ${EMPTY}             #Empty Password
                      ${EMPTY}         ${EMPTY}             #Empty Username And Password

*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Open Browser To Login Page
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Failed
    Close Browser
