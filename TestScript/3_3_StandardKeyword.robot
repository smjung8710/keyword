*** Settings ***
Force Tags
Resource          Resource/common.robot

*** Test Cases ***
TC11_File Management
    OS.Directory Should Exist    C:\\Python27    No Python27
    OS.Create Directory    C:\\Python27\\FileManagement
    OS.Directory Should Exist    C:\\Python27\\FileManagement    No FileManagement
    ${dir}=    Set Variable    C:\\Python27\\FileManagement
    OS.Create File    ${dir}\\Files.txt    this is file management
    OS.File Should Exist    ${dir}\\Files.txt
    OS.File Should Not Be Empty    ${dir}\\Files.txt
    ${contents}    OS.Get File    ${dir}\\Files.txt
    Should Contain    ${contents}    this is file management

TC12_HostsFile Control
    ${dir}=    Set Variable    C:\\Windows\\System32\\drivers\\etc
    ${ret}=    Run Keyword And Return Status    OS.File Should Exist    ${dir}\\hosts
    Run Keyword If    '${ret}'=='True'    OS.Append To File    ${dir}\\hosts    127.0.0.1 keywordautomation.com
    ${contents}    OS.Get File    ${dir}\\hosts
    Should Contain    ${contents}    keywordautomation.com

TC13_Count
    [Documentation]    Count Items in Directory
    [Tags]    remote
    ${items1} =    OS.Count Items In Directory    ${CURDIR}
    ${items2} =    OS.Count Items In Directory    ${TEMPDIR}
    Log    ${items1} items in '${CURDIR}' and ${items2} items in '${TEMPDIR}'

TC14_Condition
    ${username}    Dialogs.Get Selection From User    사용자를 선택하세요    user01    user02    user03
    ${password}    Dialogs.Get Value From User    암호를 입력하세요    hidden=yes
    Run Keyword If    '${password}'=='1234'    Dialogs.Execute Manual Step    테스트를 시작합니다.
    Run Keyword Unless    '${password}'=='1234'    Dialogs.Pause Execution    암호가 틀렸습니다. 테스트를 중지합니다.

TC15_MultiCondition
    ${username} =    Dialogs.Get Selection From User    사용자를 선택하세요    user01    user02    user03
    ${password} =    Dialogs.Get Value From User    암호를 입력하세요    hidden=yes
    Run Keyword If    '${username}' =='user01' and '${password}'=='1234'    Dialogs.Execute Manual Step    안녕하세요 user01님!    테스트를 시작합니다.
    ...    ELSE IF    '${username}' =='user02' and '${password}'=='5678'    Dialogs.Execute Manual Step    안녕하세요 user02님! 테스트를 시작합니다.
    ...    ELSE IF    '${username}' =='user03' and '${password}'=='0123'    Dialogs.Execute Manual Step    안녕하세요 user03님! 테스트를 시작합니다.
    ...    ELSE    Dialogs.Pause Execution    암호가 틀렸습니다. 테스트를 중지합니다.

TC16_Evaluate
    ${count}=    Set Variable    99
    ${ret}=    Evaluate    ${count}-1
    Should Be Equal As Numbers    ${ret}    98

TC17_GetRegexp
    [Tags]    string
    ${string}=    Set Variable    \\ 1234,00
    ${matches}=    string.Get Regexp Matches    ${string}    \\d+
    Should Be Equal As Strings    ${matches[0]}    1234

TC18_MatchRegexp
    [Tags]    string
    ${output1}=    Set Variable    $123456,78900
    ${output2}=    Set Variable    123456
    builtin.Should Match Regexp    ${output1}    \\d{6}
    builtin.Should Match Regexp    ${output2}    ^\\d{6}$

TC19_Split
    [Tags]    string
    ${hour}    ${minute}    ${second}    Split Log Time    18:55:43

*** Keywords ***
Split Log Time
    [Arguments]    ${log_time}
    ${split_time}    string.Split String    ${log_time}    :
    ${H}    Collections.Get From List    ${split_time}    0
    ${M}    Collections.Get From List    ${split_time}    1
    ${S}    Collections.Get From List    ${split_time}    2
    [Return]    ${H}    ${M}    ${S}
