*** Settings ***
Library           SSHLibrary    WITH NAME    ssh

*** Variables ***
${HOST}           localhost
${USERNAME}       root
${PASSWORD}       keyword

*** Test Cases ***
201_SSH연결
    ssh.Open Connection    ${HOST}
    ${output}=    ssh.login    ${USERNAME}    ${PASSWORD}
    Should Contain    ${output}    Last login
    Should Contain    ${output}    ${USERNAME}
    ${ret}=    ssh.Execute Command    echo hello
    Should Be Equal    ${ret}    hello
    ssh.Close All Connections

202_SSH 실습
    [Documentation]    Write 키워드, Read Until 키워드 실습.
    [Setup]    SSH 연결 로그인
    [Template]
    ssh.Write    cd /home/keyword
    ssh.Write    mkdir automation
    ssh.Write    cd automation
    ssh.Write    touch test.txt
    ${output}=    ssh.Read Until    automation
    Should End With    ${output}    /home/keyword/automation
    File Should Exist    /home/keyword/automation/test.txt
    [Teardown]    SSH 연결 종료

*** Keywords ***
SSH 연결 로그인
    ssh.Open Connection    ${HOST}
    ssh.Login    ${USERNAME}    ${PASSWORD}

SSH 연결 종료
    ssh.Close All Connections
