*** Settings ***
Library           Selenium2Library    WITH NAME    Sel
Library           AutoItLibrary    WITH NAME    AI
Library           ../../../../Python27/Lib/site-packages/test.py

*** Test Cases ***
update
    [Setup]    ConnectMDS
    click element    //*[@id="gnbMenu08"]/a
    click element    //*[@id="ui-accordion-1-header-6"]
    click element    //*[@id="ui-accordion-1-panel-6"]/li/a
    Should Contain

autoit
    AI.RUN    notepad.exe    Hello World!
    AI.Process Exists    notepad.exe
    sleep    3
    AI.Send    Hello World!
    AI.Win Exists    메모장
    AI.Win Set Trans

test
    My Logger Keyword    test

*** Keywords ***
ConnectMDS
    Open Browser    https://192.168.54.203:59005    gc
    Input Text    //*[@id="userId"]    manager
    Input Text    password    qwe123!!@@
    Click Element    //*[@id="login_btn"]
