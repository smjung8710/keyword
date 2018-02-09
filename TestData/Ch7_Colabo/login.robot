*** Settings ***
Resource          local_resource.txt
Library           MyKeyLibrary    WITH NAME    my

*** Test Cases ***
login
    Sel.Open Browser    http://www.google.com    chrome
    sleep    3
    Sel.Title Should Be    Google
    sel.input text     //*[@id="lst-ib"]    robot framework
    AI.Send    {ENTER}



*** Keywords ***
Login
    [Arguments]    ${id}    ${pw}
    Sel.Open Browser    https://accounts.google.com/signin    chrome
    Sel.Title Should Be    로그인 - Google 계정
    Sel.Input Text    xpath=/html/body/div[1]/div[1]/div[2]/div[2]/form/div[2]/div/div[1]/div[1]/div/div[1]/div/div[1]/input    ${id}
    Sel.Click Element    //*[@id="identifierNext"]/content
    sleep    3
    Sel.Input Text    xpath=//*[@id="password"]/div[1]/div/div[1]/input    ${pw}
    Sel.Click Element    //*[@id="passwordNext"]/content
    sleep    3
    Wait Until Element Contains    xpath=//*[@id="yDmH0d"]/div[2]/c-wiz/div/div/div[5]/div[1]/content/div/h1    내 계정

Login2
    [Arguments]    ${id}    ${pw}
    Sel.Open Browser    http://www.google.com    chrome
    sel.click element    xpath=//*[@id="gb_70"]    #로그인버튼
    Sel.Input Text    xpath=/html/body/div[1]/div[1]/div[2]/div[2]/form/div[2]/div/div[1]/div[1]/div/div[1]/div/div[1]/input    ${id}
    Sel.Click Element    //*[@id="identifierNext"]/content
    sleep    3
    Sel.Input Text    xpath=//*[@id="password"]/div[1]/div/div[1]/input    ${pw}
    Sel.Click Element    //*[@id="passwordNext"]/content

Login3
    [Arguments]    ${id}    ${pw}
    Sel.Open Browser    http://www.google.com    chrome
    sel.click element    xpath=//*[@id="gb_70"]    #로그인버튼
    Sel.Input Text    xpath=/html/body/div[1]/div[1]/div[2]/div[2]/form/div[2]/div/div[1]/div[1]/div/div[1]/div/div[1]/input    ${id}
    AI.send    {ENTER}    #다음 버튼 클릭을 엔터키로 대체
    sleep    3
    Sel.Input Text    xpath=//*[@id="password"]/div[1]/div/div[1]/input    ${pw}
    AI.send    {ENTER}    #다음 버튼 클릭을 엔터키로 대체