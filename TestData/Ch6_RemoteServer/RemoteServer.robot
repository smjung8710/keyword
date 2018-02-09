*** Settings ***
Documentation     standard library example testsuite
Test Timeout      2 hours
Library           Remote    http://${ADDRESS}:8270    WITH NAME    remote

*** Variables ***
${ADDRESS}        192.168.102.122

*** Test Cases ***
Count Items in Directory
    ${items1} =    Count Items In Directory    ${CURDIR}
    ${items2} =    Count Items In Directory    ${TEMPDIR}
    Log    ${items1} items in '${CURDIR}' and ${items2} items in '${TEMPDIR}'

Failing Example
    Strings Should Be Equal    Hello    Hello
    Strings Should Be Equal    not    equal

Example Remote
    [Documentation]    Remote example testcase
    [Timeout]    40 minutes
    ${file}=    Set Variable    D:\\remote.txt
    remote.Create File    ${file}
    remote.File Should Exist    ${file}    No FileManagement
    remote.run    ${file}
