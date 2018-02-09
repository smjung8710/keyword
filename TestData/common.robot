*** Settings ***
Library           OperatingSystem    WITH NAME    OS
Library           Collections
Library           DateTime
Library           Dialogs
Library           Process
Library           Screenshot
Library           String
Library           Telnet
Library           XML
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리

*** Variables ***
${HOST}           8.8.8.8
${7-zip Path}     C:\\Program Files\\7-Zip

*** Keywords ***
GET ARCH
    ${key}=    Set Variable    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
    ${arch}    AI.Reg Read    ${key}    PROCESSOR_ARCHITECTURE
    ${first}    ${second}    Run Keyword And Ignore Error    Should Contain    ${arch}    x86
    ${arch}    Set Variable If    '${first}' == 'PASS'    x86    x64
    [Return]    ${arch}

OpenSSH
    ssh.Close All Connections    #session init
    ssh.Open Connection    ${HOST}    #try new session connect
    : FOR    ${count}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    ssh.Login    ${ssh_id}    ${ssh_pw}
    \    Exit For Loop If    '${status}' == 'True

CloseSSH
    ssh.Close All Connections
