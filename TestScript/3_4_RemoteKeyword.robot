*** Settings ***
Resource          Resource/remote.robot

*** Variables ***

*** Test Cases ***
TC20_Remote_Win
    [Documentation]    Remote example testcase
    [Tags]    remote
    [Timeout]    40 minutes
    ${file}=    Set Variable    C:\\remote.txt
    remote.Create File    ${file}
    remote.File Should Exist    ${file}    No FileManagement
    remote.run    ${file}

TC21_Remote_Linux_MAC
    ${dir}=    Set Variable    /tmp/keyword
    ${file}=    Set Variable    ${dir}/remote.txt
    remote.Create Directory    ${dir}
    remote.Create File    ${file}
    remote.Directory Should Exist    ${dir}
    remote.File Should Exist    ${file}    No FileManagement

Remote_linux_Diff
    Remote.Create File    /keyword/files.txt    this is file management
    Remote.Create File    /keyword/files2.txt    this is file management
    Remote.Diff Files    /keyword/files.txt    /keyword/files2.txt    fail=TRUE    #같으면 PASS
    Remote.Diff Outputs    /keyword/files.txt    /keyword/files2.txt    fail=FALSE    #다르면 PASS

*** Keywords ***
