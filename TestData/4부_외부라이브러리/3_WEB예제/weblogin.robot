*** Settings ***
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리
Library           OperatingSystem    WITH NAME    OS
Library           Selenium2Library    WITH NAME    Sel

*** Variables ***
${URL}            ${EMPTY}
${BROWSER}        ${EMPTY}
${DELAY}          5

*** Test Cases ***
OpenBrowser
    [Setup]
    [Template]
    OPEN BROWSER    https://translate.google.co.kr/    gc
    Sel.Input Text    id=source    Hello
    Sel.Element Text Should Be    //span[@id='result_box']/span[1]    안녕하세요
    [Teardown]    Sel.Close Browser

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
