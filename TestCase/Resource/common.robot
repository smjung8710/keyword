*** Settings ***
Library           OperatingSystem    WITH NAME    OS    # 표준 라이브러리 OS
Library           Collections    # 표준 라이브러리
Library           DateTime    # 표준 라이브러리
Library           Dialogs    # 표준 라이브러리
Library           Process    # 표준 라이브러리
Library           Screenshot    # 표준 라이브러리
Library           String    # 표준 라이브러리
Library           Telnet    # 표준 라이브러리
Library           XML    # 표준 라이브러리
Library           AutoItLibrary    WITH NAME    AI    #Resource    remote.robot    # 원격 라이브러리 사용을 위한 리소스    # 오토잇라이브러리
Library           DiffLibrary    WITH NAME    Diff
Library           SSHLibrary    WITH NAME    ssh    # Linux, Mac 연결
Library           Selenium2Library    run_on_failure=Sel.Capture Page Screenshot    WITH NAME    Sel    # Web Browser 테스트 라이브러리
Library           AppiumLibrary    run_on_failure=APP.Capture Page Screenshot    WITH NAME    App    # 모바일 앱 테스트 라이브러리
Library           DatabaseLibrary    WITH NAME    DB    # 데이터베이스 라이브러리
Library           PysphereLibrary    WITH NAME    VM
Library           FtpLibrary    WITH NAME    FTP
Library           RequestsLibrary    WITH NAME    req
Library           CalculatorLibrary.py    WITH NAME    Cal    # 예시 라이브러리
Library           MyLibrary.py    WITH NAME    my    # 사용자라이브러리
Library           KeywordLibrary    WITH NAME    calkey

*** Variables ***
${IP}             ${EMPTY}
${ID}             ${EMPTY}
${PW}             ${EMPTY}
${HOST}           8.8.8.8
${SSH_USERNAME}    root
${SSH_PASSWORD}    keyword
${7-zip Path}     C:\\Program Files\\7-Zip
${SERVER}         http://localhost:7272    # WebServer URL
${BROWSER}        gc    # Test Web Browser
${DELAY}          0
${VALID USER}     demo    # WebServer valid ID
${VALID PASSWORD}    mode    # WebServer Valid Password
${LOGIN URL}      ${SERVER}/    # \ WebServer Login Page
${WELCOME URL}    ${SERVER}/welcome.html    # \ WebServer Welcome Page
${ERROR URL}      ${SERVER}/error.html    # \ WebServer Error Page
${DB_API}         psycopg2
${DB}             test_db
${DB_ID}          root
${DB_PW}          keyword
${DB_IP}          192.168.0.200
${DB_PORT}        5432
&{SHARE}          IP=    ID=    PWD=
${VM}             ${EMPTY}
${SNAPSHOT_NAME}    ${EMPTY}
${VCENTER_IP}     10.2.4.216
${VM_PW}          !ahnlab0
${VM_ID}          smjung

*** Keywords ***
Connect Share Folder
    [Arguments]    ${IP}    ${ID}    ${PW}
    : FOR    ${count}    IN RANGE    5
    \    ${output}    OS.Run And Return Rc    net use \\\\${IP} /user:${ID} ${PW} /PERSISTENT:YES
    \    Exit For Loop If    '${output}' == '0'
    \    log    count:${count}
    \    Sleep    0.5s
    \    OS.Run    net use * /delete /yes
    [Return]    ${output}

Connect Share Folder Simple
    [Arguments]    ${IP}    ${ID}    ${PW}
    : FOR    ${count}    IN RANGE    5
    \    ${output}    OS.Run And Return Rc    net use \\\\${IP} /user:${ID} ${PW} /PERSISTENT:YES
    \    Run Keyword If    '${output}' == '0'    Exit For Loop
    \    log    count:${count}
    \    Sleep    0.5s
    \    OS.Run    net use * /delete /yes
    [Return]    ${output}

ConnectSSH
    ssh.Close All Connections    #session init
    ssh.Open Connection    ${IP}    #try new session connect
    : FOR    ${count}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    ssh.Login    ${SSH_USERNAME}    ${SSH_PASSWORD}
    \    Exit For Loop If    '${status}' == 'True'

ConnectVM
    [Arguments]    ${vm}
    VM.Open Pysphere Connection    ${VCENTER_IP}    ${VM_ID}    ${VM_PW}
    VM.Power On Vm    ${vm}

Count Files
    [Arguments]    ${dir_path}
    ${count}=    OS.Count Files In Directory    ${dir_path}
    [Return]    ${count}

DisconnectSSH
    ssh.Close All Connections

Get_Platform_Info
    ${key}=    Set Variable    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
    ${arch}    AI.Reg Read    ${key}    PROCESSOR_ARCHITECTURE
    ${first}    ${second}    Run Keyword And Ignore Error    Should Contain    ${arch}    x86
    log    ${first}
    log    ${second}
    ${arch}    Set Variable If    '${first}' == 'PASS'    x86    x64
    [Return]    ${arch}

ConnectDB
    DB.Connect To Database    ${DB_API}    ${DB}    ${DB_ID}    ${DB_PW}    ${DB_IP}    T

DB_Delete_ALL
    [Arguments]    @{table_names}
    DB.Connect To Database    ${DB_API}    ${DB}    ${DB_ID}    ${DB_PW}    ${DB_IP}    ${DP_PORT}
    DB.Table Must Exist    @{table_names}
    : FOR    ${table_name}    IN    @{table_names}
    \    DB.Delete All Rows From Table    ${table_name}
    \    DB.Row Count Is 0    select * from ${table_name}
    DB.Disconnect From Database

Set second
    [Arguments]    ${pol_name}    ${value}
    DB.Connect To Database    ${DB_API}    ${DB}    ${DB_ID}    ${DB_PW}    ${DB_IP}    5432
    DB.Execute Sql String    update policy set cron_sec=${value} where name=${policy};
    DB.Disconnect From Database
