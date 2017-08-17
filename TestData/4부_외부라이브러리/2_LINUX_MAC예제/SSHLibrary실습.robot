*** Settings ***
Library           SSHLibrary    WITH NAME    ssh

*** Variables ***
${HOST}           192.168.102.205
${USERNAME}       root
${PASSWORD}       keyword

*** Test Cases ***
201_SSH연결
    ssh.Open Connection    ${HOST}
    ssh.login    ${USERNAME}    ${PASSWORD}
    ${ret}=    ssh.Execute Command    echo hello
    Should Be Equal    ${ret}    hello

202_SSH 실습
    [Documentation]    Write 키워드, Read Until 키워드 실습.
    [Setup]    SSH 연결 로그인
    [Template]    SSH 연결 종료
    ssh.Write    cd ..
    ssh.Write    echo Hello keword automation
    ${output}=    ssh.Read Until    automation
    Should End With    ${output}    Hello keword automation
    ssh.Close All Connections

*** Keywords ***
SSH 연결 로그인
    ssh.Open Connection    ${HOST}
    ssh.Login    ${USERNAME}    ${PASSWORD}

SSH 연결 종료
    ssh.Close All Connections
