*** Settings ***
Suite Teardown    Close Browser
Resource          Resource/common.robot

*** Variables ***

*** Test Cases ***
TC36_Demo_Login
    OS.Run    C:\\WebServer\server.bat
    Open Browser To Login Page
    Input Username    demo
    Input Password    mode
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]    Sel.Close Browser

TC37_ValidLogin
    Given browser is opened to login page
    When user "demo" logs in with password "mode"    #변수를 키워드에 함께 넣어 사용
    Then welcome page should be open

TC38_Invalid login
    Given Open browser to login page
    When user "demo123" logs in with password "mode123"    #변수를 키워드에 함께 넣어 사용
    Then Login Should Have Failed

TC39_Translation
    [Setup]
    [Template]
    Sel.Open Browser    https://translate.google.co.kr/    gc
    Sel.Title Should Be    Google 번역
    Sel.Input Text    id=source    Hello
    Sel.Set Selenium Speed    1
    Sel.Element Text Should Be    //*[@id="gt-res-dir-ctr"]    안녕하세요
    [Teardown]    Sel.Close Browser

TC40_Translation_by_google
    [Template]    Google_Translate
    #English    #Korean
    Hello    여보세요
    thankyou    고맙습니다
    take care    돌보다
    see you again    또 보자

TC41_MyKeyword
    my.OpenLoginPageChrome    demo    mode

*** Keywords ***
