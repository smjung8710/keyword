*** Settings ***
Documentation     Suite description
Force Tags        cal
Library           CalculatorLibrary.py    WITH NAME    cal

*** Test Cases ***
TC1_abnormal
    cal.Push Button    100
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
    cal.Push Button    0.2
    cal.Push Button    =
    cal.Result Should Be    Invalid expression

TC4_Division by zero
    cal.Push Button    1
    cal.Push Button    /
    cal.Push Button    0
    cal.Push Button    =
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
    cal.Result Should Be    1.5

TC7_normal
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

*** Keywords ***
