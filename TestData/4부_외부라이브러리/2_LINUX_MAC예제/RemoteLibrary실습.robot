*** Settings ***
Library           RemoteLibrary    http://${Target_IP}:8270    WITH NAME    Remote

*** Variables ***
${Target_IP}      10.2.6.104

*** Test Cases ***
101_File
    Remote.Create Directory    /tmp/keyword

301_파일비교_linux
    Remote.Create File    /keyword/files.txt    this is file management
    Remote.Create File    /keyword/files2.txt    this is file management
    Remote.Diff Files    /keyword/files.txt    /keyword/files2.txt    fail=TRUE    #같으면 PASS
    Remote.Diff Outputs    /keyword/files.txt    /keyword/files2.txt    fail=FALSE    #다르면 PASS
