*** Settings ***
Resource            ../Resource1.robot

*** Variables ***

*** Test Cases ***
Example Variale
      [Documentation]      variable option example
      [Tags]      Variable
      ${USER_NAME}=      Set Variable      keyword
      ${USER_PASS}=      Set Variable      automation
      @{USER1}=      Set Variable      keyword      automation
      &{USER2}=      Create Dictionary      name=keyword      pass=automation
      Log      ${USER_NAME}
      Log      ${USER_PASS}
      Log Many      @{USER1}
      Log Many      &{USER2}
      Log      dictionary - &{USER2}[name]
      Log      scalar - ${USER2.name}
