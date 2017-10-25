*** Settings ***
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리

*** Test Cases ***
101_플랫폼정보확인
    [Documentation]    테스트 타겟 플랫폼 정보 얻기 위해 레지스트리 키워드를 사용한 예제입니다.
    ${arch}=    Get Arch
    log    ${arch}

102_레지스트리 값 추가
    [Documentation]    특정 플랫폼일 때 레지스트리 키 추가하는 예제입니다.
    ${arch}=    GET ARCH
    log    ${arch}
    ${key}=    Set Variable If    '${arch}'=='x64'    HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup    HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
    AI.Reg Write    ${key}    update    REG_DWORD    1
    ${check}    AI.Reg Read    ${key}    update
    Should Contain    ${check}    1

103_레지스트리 값 삭제
    ${arch}=    GET ARCH
    log    ${arch}
    ${key}=    Set Variable If    '${arch}'=='x64'    HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup    HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
    AI.Reg Delete Val    ${key}    update

*** Keywords ***
GET ARCH
    [Documentation]    Reg Read 키워드를 이용하여 \ 테스트 타겟 플랫폼 정보 얻기 위한 유저 키워드입니다.
    ...
    ...    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
    ${key}=    Set Variable    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
    ${arch}    AI.Reg Read    ${key}    PROCESSOR_ARCHITECTURE
    ${first}    ${second}    Run Keyword And Ignore Error    Should Contain    ${arch}    x86
    ${arch}    Set Variable If    '${first}' == 'PASS'    x86    x64
    [Return]    ${arch}
