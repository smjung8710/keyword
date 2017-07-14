*** Settings ***
Documentation       standard library example testsuite
Test Template
Test Timeout        1 second
Resource            리소스.robot

*** Variables ***

*** Test Cases ***
Example Loop
      ${path}=      Set Variable      C:\\Python27
      @{elements}      OS.List Directories In Directory      ${path}
      : FOR      ${directory}      IN      @{elements}
      \      ${file_count}      Count Files      ${path}\\${directory}
      \      &{list}=      Create Dictionary      path=${directory}      count=${file_count}
      \      log many      &{list}

Example Loop_condition
      ${output}=      Connect Share Folder      10.2.8.3      smjung      !ahnlab0
      Run Keyword If      '${output}'!='0'      Fatal Error      Pass Execution

Example Loop_Simple
      Repeat Keyword      5      OS.Run And Return Rc      net use \\\\${IP} /user:${ID} ${PWD} /PERSISTENT:YES
