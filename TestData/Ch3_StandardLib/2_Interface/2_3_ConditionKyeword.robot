*** Settings ***
Resource          Ukey_Standard.robot

*** Test Cases ***
Ex6_Example Condition
    ${condition}=    Set Variable    no
    ${input}=    Dialogs.Get Value From User    choose yes, no
    Run Keyword If    '${condition}'=='${input}'    Dialogs.Pause Execution
    Run Keyword Unless    '${condition}'=='${input}'    Dialogs.Get Selection From User    user1    user2    user3

Ex6_Example MultiCondition
    ${username} =    Dialogs.Get Selection From User    사용자를 선택하세요    user01    user02    user03
    ${password} =    Get Value From User    Input password    hidden=yes
    log    ${username}
    Run Keyword If    '${username}' =='user01' and '${password}'=='1234'    Dialogs.Execute Manual Step    안녕하세요 user01님!    테스트를 시작합니다.
    ...    ELSE IF    '${username}' =='user02' and '${password}'=='5678'    Dialogs.Execute Manual Step    안녕하세요 user02님! 테스트를 시작합니다.
    ...    ELSE IF    '${username}' =='user03' and '${password}'=='0123'    Dialogs.Execute Manual Step    안녕하세요 user03님! 테스트를 시작합니다.
    ...    ELSE    Dialogs.Pause Execution    암호가 틀렸습니다. 테스트를 중지합니다.
    Comment    Run Keyword Unless    '${password}'=='1234'    Dialogs.Pause Execution    암호가 틀렸습니다. 테스트를 중지합니다.
