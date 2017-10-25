*** Settings ***
Resource            리소스.robot

*** Variables ***
${USER_NAME}        robot
${USER_PASS}        secret
@{USER1}            robot      secret
&{USER2}            name=robot      pass=secret

*** Test Cases ***
Scalar Variable Item
      Log many      ${USER_NAME}      ${USER_PASS}
      Log      ${USER_NAME}

List Variable Item
      Log many      @{USER1}
      Log      @{USER1}[0]

Dict Variable Item
      Log many      &{USER2}
      Log      &{USER2}[name]

Example Global Variable
      [Documentation]      variable option example
      [Tags]      Variable
      Set Global Variable      ${USER_NAME}      keyword
      Set Global Variable      ${USER_PASS}      automation
      @{USER1}=      Set Variable      keyword      automation
      &{USER2}=      Create Dictionary      name=keyword      pass=automation
      Log      전역변수 - ${USER_NAME}
      Log      전역변수 - ${USER_PASS}
      Log Many      지역변수 - @{USER1}
      Log Many      지역변수 -&{USER2}
      Log      dictionary - &{USER2}[name]
      Log      scalar - ${USER2.name}

Example Variable
      Log      전역변수 - ${USER_NAME}
      Log      전역변수 - ${USER_PASS}
      Log Many      지역변수 - @{USER1}
      Log Many      지역변수 -&{USER2}
      Log      dictionary - &{USER2}[name]
      Log      scalar - ${USER2.name}
      @{list} =      Set Variable      a      b      c
      @{list2} =      Create List      a      b      c
      ${scalar} =      Create List      a      b      c
      ${ints} =      Create List      ${1}      ${2}      ${3}
      log many      @{list}
      log many      @{list2}
      log      ${scalar}
      log      ${ints}

*** Keywords ***
