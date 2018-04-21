*** Settings ***
Documentation     자체 제작한 ``CalculatorLibrary.py``라이브러리를 이용하여 테스트 케이스 작성한 사례입니다.
Force Tags        Self
Resource          Resource/common.robot

*** Test Cases ***
SMTP Email
    mail.Send Mail    test@gmail.com    password    test@naver.com    RFTEST    withRF

TC_B4_title
    #서버 적용전 파일로 타이틀 확인
    web.Check Title    C:\\WebServer\\html\\index.html    Login Page
    web.Check Title    C:\\WebServer\\html\\error.html    Error Page
    web.Check Title    C:\\WebServer\\html\\welcome.html    Welcome Page
    #서버 타이틀 확인
    web.Check Title    http://localhost:7272/index.html    Login Page
    web.Check Title    http://localhost:7272/error.html    Error Page
    web.Check Title    http://localhost:7272/welcome.html    Welcome Page
    #구글 타이틀 확인
    web.Check Title    https://www.google.com/    Google
    web.Check Title    https://mail.google.com    Gmail
    web.Check Title    https://translate.google.com/    Google 번역

*** Keywords ***
