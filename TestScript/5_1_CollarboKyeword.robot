*** Settings ***
Resource          Resource/common.robot

*** Variables ***

*** Test Cases ***
TC50_DB_Connect
    [Setup]    OpenSSH
    DB.Connect To Database    ${DB_API}    ${DB}    ${DB_ID}    ${DB_PW}    ${DB_IP}    ${DB_PORT}
    DB.Check If Exists In Database    SELECT id FROM automation.table WHERE last_name =’musk’;
    DB.Disconnect From Database
    [Teardown]    CloseSSH

TC_DB_Delete
    [Setup]    OpenSSH
    DB_Delete automation.tale
    [Teardown]    CloseSSH

Change Time
    Set hour    Default    12
    Set min    Default    30
    Set second    Default    50

TC_DB_Connect_by_SSH
    [Setup]    OpenSSH
    SSH.write    sql ${DB_API} ${DB} ${DB_ID} ${DB_PW} ${DB_IP} ${DP_PORT}
    SSH.write    sql \q
    [Teardown]    CloseSSH

TC_VM_Connect
    VM.Open Pysphere Connection    ${CENTER1_IP}    ${ID}    ${PWD}
    VM.Power On Vm    ${mv1}
    VM.Close Pysphere Connection

TC_VM_Switch
    ${my_connection}=    VM.Open Pysphere Connection    ${host1}    ${user}    ${password}
    VM.Open Pysphere Connection    ${host2}    ${myuser}    ${mypassword}    ${alias}=otherhost
    VM.Switch Pysphere Connection    ${host1}
    VM.Power On Vm    ${vm1}
    VM.Switch Pysphere Connection    ${host2}
    VM.Power On Vm    ${vm3}

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
