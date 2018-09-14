*** Settings ***
Resource          Resource/remote.robot

*** Variables ***
${admin_pw}       keyword
${db}             itworld_hero
${table}          automation

*** Test Cases ***
TC81_DB_Create
    [Setup]    ConnectSSH
    #관련 변수 선언
    Set Global Variable    ${admin_pw}    keyword
    Set Global Variable    ${db}    itworld_hero
    Set Global Variable    ${table}    automation
    #DB 연동 시작
    SSH.write    sudo -i -u postgres    #root 권한 사용
    SSH.write    ${admin_pw}
    ${queryResults}    ssh.Read Until    postgres
    log many    ${queryResults}
    SSH.write    psql
    ${queryResults}    ssh.Read Until    postgres=#
    SSH.write    create database ${db};
    SSH.write    \\c ${db}    #DB에 접속
    SSH.write    create SCHEMA ${table};
    ${queryResults}    ssh.Read Until    CREATE SCHEMA
    SSH.write    create table ${table}.table(id varchar(20) primary key, pw varchar(20), name varchar(20), last_name varchar(20));    #table 생성
    ${queryResults}    ssh.Read Until    CREATE TABLE
    SSH.write    insert into ${table}.table values('D', 'D', 'elon','musk');    #값 입력
    ${queryResults}    ssh.Read Until    INSERT
    [Teardown]    DisconnectSSH

TC82_DB_Insert
    [Setup]    ConnectSSH
    ConnectDB
    SSH.write    insert into ${table}.table values('A', 'A', 'keyword','automation');    #값 입력
    ${queryResults}    ssh.Read Until    INSERT
    SSH.write    insert into ${table}.table values('B', 'B', 'bill','gates');    #값 입력
    ${queryResults}    ssh.Read Until    INSERT
    SSH.write    insert into ${table}.table values('C', 'C', 'mark','zuckerberg');    #값 입력
    ${queryResults}    ssh.Read Until    INSERT
    [Teardown]    DisconnectSSH

TC83_DB_Select
    [Setup]    ConnectSSH
    ConnectDB
    SSH.write    SELECT * FROM automation.table WHERE last_name='musk';
    ${ID}    ssh.read
    Should Contain    ${ID}    musk
    [Teardown]    DisconnectSSH

TC84_DB_Update
    [Setup]    ConnectSSH
    ConnectDB
    SSH.write    SELECT * FROM automation.table WHERE id='A';
    SSH.write    update automation.table set last_name='robot' where id='A';
    SSH.write    SELECT * FROM automation.table WHERE id='A';
    ${ID}    ssh.read
    Should Contain    ${ID}    robot
    [Teardown]    DisconnectSSH

TC85_DB_Delete
    [Setup]    ConnectSSH
    ConnectDB
    SSH.write    insert into ${table}.table values('A', 'A', 'keyword','automation');    #값 입력
    ${queryResults}    ssh.Read Until    INSERT
    SSH.write    Delete FROM automation.table WHERE id='A';
    SSH.write    SELECT * FROM automation.table;
    ${ID}    ssh.read
    Should Not Contain    ${ID}    A
    [Teardown]    DisconnectSSH

TC86_VM_Connect
    VM.Open Pysphere Connection    10.2.4.101    ${VM_ID}    ${VM_PW}
    VM.Close Pysphere Connection

TC87_VM_Snapshot
    Set Global Variable    ${VM}    Ubuntu_16.04_LTS_x64_remtoe
    ConnectVM    ${VM}
    #스냅샷 A 생성
    VM.Create Snapshot    ${VM}    A
    Wait Until Keyword Succeeds    2m    5s    Snapshot Exist    ${VM}    A
    #스냅샷 B 생성
    VM.Create Snapshot    ${VM}    B
    Wait Until Keyword Succeeds    2m    5s    Snapshot Exist    ${VM}    B
    #스냅샷 C 생성
    VM.Create Snapshot    ${VM}    C
    Wait Until Keyword Succeeds    2m    5s    Snapshot Exist    ${VM}    C
    #스냅샷 B로 리버트
    VM.Revert Vm To Snapshot    ${VM}    B
    #스냅샷 A 삭제
    VM.Delete Snapshot    ${VM}    A
    VM.Power Off Vm    ${VM}
    VM.Close All Pysphere Connections

