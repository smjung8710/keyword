*** Settings ***
Resource          Resource/common.robot

*** Variables ***
${HOST}           localhost
${ssh_id}         root
${ssh_pw}         keyword

*** Test Cases ***
TC42_SSH_Open Connection
    ssh.Open Connection    ${HOST}
    ${output}=    ssh.login    ${ssh_id}    ${ssh_pw}
    Should Contain    ${output}    Last login
    Should Contain    ${output}    ${ssh_id}
    ${ret}=    ssh.Execute Command    echo hello
    Should Be Equal    ${ret}    hello
    ssh.Close All Connections

TC43_SSH_Write
    [Documentation]    Write 키워드 실습.
    [Setup]    ConnectSSH
    [Template]
    ssh.Write    iptables -P INPUT ACCEPT    #방화벽 오픈
    ssh.Read Until    root@
    [Teardown]    DisconnectSSH

TC44_SSH Write Read
    [Documentation]    Write 키워드, Read Until 키워드 실습.
    [Setup]    ConnectSSH
    [Template]
    ssh.Write    cd /home
    ssh.Write    mkdir automation
    ssh.Read
    ssh.Directory Should Exist    /home/automation
    ssh.Write    cd automation
    ssh.Write    touch test.txt
    ssh.Read
    ssh.Write    pwd
    ${output}=    ssh.Read
    log    output:${output}
    ssh.File Should Exist    /home/automation/test.txt
    [Teardown]    DisconnectSSH

TC45_SSH Execute Command
    [Setup]    ConnectSSH
    ${pwd}=    ssh.Execute Command    pwd
    Should Be Equal    ${pwd}    /root
    ssh.Execute Command    cd /tmp
    ${pwd}=    ssh.Execute Command    pwd
    log    ${pwd}
    Should Not Be Equal    ${pwd}    /tmp
    [Teardown]    DisconnectSSH

TC46_SSH Set Client Configuration
    [Setup]    ConnectSSH
    Set Client Configuration    timeout=10s
    Set Client Configuration    alias=keyword
    ${output}=    Get Connection
    Should Be Equal As Integers    ${output.timeout}    10
    Should Be Equal As Strings    ${output.alias}    keyword
    [Teardown]    DisconnectSSH

*** Keywords ***
account
    Set Global Variable    ${IP}    10.2.8.3
    Set Global Variable    ${ID}    root
    Set Global Variable    ${PW}    keyword
