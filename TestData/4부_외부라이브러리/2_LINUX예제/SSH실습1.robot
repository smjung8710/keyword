*** Settings ***
Library           SSHLibrary    WITH NAME    ssh

*** Test Cases ***
SSH ½Ç½À1
    Open Connection    192.168.x.x
    login    root    keyword
    ${ret}=    Execute Command    echo hello
    Should Be Equal    ${ret}    hello
