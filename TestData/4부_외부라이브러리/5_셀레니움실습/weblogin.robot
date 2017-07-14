*** Settings ***
Library             Selenium2Library      WITH NAME      Sel

*** Variables ***
${URL}              ${EMPTY}
${BROWSER}          ${EMPTY}
${DELAY}            5

*** Test Cases ***
OpenBrowser
      [Setup]
      [Template]
      OPEN BROWSER      https://translate.google.co.kr/      ff
      Sel.Input Text      id=source      Hello
      Sel.Element Text Should Be      //span[@id='result_box']/span[1]      안녕하세요
      [Teardown]      Sel.Close Browser

*** Keywords ***
OPEN BROWSER
      [Arguments]      ${URL}      ${BROWSER}
      Sel.Open Browser      ${URL}      ${BROWSER}
      Sel.Maximize Browser Window
      Sel.Set Selenium Speed      ${DELAY}
      Sel.Title Should Be      Google 번역
      [Teardown]

AI.Run
      [Arguments]      ${arg1}

SERVER START
      ${ret}      OS.Run And Return Rc      E:\\KeywordAutomation\\TestData\\5.SeleniumLibrary\\server.bat
      Should Be Equal      ${ret}      0
