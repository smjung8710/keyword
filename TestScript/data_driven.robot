*** Settings ***
Documentation     Example test cases using the data-driven testing approach.
...
...               The _data-driven_ style works well when you need to repeat
...               the same workflow multiple times.
...
...               Tests use ``Calculate`` keyword created in this file, that in
...               turn uses keywords in ``CalculatorLibrary.py``. An exception
...               is the last test that has a custom _template keyword_.
...
...               Notice that one of these tests fails on purpose to show how
...               failures look like.
Test Template     Calculate
Library           CalculatorLibrary.py

*** Test Cases ***    Expression    Expected
DDD_Addition          12 + 2 + 2    16
                      2 + -3        -1

DDD_Subtraction       12 - 2 - 2    8
                      2 - -3        5

DDD_Multiplication    12 * 2 * 2    48
                      2 * -3        -6

DDD_Division          12 / 2 / 2    3
                      2 / -3        -1

DDD_Failing           1 + 1         3

DDD_Calculation error
                      [Template]    Calculation should fail
                      kekkonen      Invalid button 'k'.
                      ${EMPTY}      Invalid expression.
                      1 / 0         Division by zero.

*** Keywords ***
Calculate
    [Arguments]    ${expression}    ${expected}
    Push buttons    C${expression}=
    Result should be    ${expected}

Calculation should fail
    [Arguments]    ${expression}    ${expected}
    ${error} =    Should cause error    C${expression}=
    Should be equal    ${expected}    ${error}    # Using `BuiltIn` keyword