TC88_VM_Snapshot_keyword
    [Documentation]    user keyword로 테스트 케이스 가독성을 높임
    Set Global Variable    ${VM}    Ubuntu_16.04_LTS_x64_remtoe
    ConnectVM    ${VM}
    Snapshot Create    ${VM}    A    #스냅샷 A 생성
    Snapshot Create    ${VM}    B    #스냅샷 B 생성
    Snapshot Create    ${VM}    C    #스냅샷 C 생성
    #스냅샷 B로 리버트
    VM.Revert Vm To Snapshot    ${VM}    B
    #스냅샷 A 삭제
    VM.Delete Snapshot    ${VM}    A
    VM.Power Off Vm    ${VM}
    VM.Close All Pysphere Connections

TC89_FTP_Connect
    Set Global Variable    ${HOST}    192.168.0.104
    Set Global Variable    ${ID}    keyword
    Set Global Variable    ${PW}    automation
    FTP.Ftp Connect    ${HOST}    user=${ID}    password=${PW}    port=21    timeout=20    connId=first
    FTP.Get Welcome    connId=first
    ${path}    FTP.Pwd    connId=first
    FTP.Mkd    ${path}\\TEST_SAMPLE    connId=first
    FTP.Ftp Close    connId=first

TC90_FTP_Upload
    Set Global Variable    ${HOST}    192.168.0.104
    Set Global Variable    ${ID}    keyword
    Set Global Variable    ${PW}    automation
    FTP.Ftp Connect    ${HOST}    user=${ID}    password=${PW}    port=21    timeout=20    connId=first
    FTP.Get Welcome    connId=first
    ${path}    FTP.Pwd    connId=first
    FTP.Cwd    ${path}\\TEST_SAMPLE    connId=first
    @{files}    OS.List Files In Directory    C:\\RF_Template
    : FOR    ${count}    IN    @{files}
    \    Log To Console    ${count}
    \    FTP.Upload File    C:\\RF_Template\\${count}    connId=first
    FTP.Download File    1.txt    FTP_Test.txt    connId=first
    FTP.Ftp Close    connId=first

TC91_Request_Connect
    [Tags]    req
    ${ret_webserver}    req.Create Session    webserver    ${SERVER}
    ${ret_google}    req.Create Session    google    http://www.google.com
    log many    ${ret_webserver}
    log many    ${ret_google}

TC92_Request_Get
    [Tags]    req
    #구글 응답 결과
    req.Create Session    google    http://www.google.com
    ${resp}=    Get Request    google    /
    Should Be Equal As Strings    ${resp.status_code}    200
    #구글맵 응답 정보
    req.Create Session    map    https://developers.google.com
    ${resp}=    Get Request    map    /maps/documentation/geocoding/intro?hl=ko
    log    ${resp.status_code}
    log    ${resp.headers}
    log    ${resp.encoding}
    log    ${resp.cookies}
    log    ${resp.content}
    log    ${resp.text}    #한국어 인코딩 적용

*** Keywords ***
Snapshot Create
    [Arguments]    ${VM}    ${SNAPSHOT}
    LOG    SNAPSHOT CREATE
    VM.Create Snapshot    ${VM}    ${SNAPSHOT}
    Wait Until Keyword Succeeds    2m    5s    Snapshot Exist    ${VM}    ${SNAPSHOT}

ConnectDB
    #DB 연동 시작
    SSH.write    sudo -i -u postgres    #root 권한 사용
    SSH.write    ${admin_pw}
    ${queryResults}    ssh.Read Until    postgres
    log many    ${queryResults}
    SSH.write    psql
    ${queryResults}    ssh.Read Until    postgres=#
    SSH.write    \\c ${db}    #DB에 접속
