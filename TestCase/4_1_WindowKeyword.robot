*** Settings ***
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리
Resource          Resource/common.robot

*** Test Cases ***
TC37_AutoIt_RegRead
    ${key}=    Set Variable    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
    ${arch}    AI.Reg Read    ${key}    PROCESSOR_ARCHITECTURE
    ${first}    ${second}    Run Keyword And Ignore Error    Should Contain    ${arch}    x86
    ${arch}    Set Variable If    '${first}' == 'PASS'    x86    x64
    log    ${arch}

TC38_AutoIt_RegWrite
    [Documentation]    특정 플랫폼일 때 레지스트리 키 추가하는 예제입니다.
    ${arch}=    Get_Platform_Info
    log    ${arch}
    ${key}=    Set Variable If    '${arch}'=='x64'    HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup    HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
    AI.Reg Write    ${key}    update    REG_DWORD    1
    ${check}    AI.Reg Read    ${key}    update
    Should Contain    ${check}    1

TC39_AutoIt_RegDeleteVal
    ${arch}=    Get_Platform_Info
    log    ${arch}
    ${key}=    Set Variable If    '${arch}'=='x64'    HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup    HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
    AI.Reg Delete Val    ${key}    update
    Should Not Contain    ${key}    update

TC40_AutoIt_Keyboard
    AI.Win Minimize All
    sleep    3
    AI.send    \#r
    ${ret}=    AI.Win Get Title    실행
    Should Contain    ${ret}    실행
    AI.send    calc
    AI.send    {enter}
    ${rc}    ${list}    Run And Return Rc And Output    tasklist
    log many    ${list}
    AI.Process Exists    calc.exe
    sleep    3
    AI.Process Close    calc.exe

TC41_AutoIt_Run
    ${app}=    Set Variable    calc.exe
    ${app_title}=    Set Variable    계산기
    AI.run    ${app}
    AI.Win Wait Active    ${app_title}
    AI.Win Close    ${app_title}

*** Keywords ***
