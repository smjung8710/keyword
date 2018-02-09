*** Settings ***
Library           SSHLibrary    WITH NAME    ssh
Resource          ../../common.robot

*** Variables ***
${HOST}           localhost
${USERNAME}       root
${PASSWORD}       keyword

*** Test Cases ***
Ex24_Open Connection
    ssh.Open Connection    ${HOST}
    ${output}=    ssh.login    ${USERNAME}    ${PASSWORD}
    Should Contain    ${output}    Last login
    Should Contain    ${output}    ${USERNAME}
    ${ret}=    ssh.Execute Command    echo hello
    Should Be Equal    ${ret}    hello
    ssh.Close All Connections

Ex24_Example Write
    [Documentation]    Write 키워드, Read Until 키워드 실습.
    [Setup]    SSH 연결 로그인
    [Template]
    ssh.Write    iptables -P INPUT ACCEPT    #방화벽 오픈
    [Teardown]    SSH 연결 종료

Ex24_Example Write Read
    [Documentation]    Write 키워드, Read Until 키워드 실습.
    [Setup]    SSH 연결 로그인
    [Template]
    ssh.Write    cd /home/keyword
    ssh.Write    mkdir automation
    ssh.Write    cd automation
    ssh.Write    touch test.txt
    ${output}=    ssh.Read Until    automation
    log    output:${output}
    Should End With    ${output}    /home/keyword/automation
    File Should Exist    /home/keyword/automation/test.txt
    [Teardown]    SSH 연결 종료

Ex24_Example Execute Command
    [Setup]    SSH 연결 로그인
    ${pwd}=    Execute Command    pwd
    Should Be Equal    ${pwd}    /home/keyword
    Execute Command    cd /tmp
    ${pwd}=    Execute Command    pwd
    Should Be Equal    ${pwd}    /home/keyword
    [Teardown]    SSH 연결 종료

*** Keywords ***
SSH 연결 로그인
    ssh.Close All Connections    #session init
    ssh.Open Connection    ${HOST}    #try new session connect
    : FOR    ${count}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    ssh.Login    ${USERNAME}    ${PASSWORD}
    \    Exit For Loop If    '${status}' == 'True

SSH 연결 종료
    ssh.Close All Connections
