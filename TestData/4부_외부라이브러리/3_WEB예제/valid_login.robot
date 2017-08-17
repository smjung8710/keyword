*** Settings ***
Documentation     정상 로그인에 대한 테스트 스윗입니다.
...               테스트 케이스는 리소스 파일에 정의한 유저 키워드로 구성됩니다.
Resource          resource.robot

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    Input Username    demo
    Input Password    mode
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]    Sel.Close Browser
