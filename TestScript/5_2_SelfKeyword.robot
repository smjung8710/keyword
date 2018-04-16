*** Settings ***
Documentation     자체 제작한 ``CalculatorLibrary.py``라이브러리를 이용하여 테스트 케이스 작성한 사례입니다.
Force Tags        Self
Library           CalculatorLibrary.py    WITH NAME    cal

*** Test Cases ***
EX_Push button
    Push button    1
    Result should be    1

Push multiple buttons
    Push button    1
    Push button    2
    Result should be    12

Simple calculation
    Push button    1
    Push button    +
    Push button    2
    Push button    =
    Result should be    3

Longer calculation
    Push buttons    5 + 4 - 3 * 2 / 1 =
    Result should be    3

Clear
    Push button    1
    Push button    C
    Result should be    ${EMPTY}    # ${EMPTY} is a built-in variable

Simple calculation2
    Push button    5
    Push button    +
    Push button    4
    Push button    -
    Push button    3
    Push button    *
    Push button    2
    Push button    /
    Push button    1
    Push button    =
    Result should be    3

TC1_abnormal
    Run Keyword And Ignore Error    cal.Push Button    100
    cal.Should Cause Error    Invalid button 100

TC2_Try
    cal.Push Button    1
    cal.Push Button    +
    cal.Push Button    2
    cal.Push Button    =
    cal.Result Should Be    3

TC3_Invalid expression
    cal.Push Button    1
    cal.Push Button    +
    Run Keyword And Ignore Error    cal.Push Button    0.2
    Run Keyword And Ignore Error    cal.Push Button    =
    cal.Should Cause Error    SysntaxError

TC4_Division by zero
    cal.Push Button    1
    cal.Push Button    /
    cal.Push Button    0
    Run Keyword And Ignore Error    cal.Push Button    =
    cal.Should Cause Error    Division by zero.

TC5_Button C
    cal.Push Button    9
    cal.Push Button    C
    cal.Result Should Be    ${EMPTY}

TC6_divide
    cal.Push Button    6
    cal.Push Button    /
    cal.Push Button    4
    cal.Push Button    =
    cal.Result Should Be    1

TC7_normal
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
    cal.Result Should Be    3

Calculation
    Push buttons    5 + 4 - 3 * 2 / 1 =

BDD_Addition
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
