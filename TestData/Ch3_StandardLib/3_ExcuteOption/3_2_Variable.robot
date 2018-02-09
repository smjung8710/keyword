*** Settings ***
Resource          ../../common.robot

*** Test Cases ***
Ex11_Example Variable
    [Documentation]    Vaiable example
    [Tags]
    ${local_host}=    Set Variable    9.9.9.9
    Log    global host-${HOST}
    Log    local host-${local_host}
