*** Settings ***
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리
Resource          Resource/common.robot

*** Test Cases ***
TC22_RegRead
    ${key}=    Set Variable    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
    ${arch}    AI.Reg Read    ${key}    PROCESSOR_ARCHITECTURE
    ${first}    ${second}    Run Keyword And Ignore Error    Should Contain    ${arch}    x86
    ${arch}    Set Variable If    '${first}' == 'PASS'    x86    x64
    log    ${arch}

TC23_RegWrite
    [Documentation]    특정 플랫폼일 때 레지스트리 키 추가하는 예제입니다.
    ${arch}=    Get_Platform_Info
    log    ${arch}
    ${key}=    Set Variable If    '${arch}'=='x64'    HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup    HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
    AI.Reg Write    ${key}    update    REG_DWORD    1
    ${check}    AI.Reg Read    ${key}    update
    Should Contain    ${check}    1

TC24_RegDeleteVal
    ${arch}=    Get_Platform_Info
    log    ${arch}
    ${key}=    Set Variable If    '${arch}'=='x64'    HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup    HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
    AI.Reg Delete Val    ${key}    update
    Should Not Contain    ${key}    update

TC25_AI_Keyboard
    AI.Win Minimize All
    sleep    3
    AI.send    \#r
    ${ret}=    AI.Win Get Title    실행
    Should Contain    ${ret}    실행
    AI.send    calc
    AI.send    {enter}
    AI.Process Exists    calc.exe
    sleep    3
    AI.Process Close    calc.exe

TC26_AI_Run
    AI.run    calc.exe
    AI.Process Exists    calc.exe
    sleep    3
    AI.Process Close    calc.exe

TC27_Diff Files
    OS.Create File    C:\\Files1.txt    this is file management
    OS.Create File    C:\\Files2.txt    this is file management test
    Comment    ${ret1}=    Diff.Diff Files    C:\\Files1.txt    C:\\Files2.txt    fail=TRUE    #같으면 PASS
    ${ret2}=    Diff.Diff Files    C:\\Files1.txt    C:\\Files2.txt    fail=FALSE    #같으면 PASS

TC28_Diff Outputs
    OS.Create File    C:\\Files3.txt    this is file management
    OS.Create File    C:\\Files4.txt    this is file management
    Diff.Diff Outputs    C:\\Files3.txt    C:\\Files4.txt    fail=TRUE    #같으면 PASS

TC29_Diff Files2
    OS.Create File    C:\\Files5.txt    this is file management
    OS.Create File    C:\\Files6.txt    this is file management
    OS.Create File    C:\\Files7.txt    this is not file management
    Run Keyword And Expect Error    differences*    Diff.Diff Files    C:\\Files5.txt    C:\\Files6.txt
    Run Keyword And Expect Error    *doesn’t*    Diff.Diff Files    C:\\Files5.txt    C:\\Files7.txt

*** Keywords ***
