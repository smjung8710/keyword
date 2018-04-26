*** Settings ***
Documentation     자체 제작한 ``CalculatorLibrary.py``라이브러리를 이용하여 테스트 케이스 작성한 사례입니다.
Force Tags        Self
Library           CalculatorLibrary.py    WITH NAME    cal

*** Test Cases ***
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
