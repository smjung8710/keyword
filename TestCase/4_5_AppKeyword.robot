*** Settings ***
Documentation     demo for appium library
Test Setup
Test Teardown     # Close Application
Resource          Resource/common.robot

*** Variables ***
${APP}            Microsoft.WindowsCalculator_8wekyb3d8bbwe!App
${DEVICE}         ${EMPTY}

*** Test Cases ***
TC54_APP_Open
    Set Global Variable    ${APP}    C:\\demoapp\\OrangeDemoApp.apk
    Set Global Variable    ${DEVICE}    ce021602ccaa863902
    APP.Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${DEVICE}    platformVersion=6    app=${APP}    automationName=Appium
    ...    appPackage=com.netease.qa.orangedemo    appActivity=MainActivity
    APP.Page Should Contain Text    Orange_Demo
    APP.Capture Page Screenshot    demo.png
    APP.Close Application

TC55_APP_View
    [Setup]    orangeapp
    APP.Click Text    ViewTest
    App.Wait Until Page Contains    View
    APP.Click Element    id=com.netease.qa.orangedemo:id/textView1    #TextView
    [Teardown]    APP.Close Application

TC56_APP_Text
    [Setup]    orangeapp
    APP.Click Text    EditTextTest
    APP.Page Should Contain Text    EditText
    App.Input Text    id=com.netease.qa.orangedemo:id/edittext1    keyword automation
    APP.Element Should Contain Text    id=com.netease.qa.orangedemo:id/edittext1    keyword automation
    App.Go Back    #키보드 내림
    App.Go Back    #이전화면으로 이동
    APP.Page Should Contain Text    Orange_Demo
    [Teardown]    APP.Close Application

TC57_APP_ContactManagerApp
    Set Global Variable    ${APP}    C:\\demoapp\\ContactManager.apk
    Set Global Variable    ${DEVICE}    ce021602ccaa863902
    APP.Open Application    http://127.0.0.1:4723/wd/hub    platformName=Android    deviceName=${DEVICE}    platformVersion=6    app=${APP}    automationName=Appium
    ...    appPackage=com.example.android.contactmanager
    APP.Page Should Contain Text    Contact Manager
    AddContact    Appium User    someone@appium.io    5555555555
    AddContact_id    Keyword User    keyword@automation.com    0312223333
    APP.Click Text    Show Invisible Contacts (Only)
    APP.Page Should Contain Text    Appium User
    APP.Close Application

TC58_APP_CheckDial
    Set Global Variable    ${APP}    C:\\demoapp\\ContactManager.apk
    Set Global Variable    ${DEVICE}    ce021602ccaa863902
    APP.Open Application    http://127.0.0.1:4723/wd/hub    platformName=Android    deviceName=${DEVICE}    platformVersion=6    app=${APP}    automationName=Appium
    ...    appPackage=com.example.android.contactmanager
    APP.Page Should Contain Text    Contact Manager
    AddContact    Robot Framework    rf@appium.io    010123456
    APP.Click Text    Show Invisible Contacts (Only)
    APP.Page Should Contain Text    Robot Framework
    APP.Close Application
    CheckDial
    APP.Page Should Contain Text    Framework, Robot
    Click Text    Framework, Robot
    App.Wait Until Page Contains    rf@appium.io
    APP.Capture Page Screenshot    dial.png
    APP.Close Application

*** Keywords ***
orangeapp
    ${app}    Set Variable    C:\\demoapp\\OrangeDemoApp.apk
    APP.Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=ce021602ccaa863902    platformVersion=6    app=${app}    automationName=Appium
    ...    appPackage=com.netease.qa.orangedemo    appActivity=MainActivity
    APP.Page Should Contain Text    Orange_Demo

AddContact
    [Arguments]    ${contact_name}    ${contact_phone}    ${contact_email}
    [Documentation]    input name, phone, email by xpath
    APP.Click Element    accessibility_id=Add Contact
    APP.Input Text    xpath=//android.widget.TableLayout[@index='0']/android.widget.TableRow[@index='3']/android.widget.EditText[@index='0']    ${contact_name}
    APP.Input Text    xpath=//android.widget.TableLayout[@index='0']/android.widget.TableRow[@index='5']/android.widget.EditText[@index='0']    ${contact_phone}
    APP.Input Text    xpath=//android.widget.TableLayout[@index='0']/android.widget.TableRow[@index='7']/android.widget.EditText[@index='0']    ${contact_email}
    APP.Click Element    accessibility_id=Save

AddContact_id
    [Arguments]    ${contact_name}    ${contact_phone}    ${contact_email}
    [Documentation]    input name, phone, email by id
    APP.Click Element    accessibility_id=Add Contact
    APP.Input Text    id=com.example.android.contactmanager:id/contactNameEditText    ${contact_name}
    APP.Input Text    id=com.example.android.contactmanager:id/contactPhoneEditText    ${contact_phone}
    APP.Input Text    id=com.example.android.contactmanager:id/contactEmailEditText    ${contact_email}
    APP.Click Element    accessibility_id=Save

CheckDial
    Set Global Variable    ${APP}    com.android.contacts
    Set Global Variable    ${DEVICE}    ce021602ccaa863902
    ${package}    Set Variable    com.android.contacts
    ${activity}    Set Variable    com.android.dialer.DialtactsActivity
    APP.Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${DEVICE}    platformVersion=6    app=${APP}    automationName=Appium
    ...    appPackage=${package}    appActivity=${activity}
