*** Settings ***
Suite Setup       SSH 연결 로그인
Suite Teardown    SSH 연결 종료
Library           SSHLibrary    WITH NAME    ssh

*** Variables ***
${HOST}           localhost
${USERNAME}       root
${PASSWORD}       keyword

*** Test Cases ***
201_SSH연결
    Open Connection    192.168.x.x
    login    root    keyword
    ${ret}=    Execute Command    echo hello
    Should Be Equal    ${ret}    hello

202_SSH 실습
    [Documentation]    Write 키워드, Read Until 키워드 실습.
    ssh.Write    cd ..
    ssh.Write    echo Hello keword automation
    ${output}=    ssh.Read Until    automation
    Should End With    ${output}    Hello keword automation

*** Keywords ***
SSH 연결 로그인
    Open Connection    ${HOST}
    Login    ${USERNAME}    ${PASSWORD}

SSH 연결 종료
    ssh.Close All Connections
