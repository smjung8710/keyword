*** Settings ***
Suite Teardown    Close Browser
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리
Library           OperatingSystem    WITH NAME    OS
Library           Selenium2Library    WITH NAME    Sel

*** Variables ***
${URL}            ${EMPTY}
${BROWSER}        ${EMPTY}
${DELAY}          5

*** Test Cases ***
Google_Translate
    [Setup]
    [Template]
    Sel.Open Browser    https://translate.google.co.kr/    gc
    Sel.Input Text    id=source    Hello
    Sel.Element Text Should Be    //span[@id='result_box']/span[1]    안녕하세요
    [Teardown]    Sel.Close Browser

Naver_Login
    [Setup]
    [Template]
    Sel.Open Browser    https://www.naver.com    gc
    Sel.Maximize Browser Window
    Sel.Input Text    id    id
    Sel.Input Text    pw    pw
    Sel.Click Button    로그인
    Sel.Click Button    //*[@id="frmNIDLogin"]/fieldset/span[2]/a

SERVER START
    [Setup]
    OPEN WEB BROWSER    http://localhost:7272    gc

test
    Sel.Open Browser    chrome://settings/searchEngines    gc
    sleep    3
    Click Element    xpath=//*[@id="addSearchEngine"]
    Sel.Input Text    xpath=//*[@id="input"]    yahoo
    Sel.Input Text    xpath=//*[@id="input"]    yahoo.com    //*[@id="paper-input-label-2"]
    Sel.Input Text    xpath=//*[@id="input"]    yahoo.com
    Click Element    //*[@id="actionButton"]
    Comment    Input Text    id=input    yahoo
    Comment    Input Text    \ \ \ \ \ </paper-button>    yahoo.com
    Comment    Input Text    class=url-column weakrtl    yahoo.com
    Execute Javascript
    Confirm Action

Google_Login
    Selenium.Open Browser    https://accounts.google.com/signin    browser=chrome    alias=None    remote_url=http://${RemoteIP}:5555/wd/hub
    Selenium.Maximize Browser Window
    Selenium.Set Selenium Speed    0.1sec
    Selenium.Input Text    xpath=//*[@id="identifierId"]    ${ID}
    Selenium.Input Text    id=userPassword    ${Password}
    Selenium.Click Element    id=loginBtn
    Selenium.Wait Until Page Contains    ${ID}    10sec

*** Keywords ***
OPEN WEB BROWSER
    [Arguments]    ${URL}    ${BROWSER}    ${title}
    Sel.Open Browser    ${URL}    ${BROWSER}
    Sel.Maximize Browser Window
    Sel.Set Selenium Speed    ${DELAY}
    Sel.Title Should Be    ${title}
    [Teardown]

SERVER START
    ${ret}    OS.Run And Return Rc    python C:\\Users\\ahnlab\\github\\keyword\\TestTool\\WebServer\\server.py
    Should Be Equal    ${ret}    0

SERVER END
    AI.Send ^C
