*** Settings ***
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리
Resource          ../../common.robot

*** Test Cases ***
Ex17_Example_RegRead
    ${key}=    Set Variable    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
    ${arch}    AI.Reg Read    ${key}    PROCESSOR_ARCHITECTURE
    ${first}    ${second}    Run Keyword And Ignore Error    Should Contain    ${arch}    x86
    ${arch}    Set Variable If    '${first}' == 'PASS'    x86    x64
    log    ${arch}

Ex18_Example_RegWrite
    [Documentation]    특정 플랫폼일 때 레지스트리 키 추가하는 예제입니다.
    ${arch}=    GET ARCH
    log    ${arch}
    ${key}=    Set Variable If    '${arch}'=='x64'    HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup    HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
    AI.Reg Write    ${key}    update    REG_DWORD    1
    ${check}    AI.Reg Read    ${key}    update
    Should Contain    ${check}    1

Ex19_Example_RegDeleteVal
    ${arch}=    GET ARCH
    log    ${arch}
    ${key}=    Set Variable If    '${arch}'=='x64'    HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup    HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
    AI.Reg Delete Val    ${key}    update
    Should Not Contain    ${key}    update

*** Keywords ***
