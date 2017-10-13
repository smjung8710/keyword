*** Settings ***
Library           Remote    http://${ADDRESS}:${PORT}    WITH NAME    remote

*** Variables ***
${ADDRESS}        127.0.0.1
${PORT}           8270

*** Test Cases ***
Failing Example
    Strings Should Be Equal    Hello    Hello
    Strings Should Be Equal    not    equal

101_File
    remote.Create Directory    /tmp/keyword
    remote.File Should Exist    ${file}    No FileManagement

301_파일비교_linux
    Remote.Create File    /keyword/files.txt    this is file management
    Remote.Create File    /keyword/files2.txt    this is file management
    Remote.Diff Files    /keyword/files.txt    /keyword/files2.txt    fail=TRUE    #같으면 PASS
    Remote.Diff Outputs    /keyword/files.txt    /keyword/files2.txt    fail=FALSE    #다르면 PASS
