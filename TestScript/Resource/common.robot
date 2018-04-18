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
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리
Library           SSHLibrary    WITH NAME    ssh    # Linux, Mac 연결
Library           Selenium2Library    run_on_failure=Sel.Capture Page Screenshot    WITH NAME    Sel    # Web Browser 테스트 라이브러리
Library           CalculatorLibrary.py    WITH NAME    Cal    # 자체 제작 라이브러리
Library           AppiumLibrary    WITH NAME    App    # 모바일 앱 테스트 라이브러리
Library           DatabaseLibrary    WITH NAME    DB    # 데이터베이스 라이브러리
Library           PysphereLibrary    WITH NAME    VM
Library           ImapLibrary    WITH NAME    Mail
Library           DiffLibrary    WITH NAME    Diff
Library           FtpLibrary    WITH NAME    FTP
Resource          remote.robot    # 원격 라이브러리 사용을 위한 리소스
Library           MyWebLibrary.py    WITH NAME    web
Library           MyWinLibrary.py    WITH NAME    win

*** Variables ***
${SHARE_IP}       ${EMPTY}
${SHARE_ID}       ${EMPTY}
${SHARE_PWD}      ${EMPTY}
${HOST}           8.8.8.8
${SSH_USERNAME}    root
${SSH_PASSWORD}    keyword
${7-zip Path}     C:\\Program Files\\7-Zip
${SERVER}         localhost:7272    # WebServer URL
${BROWSER}        gc    # Test Web Browser
${DELAY}          0
${VALID USER}     demo    # WebServer valid ID
${VALID PASSWORD}    mode    # WebServer Valid Password
${LOGIN URL}      http://${SERVER}/    # \ WebServer Login Page
${WELCOME URL}    http://${SERVER}/welcome.html    # \ WebServer Welcome Page
${ERROR URL}      http://${SERVER}/error.html    # \ WebServer Error Page
${DB_API}         psycopg2
${DB}             mydb
${DB_ID}          root
${DB_PW}          keyword
${DB_IP}          192.168.0.0
${DP_PORT}        5432
${VM}             ${EMPTY}
${SNAPSHOT_NAME}    ${EMPTY}
${VCENTER_IP}     10.2.4.216
${VM_PW}          !ahnlab0
${VM_ID}          smjung

*** Keywords ***
Browser is opened to login page
    Open browser to login page

DisconnectSSH
    ssh.Close All Connections

Connect Share Folder
    [Arguments]    ${ip}    ${id}    ${pwd}
    : FOR    ${count}    IN RANGE    5
    \    ${output}    OS.Run And Return Rc    net use \\\\${ip} /user:${id} ${pwd} /PERSISTENT:YES
    \    Exit For Loop If    '${output}' == '0'
    \    log    count:${count}
    \    Sleep    0.5s
    \    OS.Run    net use * /delete /yes
    [Return]    ${output}

Connect Share Folder Simple
    [Arguments]    ${ip}    ${id}    ${pwd}
    : FOR    ${count}    IN RANGE    5
    \    ${output}    OS.Run And Return Rc    net use \\\\${IP} /user:${ID} ${PWD} /PERSISTENT:YES
    \    Exit For Loop If    '${output}' == '0'
    \    log    count:${count}
    \    Sleep    0.5s
    \    OS.Run    net use * /delete /yes
    [Return]    ${output}

Count Files
    [Arguments]    ${dir_path}
    ${count}=    OS.Count Files In Directory    ${dir_path}
    [Return]    ${count}

Get_Platform_Info
    ${key}=    Set Variable    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
    ${arch}    AI.Reg Read    ${key}    PROCESSOR_ARCHITECTURE
    ${first}    ${second}    Run Keyword And Ignore Error    Should Contain    ${arch}    x86
    ${arch}    Set Variable If    '${first}' == 'PASS'    x86    x64
    [Return]    ${arch}

Go To Login Page
    Sel.Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Password
    [Arguments]    ${password}
    Sel.Input Text    password_field    ${password}

Input Username
    [Arguments]    ${username}
    Sel.Input Text    username_field    ${username}

Login Page Should Be Open
    Sel.Title Should Be    Login Page

Login Should Have Failed
    Sel.Location Should Be    ${ERROR URL}
    Sel.Title Should Be    Error Page

Open Browser To Login Page
    Sel.Open Browser    ${LOGIN URL}    ${BROWSER}
    Comment    Sel.Maximize Browser Window
    Sel.Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

ConnectSSH
    ssh.Close All Connections    #session init
    ssh.Open Connection    ${HOST}    #try new session connect
    : FOR    ${count}    IN RANGE    20
    \    ${status}    Run Keyword And Return Status    ssh.Login    ${SSH_USERNAME}    ${SSH_PASSWORD}
    \    Exit For Loop If    '${status}' == 'True

Submit Credentials
    Sel.Click Button    login_button

User "${username}" logs in with password "${password}"
    Input username    ${username}
    Input password    ${password}
    Submit credentials

Welcome Page Should Be Open
    Sel.Location Should Be    ${WELCOME URL}
    Sel.Title Should Be    Welcome Page

Google_Translate
    [Arguments]    ${English}    ${Korean}    # 번역대상 | 번역예상결과
    Sel.Open Browser    https://translate.google.co.kr/    gc
    Sel.Title Should Be    Google 번역
    Sel.Input Text    id=source    ${English}
    Sel.Set Selenium Speed    1
    Sel.Element Text Should Be    //*[@id="gt-res-dir-ctr"]    ${Korean}
    Sel.Close Browser

Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Open Browser To Login Page
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Failed
    Close Browser

Snapshot Create
    [Arguments]    ${VM}    ${SNAPSHOT_NAME}    # 사용할 Host 이름 | 사용할 스냅샷 이름
    [Documentation]    Create VM snapshot
    [Tags]    VM
    Run Keyword If    '${VCENTER_IP}'=='${empty}'    Fail    There is no VCenter
    VM.Open Pysphere Connection    ${VCENTER_IP}    ${VM_ID}    ${VM_PW}
    VM.Power On Vm    ${VM}
    VM.Create Snapshot    ${VM}    ${SNAPSHOT_NAME}
    Log To Console    starting to create \ Snapshot

Snapshot Delete
    [Arguments]    ${VM}    ${SNAPSHOT_NAME}
    [Documentation]    Delete VM snapshot
    [Tags]    VM
    VM.Open Pysphere Connection    ${VCENTER_IP}    ${VM_ID}    ${VM_PW}
    VM.Delete Snapshot    ${VM}    ${SNAPSHOT_NAME}
    VM.Close All Pysphere Connections

Snapshot Revert
    [Arguments]    ${SNAPSHOT_NAME}
    [Documentation]    Revert snapshot
    [Tags]    VM
    VM.Open Pysphere Connection    ${VCENTER_IP}    ${VM_ID}    ${VM_PW}
    VM.Revert Vm To Snapshot    ${SNAPSHOT_NAME}

ConnectVM
    [Arguments]    ${vm}
    VM.Open Pysphere Connection    ${VCENTER_IP}    ${VM_ID}    ${VM_PW}
    VM.Power On Vm    ${vm}
