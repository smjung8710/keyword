*** Settings ***
Documentation     자체 제작한 ``CalculatorLibrary.py``라이브러리를 이용하여 테스트 케이스 작성한 사례입니다.
Force Tags        Self
Resource          Resource/common.robot

*** Test Cases ***
TC76_My_Makefiles1
    remote.FileMaker    c:\\test\\pdf    pdf    3    #underbar
    FileMaker_RF_remote    c:\\test\\csv    csv    3    #blank

TC77_My_Makefiles2
    Set Global Variable    ${FILES}    c:\\test\\csv
    FileMaker_RF_local    ${FILES}    csv    3

TC78_B4_title
    #서버 적용전 파일로 타이틀 확인
    my.Check Title    C:\\WebServer\\html\\index.html    Login Page
    my.Check Title    C:\\WebServer\\html\\error.html    Error Page
    web.Check Title    C:\\WebServer\\html\\welcome.html    Welcome Page
    #서버 타이틀 확인
    my.Check Title    http://localhost:7272/index.html    Login Page
    my.Check Title    http://localhost:7272/error.html    Error Page
    web.Check Title    http://localhost:7272/welcome.html    Welcome Page
    #구글 타이틀 확인
    my.Check Title    https://www.google.com/    Google
    my.Check Title    https://mail.google.com    Gmail
    my.Check Title    https://translate.google.com/    Google 번역

TC79_MyKeyword
    Comment    my.OpenLoginPageChrome    demo    mode
    my.OpenLoginPageChrome_ByXpath    demo    mode

TC80_My_SMTPEmail
    ${from_email}    Set Variable    from@gmail.com
    ${from_pw}    Set Variable    password
    ${to_email}    Set Variable    to@naver.com
    ${to_title}    Set Variable    RFTEST
    ${to_contents}    Set Variable    keyword automation test with RF
    Mail.send_mail_smtp    ${from_email}    ${from_pw}    ${to_email}    ${to_title}    ${to_contents}

*** Keywords ***
FileMaker_RF
    [Arguments]    ${path}    ${ext}    ${counts}
    : FOR    ${count}    IN RANGE    ${counts}
    \    log    ${count}
    \    remote.create file    ${path}\\${count}.${ext}
    remote.Should Exist    ${path}\\${count}.${ext}
