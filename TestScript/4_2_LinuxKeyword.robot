*** Settings ***
Resource          Resource/common.robot

*** Variables ***

*** Test Cases ***
TC30_SSH_Open Connection
    ssh.Open Connection    ${HOST}
    ${output}=    ssh.login    ${USERNAME}    ${PASSWORD}
    Should Contain    ${output}    Last login
    Should Contain    ${output}    ${USERNAME}
    ${ret}=    ssh.Execute Command    echo hello
    Should Be Equal    ${ret}    hello
    ssh.Close All Connections

TC31_Example Write
    [Documentation]    Write 키워드 실습.
<<<<<<< HEAD
    [Setup]    OpenSSH
    [Template]
    ssh.Write    iptables -P INPUT ACCEPT    #방화벽 오픈
    ssh.Read Until    root@
    [Teardown]    CloseSSH

TC32_SSH Write Read
    [Documentation]    Write 키워드, Read Until 키워드 실습.
    [Setup]    OpenSSH
=======
    [Setup]    ConnectSSH
    [Template]
    ssh.Write    iptables -P INPUT ACCEPT    #방화벽 오픈
    ssh.Read Until    root@
    [Teardown]    DisconnectSSH

TC32_SSH Write Read
    [Documentation]    Write 키워드, Read Until 키워드 실습.
    [Setup]    ConnectSSH
>>>>>>> 55029b995a074e4acccb3b0f701254fc20b30404
    [Template]
    ssh.Write    cd /home
    ssh.Write    mkdir automation
    ssh.Write    cd automation
    ssh.Write    touch test.txt
    ssh.Write    pwd
    ${output}=    ssh.Read
    log    output:${output}
    ssh.File Should Exist    /home/automation/test.txt
<<<<<<< HEAD
    [Teardown]    CloseSSH

TC33_SSH Execute Command
    [Setup]    OpenSSH
=======
    [Teardown]    DisconnectSSH

TC33_SSH Execute Command
    [Setup]    ConnectSSH
>>>>>>> 55029b995a074e4acccb3b0f701254fc20b30404
    ${pwd}=    ssh.Execute Command    pwd
    Should Be Equal    ${pwd}    /root
    ssh.Execute Command    cd /tmp
    ${pwd}=    ssh.Execute Command    pwd
    log    ${pwd}
    Should Not Be Equal    ${pwd}    /tmp
<<<<<<< HEAD
    [Teardown]    CloseSSH
=======
    [Teardown]    DisconnectSSH
>>>>>>> 55029b995a074e4acccb3b0f701254fc20b30404

TC34_SSH Set Client Configuration
    [Setup]
    SSH.Open Connection    ${HOST}    alias=keyword
    SSH.Login    ${SSH_ID}    ${SSH_PW}
    SSH.Write    sudo su -
    SSH.Write    ${SSH_PW}
    Set Client Configuration    timeout=10s
    ${output}=    Get Connection
    Should Be Equal As Integers    ${output.timeout}    10
    Should Be Equal As Strings    ${output.alias}    keyword
<<<<<<< HEAD
    [Teardown]    CloseSSH
=======
    [Teardown]    DisconnectSSH
>>>>>>> 55029b995a074e4acccb3b0f701254fc20b30404

TC35_Linux_Diff
    Remote.Create File    /keyword/files.txt    this is file management
    Remote.Create File    /keyword/files2.txt    this is file management
    Remote.Diff Files    /keyword/files.txt    /keyword/files2.txt    fail=TRUE    #같으면 PASS
    Remote.Diff Outputs    /keyword/files.txt    /keyword/files2.txt    fail=FALSE    #다르면 PASS

*** Keywords ***
