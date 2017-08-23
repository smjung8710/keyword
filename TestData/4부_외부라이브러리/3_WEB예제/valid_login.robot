*** Settings ***
Documentation     정상 로그인에 대한 테스트 스윗입니다.
...               테스트 케이스는 리소스 파일에 정의한 유저 키워드로 구성됩니다.
Resource          resource.robot

*** Test Cases ***    English                        Korean
Valid Login           Open Browser To Login Page
                      Input Username                 demo
                      Input Password                 mode
                      Submit Credentials
                      Welcome Page Should Be Open
                      [Teardown]                     Sel.Close Browser

구글번역                  구글번역
                      [Teardown]

구글번역_템플릿이용            [Template]                     구글번역
                      Hello                          안녕하세요
                      thankyou                       고맙습니다
                      take care                      돌보다
                      see you again                  또 보자

*** Keywords ***
구글번역
    [Arguments]    ${English}    ${Korean}
    Sel.Open Browser    https://www.google.co.kr/    gc
    Maximize Browser Window
    Sel.Input Text    id=lst-ib    구글 번역 ${English}
    Click Button    Google 검색
    Sel.Set Selenium Speed    2
    Sel.Element Text Should Be    id=tw-target-text-container    ${Korean}
    Close Browser
