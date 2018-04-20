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
    ${var1}    ${var2} =    Return Two Values    1    2
    @{list} =    Return Two Values    1    2
    Should Be Equal    ${var1}    1
    Should Be Equal    ${var2}    2
    Should Be Equal    @{list}[0]    1
    Should Be Equal    @{list}[1]    2

리턴값 세개 확인
    ${s1}    ${s2}    @{li} =    Return Multiple Values    1
    Should Be Equal    ${s1}    a
    Should Be Equal    ${s2}    list
    Should Be Equal    @{li}[0]    of
    Should Be Equal    @{li}[1]    strings

*** Keywords ***
