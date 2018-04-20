*** Settings ***
Resource          Resource/common.robot

*** Variables ***

*** Test Cases ***
TC50_DB_Connect
    [Setup]
    DB.Connect To Database    ${DB_API}    ${DB}    ${DB_ID}    ${DB_PW}    ${DB_IP}    ${DB_PORT}
    DB.Check If Exists In Database    SELECT id FROM automation.table WHERE last_name =’musk’;
    DB.Disconnect From Database
    [Teardown]

TC_DB_Delete
    [Setup]    ConnectSSH
    DB.Delete All Rows From Table    automaton.table
    [Teardown]    DisconnectSSH

Change Time
    Set hour    Default    12
    Set min    Default    30
    Set second    Default    50

TC_DB_Connect_by_SSH
    [Setup]    ConnectSSH
    SSH.write    sql ${DB_API} ${DB} ${DB_ID} ${DB_PW} ${DB_IP} ${DP_PORT}
    SSH.write    sql \q
    [Teardown]    DisconnectSSH

TC_VM_Connect
    VM.Open Pysphere Connection    ${VCENTER_IP}    ${VM_ID}    ${VM_PW}
    VM.Power On Vm    OSX_10.11_El_Capitan
    VM.Power Off Vm    OSX_10.11_El_Capitan
    VM.Close Pysphere Connection

TC_VM_Snapshot
    Set Global Variable    ${VM}
    ConnectVM    ${VM}
    Snapshot Create    ${VM}    A    #스냅샷 A 생성
    Wait Until Keyword Succeeds    2m    5s    Snapshot Exist    ${VM}    A
    Snapshot Create    ${VM}    B    #스냅샷 B 생성
    Wait Until Keyword Succeeds    2m    5s    Snapshot Exist    ${VM}    B
    Snapshot Create    ${VM}    C    #스냅샷 C 생성
    Wait Until Keyword Succeeds    2m    5s    Snapshot Exist    ${VM}    C
    Snapshot Revert    B    #스냅샷 B로 리버트
    Snapshot Delete    ${VM}    A    #스냅샷 A 삭제

TC_FTP_Connect
    FTP.Ftp Connect    ${HOST}    ${ID}    ${PW}    timeout=20    ConnId=first
    FTP.Get Welcome
    FTP.Cwd    /home/myname/tmp/testdir    first
    FTP.Mkd    TEST_SAMPLE    first
    FTP.Pwd    first
    FTP.Ftp Close    first

TC_FTP_Upload
    Set Global Variable    ${HOST}    192.168.0.104
    Set Global Variable    ${ID}    keyword
    Set Global Variable    ${PW}    automation
    FTP.Ftp Connect    ${HOST}    user=${ID}    password=${PW}    port=21    timeout=20    connId=first
    FTP.Get Welcome    connId=first
    ${path}    FTP.Pwd    connId=first
    FTP.Cwd    ${path}\\TEST_SAMPLE    connId=first
    @{files}    OS.List Files In Directory    C:\\RF_Template
    :FOR    ${count}    IN    @{files}
    \    Log To Console    ${count}
    \    FTP.Upload File    C:\\RF_Template\\${count}    connId=first
    FTP.Download File    1.txt    FTP_Test.txt    connId=first
    FTP.Ftp Close    connId=first

TC_MY_WIN_ChangeName
   win.Change Under To Blank    C:\\Users\\automation\\test
   win.Change Blank To Underbar    C:\\Users\\automation\\test

*** Keywords ***
DB_Delete
    [Arguments]    @{table_names}
    DB.Connect To Database    ${DB_API}    ${DB}    ${DB_ID}    ${DB_PW}    ${DB_IP}    ${DP_PORT}
    : FOR    ${table_name}    IN    @{table_names}
    \    DB.Delete All Rows From Table    ${table_name}
    \    DB.Row Count Is 0    select * from ${table_name}
    DB.Disconnect From Database

Set second
    [Arguments]    ${pol_name}    ${value}
    DB.Connect To Database    ${DB_API}    ${DB}    ${DB_ID}    ${DB_PW}    ${DB_IP}    5432
    DB.Execute Sql String    update policy set cron_sec=${value} where name=${policy};
    DB.Disconnect From Database

ConnectDB
    DB.Connect To Database    ${DB_API}    ${DB}    ${DB_ID}    ${DB_PW}    ${DB_IP}    ${DB_PORT}
