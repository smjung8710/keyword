*** Settings ***
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리
Library           OperatingSystem    WITH NAME    OS
Library           Selenium2Library    WITH NAME    Sel

*** Variables ***
${URL}            ${EMPTY}
${BROWSER}        ${EMPTY}
${DELAY}          5

*** Test Cases ***
OpenBrowser 구글
    [Setup]
    [Template]
    Sel.Open Browser    https://translate.google.co.kr/    gc
    Sel.Input Text    id=source    Hello
    Sel.Element Text Should Be    //span[@id='result_box']/span[1]    안녕하세요
    [Teardown]    Sel.Close Browser

OpenBrowser NAVER
    [Setup]
    [Template]
    Sel.Open Browser    https://www.naver.com    gc
    Sel.Maximize Browser Window
    Sel.Input Text    id    jsm1111111
    Sel.Input Text    pw    breakaleg2014
    Sel.Click Button    로그인

SERVER START
    [Setup]
    OPEN BROWSER    http://localhost:7272    gc

*** Keywords ***
OPEN BROWSER
    [Arguments]    ${URL}    ${BROWSER}
    Sel.Open Browser    ${URL}    ${BROWSER}
    Sel.Maximize Browser Window
    Sel.Set Selenium Speed    ${DELAY}
    Sel.Title Should Be    Google 번역
    [Teardown]

AI.Run
    [Arguments]    ${arg1}

SERVER START
    ${ret}    OS.Run And Return Rc    python C:\\Users\\ahnlab\\github\\keyword\\TestTool\\WebServer\\server.py
    Should Be Equal    ${ret}    0

SERVER END
    AI.Send ^C
