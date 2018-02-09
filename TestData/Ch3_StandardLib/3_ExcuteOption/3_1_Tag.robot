*** Settings ***
Force Tags        BVT
Default Tags      critical    patch5
Resource          ../../common.robot

*** Variables ***

*** Test Cases ***
Ex10_Example Tag
    [Documentation]    tag example
    [Tags]    host-${HOST
    Log    host-${HOST}
