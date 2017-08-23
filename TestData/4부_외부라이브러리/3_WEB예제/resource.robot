*** Settings ***
Documentation     리소스 파일은 재사용 가능한 키워드와 변수로 구성합니다.
...               셀레니움 라이브러리에서 제공하는 키워드를 이용하여 웹 서버에 맞게
...               유저 키워드로 재구성하였습니다.
Library           Selenium2Library    WITH NAME    Sel

*** Variables ***
${SERVER}         localhost:7272
${BROWSER}        gc
${DELAY}          0
${VALID USER}     demo
${VALID PASSWORD}    mode
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    http://${SERVER}/welcome.html
${ERROR URL}      http://${SERVER}/error.html

*** Keywords ***
Open Browser To Login Page
    Sel.Open Browser    ${LOGIN URL}    ${BROWSER}
    Sel.Maximize Browser Window
    Sel.Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Sel.Title Should Be    Login Page

Go To Login Page
    Sel.Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Sel.Input Text    username_field    ${username}

Input Password
    [Arguments]    ${password}
    Sel.Input Text    password_field    ${password}

Submit Credentials
    Sel.Click Button    login_button

Welcome Page Should Be Open
    Sel.Location Should Be    ${WELCOME URL}
    Sel.Title Should Be    Welcome Page

Login Should Have Failed
    Sel.Location Should Be    ${ERROR URL}
    Sel.Title Should Be    Error Page
