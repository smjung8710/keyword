*** Settings ***
Force Tags          BVT
Default Tags        critical      patch5
Resource            ../Resource1.robot

*** Variables ***

*** Test Cases ***
Example Tag
      [Documentation]      tag example
      [Tags]      host-${HOST}      Variable
      Log      host-${HOST}
