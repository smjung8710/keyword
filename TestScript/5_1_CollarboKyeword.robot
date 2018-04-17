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
    Snapshot Create    OSX_10.11_El_Capitan    A
    ${ret}    VM.Get Vm Names
    Should Contain    ${ret}    A
    Comment    Snapshot Create    sm_win10_x64_1703_192.168.0.104    B
    Comment    ${ret}    VM.Get Vm Names
    Comment    Should Contain    ${ret}    B
    Comment    Snapshot Create    sm_win10_x64_1703_192.168.0.104    C
    Comment    ${ret}    VM.Get Vm Names
    Comment    Should Contain    ${ret}    C
    Comment    Snapshot Revert    B
    Comment    Snapshot Delete    A
    Comment    Snapshot Exist

TC_Beatiful

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
