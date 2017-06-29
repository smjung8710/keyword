*** Settings ***
Documentation       standard library example testsuite
Test Template
Test Timeout        1 second
Resource            ../Resource1.robot

*** Variables ***

*** Test Cases ***
File Management
      OS.Directory Should Exist      C:\\Python27      No Python27
      OS.Create Directory      C:\\Python27\\FileManagement
      OS.Directory Should Exist      C:\\Python27\\FileManagement      No FileManagement
      ${dir}=      Set Variable      C:\\Python27\\FileManagement
      OS.Create File      ${dir}\\Files.txt      this is file management
      OS.File Should Exist      ${dir}\\Files.txt
      OS.File Should Not Be Empty      ${dir}\\Files.txt
      OS.run      notepad.exe ${dir}\\Files.txt

HostsFile Control
      ${dir}=      Set Variable      C:\\Windows\\System32\\drivers\\etc
      ${ret}=      Run Keyword And Return Status      OS.File Should Exist      ${dir}\\hosts
      Run Keyword If      '${ret}'=='True'      OS.Append To File      ${dir}\\hosts      127.0.0.1 keywordautomation.com
      OS.run      notepad.exe ${dir}\\hosts

Example Condition
      ${condition}=      Set Variable      no
      ${input}=      Dialogs.Get Value From User      yes, no를 선택해주세요
      Run Keyword If      '${condition}'=='${input}'      Dialogs.Pause Execution
      Run Keyword If      '${condition}'!='${input}'      log      input yes
      Comment      Run Keyword Unless      '${condition}'=='${input}'      Dialogs.Get Selection From User      user1      user2      user3

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
      Repeat Keyword      5      OS.Run And Return Rc      net use \\\\${ip} /user:${id} ${pwd} /PERSISTENT:YES

Example Template
      [Template]      There is file.ext file in dir folder
      1      txt      RF_Template
      2      docx      RF_Template
      3      xlsx      RF_Template
      4      png      RF_Template
      5      zip      RF_Template
      6      hwp      RF_Template
      7      py      RF_Template
      8      pyc      RF_Template
      9      ppt      RF_Template
      10      7zip      RF_Template

*** Keywords ***
There is file.ext file in dir folder
      [Arguments]      ${file}      ${ext}      ${dir}
      ${ret}=      Run Keyword And Return Status      OS.Directory Should Exist      C:\\${dir}
      Run Keyword If      '${ret}'=='False'      OS.Create Directory      C:\\${dir}
      OS.Directory Should Exist      C:\\${dir}      No Directory
      OS.Create File      C:\\${dir}\\${file}.${ext}
      OS.File Should Exist      C:\\${dir}\\${file}.${ext}      No Files

Connect Share Folder
      [Arguments]      ${ip}      ${id}      ${pwd}
      : FOR      ${count}      IN RANGE      5
      \      ${output}      OS.Run And Return Rc      net use \\\\${ip} /user:${id} ${pwd} /PERSISTENT:YES
      \      Exit For Loop If      '${output}' == '0'
      \      log      count:${count}
      \      Sleep      0.5s
      \      OS.Run      net use * /delete /yes
      [Return]      ${output}

Count Files
      [Arguments]      ${dir_path}
      ${count}=      OS.Count Files In Directory      ${dir_path}
      [Return]      ${count}

Connect Share Folder Simple
      [Arguments]      ${ip}      ${id}      ${pwd}
      : FOR      ${count}      IN RANGE      5
      \      ${output}      OS.Run And Return Rc      net use \\\\${ip} /user:${id} ${pwd} /PERSISTENT:YES
      \      Exit For Loop If      '${output}' == '0'
      \      log      count:${count}
      \      Sleep      0.5s
      \      OS.Run      net use * /delete /yes
      [Return]      ${output}
