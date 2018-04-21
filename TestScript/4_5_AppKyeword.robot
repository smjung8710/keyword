*** Settings ***
Documentation     demo for appium library
Test Setup        Open Application    ${REMOTE_URL}    platformName=Windows    deviceName=WindowsPC    app=${APP}    automationName=appium
Test Teardown     Close Application
Library           AppiumLibrary    WITH NAME    APP

*** Variables ***
${REMOTE_URL}     http://localhost:4723/wd/hub
${APP}            Microsoft.WindowsCalculator_8wekyb3d8bbwe!App

*** Test Cases ***
TC42_OrangeDemoApp
    ${app}    Set Variable    C:\\demoapp\\OrangeDemoApp.apk
    APP.Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=358705080768726    platformVersion=4.4.2    app=${app}    automationName=Appium
    ...    appPackage=com.netease.qa.orangedemo    appActivity=MainActivity
    APP.Capture Page Screenshot    demo.png
    APP.Page Should Contain Text    Orange_Demo
    APP.Close Application

TC43_ContactManagerApp
    APP.Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=42f2df1e8dbc8fe7    platformVersion=4.4.2    app=C:\\Users\\automation\\keyword\\TestTool\\4_5_App\\demoapp\\ContactManager.apk    automationName=Appium
    ...    appPackage=com.example.android.contactmanager
    APP.Page Should Contain Text    Contact Manager
    add new contact    Appium User    someone@appium.io    5555555555
    APP.Click Text    Show Invisible Contacts (Only)
    APP.Page Should Contain Text    Appium User
    APP.Close Application

TC44_Caluator_Initialize
    [Documentation]    (based on https://github.com/appium/sample-code/blob/master/sample-code/examples/python/windows_calculatortest.py)
    #Make sure we're in standard mode
    Click Element    xpath=//Button[starts-with(@Name,'Menu')]
    Click Element    xpath=//ListItem[contains(@Name,'Standard Calculator')]
    Click Element    name=Clear
    Click Element    name=Seven
    Element Should Contain Text    accessibility_id=CalculatorResults    Display is 7
    Click Element    name=Clear

TC45_Caluator_Addition
    Capture Page Screenshot
    Click Element    name=One
    Click Element    name=Plus
    Click Element    name=Seven
    Click Element    name=Equals
    Get Text    accessibility_id=CalculatorResults
    Element Should Contain Text    accessibility_id=CalculatorResults    Display is 8
    Capture Page Screenshot

TC46_Caluator_Combination
    Click Element    name=Seven
    Click Element    name=Multiply by
    Click Element    name=Nine
    Click Element    name=Plus
    Click Element    name=One
    Click Element    name=Equals
    Click Element    name=Divide by
    Click Element    name=Eight
    Click Element    name=Equals
    Element Should Contain Text    accessibility_id=CalculatorResults    Display is 8
    Capture Page Screenshot

TC47_Caluator_Division
    Click Element    name=Eight
    Click Element    name=Eight
    Click Element    name=Divide by
    Click Element    name=One
    Click Element    name=One
    Click Element    name=Equals
    Element Should Contain Text    accessibility_id=CalculatorResults    Display is 8
    Capture Page Screenshot

TC48_Caluator_Multiplication
    Click Element    name=Nine
    Click Element    name=Multiply by
    Click Element    name=Nine
    Click Element    name=Equals
    Element Should Contain Text    accessibility_id=CalculatorResults    Display is 81
    Capture Page Screenshot

TC49_Caluator_Subtraction
    Click Element    name=Nine
    Click Element    name=Minus
    Click Element    name=One
    Click Element    name=Equals
    Element Should Contain Text    accessibility_id=CalculatorResults    Display is 8
    Capture Page Screenshot

*** Keywords ***
add new contact
    [Arguments]    ${contact_name}    ${contact_phone}    ${contact_email}
    [Documentation]    input name, phone, email
    APP.Click Element    accessibility_id=Add Contact
    APP.Input Text    xpath=//android.widget.TableLayout[@index='0']/android.widget.TableRow[@index='3']/android.widget.EditText[@index='0']    ${contact_name}
    APP.Input Text    xpath=//android.widget.TableLayout[@index='0']/android.widget.TableRow[@index='5']/android.widget.EditText[@index='0']    ${contact_phone}
    APP.Input Text    xpath=//android.widget.TableLayout[@index='0']/android.widget.TableRow[@index='7']/android.widget.EditText[@index='0']    ${contact_email}
    APP.Click Element    accessibility_id=Save
