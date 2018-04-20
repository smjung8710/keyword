*** Settings ***
Documentation     KeywordLibrary를 이용한 키워드 실습
Library           KeywordLibrary.py    WITH NAME    calkey

*** Test Cases ***
TC_robot_keyword
    calkey.Please press the calculator button    1
    calkey.Please press the calculator button    +
    calkey.Please press the calculator button    1
    calkey.Please press the calculator button    =
    calkey.The Calculator Said It Is    2

TC9_key_Arg
    calkey.Any Arguments
    calkey.Any Arguments    a    b    c    d
    calkey.Any Arguments    1    2    3    4
    calkey.Any Arguments    100
    calkey.Any Int Arguments    100

리턴값 두개 확인
    ${var1}    ${var2} =    Return Two Values
    @{list} =    Return Two Values
    Should Be Equal    ${var1}    first value
    Should Be Equal    ${var2}    second value
    Should Be Equal    @{list}[0]    first value
    Should Be Equal    @{list}[1]    second value

리턴값 세개 확인
    ${s1}    ${s2}    @{li} =    Return Multiple Values
    Should Be Equal    ${s1}     ${s2}    a list
    Should Be Equal    @{li}[0]     @{li}[1]    of strings

*** Keywords ***
