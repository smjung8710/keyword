*** Settings ***
Documentation     CalculatorLibrary를 이용한 calculator 기능 테스트
Force Tags        cal
Library           CalculatorLibrary.py    WITH NAME    cal

*** Test Cases ***
TC59_abnormal
    Run Keyword And Ignore Error    cal.Push Button    100
    cal.Should Cause Error    Invalid button 100

TC60_add
    cal.Push Button    1
    cal.Push Button    +
    cal.Push Button    2
    cal.Push Button    =
    cal.Result Should Be    3

TC61_Invalid expression
    cal.Push Button    1
    cal.Push Button    +
    Run Keyword And Ignore Error    cal.Push Button    0.2
    Run Keyword And Ignore Error    cal.Push Button    =
    cal.Should Cause Error    SysntaxError

TC62_Division by zero
    cal.Push Button    1
    cal.Push Button    /
    cal.Push Button    0
    Run Keyword And Ignore Error    cal.Push Button    =
    cal.Should Cause Error    Division by zero.

TC63_Button C
    cal.Push Button    9
    cal.Push Button    C
    cal.Result Should Be    ${EMPTY}

TC64_divide
    cal.Push Button    6
    cal.Push Button    /
    cal.Push Button    4
    cal.Push Button    =
    cal.Result Should Be    1

TC65_normal
    cal.Push Button    5
    cal.Push Button    +
    cal.Push Button    4
    cal.Push Button    -
    cal.Push Button    3
    cal.Push Button    *
    cal.Push Button    2
    cal.Push Button    /
    cal.Push Button    1
    cal.Push Button    =
    cal.Result Should Be    6

TC66_Calculation
    Push buttons    5 + 4 - 3 * 2 / 1 =

TC67_BDD_Addition
    Given calculator has been cleared
    When user types "1 + 1"
    and user pushes equals
    Then result is "2"

*** Keywords ***
Calculator has been cleared
    Push button    C

User types "${expression}"
    Push buttons    ${expression}

User pushes equals
    Push button    =

Result is "${result}"
    Result should be    ${result}
