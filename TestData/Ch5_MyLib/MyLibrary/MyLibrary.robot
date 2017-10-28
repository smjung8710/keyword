*** Settings ***
Library           AutoItLibrary    WITH NAME    AI    # 오토잇라이브러리
Library           OperatingSystem    WITH NAME    OS
Library           Selenium2Library    WITH NAME    Selenium
Library           AppiumLibrary    WITH NAME    APP
Library           SSHLibrary    WITH NAME    ssh
Library           Collections
Library           DateTime
Library           Dialogs
Library           Process
Library           Screenshot
Library           string
Library           Telnet
Library           XML
Library           CalculatorLibrary.py    WITH NAME    Cal
Library           MyWinLibrary.py    WITH NAME    my

*** Variables ***
${HOST}           9.9.9.9

*** Keywords ***
Wait Until Page Loaded
    [Documentation]    *bold* bold
    ...    _italic_ italic
    ...    _*bold italic*_ bold italic
    ...    ``code`` code
    ...    *bold*, then _italic_ and finally ``some code`` bold, then italic and finally some code
    ...    This is *bold
    ...
    ...    on multiple
    ...
    ...    lines*. This is bold
    ...    on multiple
    ...    lines.
    Wait For Condition    return jQuery.active === 0    10s    jQuery active state is not 0 within 10 sec
    Wait For Condition    return window.document.readyState === "complete"    10s    document ready state with in 10sec
