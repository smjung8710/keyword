*** Settings ***
Documentation     remote.robot에 원격 서버가 동작하지 않으면 아래 테스트 케이스의 키워드가 동작하지 않습니다.
...
...               원격 서버 설정이 어려운 상황이면 common.robot을 리소스로 추가하여 사용합니다.
Suite Teardown
Test Teardown     Sel.Close Browser
Force Tags        web
Resource          Resource/remote.robot
Resource          Resource/common.robot

*** Variables ***
${SERVER}         http://localhost:7272
${BROWSER}        gc
${DELAY}          0
${VALID USER}     demo
${VALID PASSWORD}    mode
${WELCOME URL}    ${SERVER}/welcome.html
${ERROR URL}      ${SERVER}/error.html

*** Test Cases ***
TC47_WEB_Login
    [Documentation]    주의: 테스트 웹 서버를 우선 동작시켜야 로그인 페이지에 접속할 수 있습니다.
    [Tags]    login
    Open Browser To Login Page
    Input Username    demo
    Input Password    mode
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]    Sel.Close Browser

TC48_WEB_BDD_Login
    #정상로그인
    Given Open browser to login page
    When user "demo" logs in with password "mode"    #변수를 키워드에 함께 넣어 사용
    Then welcome page should be open
    Sel.Close Browser
    #비정상 로그인
    Given #로그 Open browser to login page
    When user "demo123" logs in with password "mode123"    #변수를 키워드에 함께 넣어 사용
    Then Login Should Have Failed
    Sel.Close Browser

TC49_WEB_GoTo
    Given Open browser to login page
    When user "demo123" logs in with password "mode123"
    Then Login Should Have Failed
    #동일 브라우저에서 로그인 페이지로 이동
    Comment    Go To Login Page
    Go Back Login Page
    When user "demo" logs in with password "mode"
    Then welcome page should be open
    Sel.Close Browser

TC50_WEB_Translation
    [Setup]
    [Template]
    Sel.Open Browser    https://translate.google.co.kr/    gc
    Sel.Title Should Be    Google 번역
    Sel.Input Text    id=source    Hello
    Sel.Set Selenium Speed    1
    Sel.Element Text Should Be    //*[@id="gt-res-dir-ctr"]    안녕하세요
    [Teardown]    Sel.Close Browser

TC51_WEB_Translation_Template
    [Template]    Google_Translate
    #English    #Korean
    Hello    여보세요
    thankyou    고맙습니다
    take care    돌보다
    see you again    또 보자

TC52_WEB_Javascript
    Sel.Open Browser    https://shop.robotframework.org/    gc
    Sel.Title Should Be    Robot Framework - All profits will be used for flourishing Robot Framework
    Sel.Set Selenium Speed    1
    FindPage    //*[@id="root"]/div/footer/div/ul/li[1]/a/span    #root
    Sel.Capture Page Screenshot    shop.png
    Sel.Click Element    //*[@id="root"]/div/footer/div/ul/li[1]/a/span
    Sel.Location Should Be    https://shop.robotframework.org/about
    Sel.Capture Page Screenshot    about.png

TC53_WEB_Webdriver
    [Documentation]    주의: 동작하는 proxy 서버 주소를 이용합니다.
    ${profile}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxProfile()    sys
    Call Method    ${profile}    set_preference    network.proxy.socks    10.2.6.104
    Call Method    ${profile}    set_preference    network.proxy.socks_port    ${8081}
    Call Method    ${profile}    set_preference    network.proxy.socks_remote_dns    ${True}
    Call Method    ${profile}    set_preference    network.proxy.type    ${1}
    Create WebDriver    Firefox    firefox_profile=${profile}
    Go To    http://www.naver.com

*** Keywords ***
Go To Login Page
    Sel.Go To    ${SERVER}
    Login Page Should Be Open

Google_Translate
    [Arguments]    ${English}    ${Korean}    # 번역대상 | 번역예상결과
    Sel.Open Browser    https://translate.google.co.kr/    gc
    Sel.Title Should Be    Google 번역
    Sel.Input Text    id=source    ${English}
    Sel.Set Selenium Speed    1
    Sel.Element Text Should Be    //*[@id="gt-res-dir-ctr"]    ${Korean}
    Sel.Close Browser

Input Password
    [Arguments]    ${password}
    Sel.Input Text    password_field    ${password}

Input Username
    [Arguments]    ${username}
    Sel.Input Text    username_field    ${username}

Login Page Should Be Open
    Sel.Title Should Be    Login Page

Login Should Have Failed
    Sel.Location Should Be    ${ERROR URL}
    Sel.Title Should Be    Error Page

Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Open Browser To Login Page
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Failed
    Close Browser

Open Browser To Login Page
    Sel.Open Browser    ${SERVER}    ${BROWSER}
    Sel.Maximize Browser Window
    Sel.Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Submit Credentials
    Sel.Click Button    login_button

There is file.ext file in dir folder
    [Arguments]    ${file}    ${ext}    ${dir}
    ${ret}=    Run Keyword And Return Status    OS.Directory Should Exist    C:\\${dir}
    Run Keyword If    '${ret}'=='False'    OS.Create Directory    C:\\${dir}
    OS.Directory Should Exist    C:\\${dir}    No Directory
    OS.Create File    C:\\${dir}\\${file}.${ext}
    OS.File Should Exist    C:\\${dir}\\${file}.${ext}    No Files

User "${username}" logs in with password "${password}"
    Input username    ${username}
    Input password    ${password}
    Submit credentials

Welcome Page Should Be Open
    Sel.Location Should Be    ${WELCOME URL}
    Sel.Title Should Be    Welcome Page

FindPage
    [Arguments]    ${id}    # value possible only id or xpath
    #입력값에 // 가있으면 xpath
    ${ret}    ${output}    Run Keyword And Ignore Error    Should Contain    ${id}    //
    log    ${ret}
    #xpath로 수행
    run keyword if    '${ret}'=='Pass'    Execute Javascript    window.document.evaluate("${id}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    #id로 수행
    run keyword if    '${ret}'=='Fail'    Execute Javascript    window.document.getElementById("${id}").scrollIntoView(true);

Go Back Login Page
    Sel.Go Back
    Login Page Should Be Open
