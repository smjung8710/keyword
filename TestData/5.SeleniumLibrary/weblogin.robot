*** Settings ***
Library             Selenium2Library      WITH NAME      Sel
Resource            ../Resource1.robot

*** Variables ***
${URL}              ${EMPTY}
${BROWSER}          ${EMPTY}

*** Test Cases ***
OpenBrowser
      [Setup]      SERVER START
      [Template]      OPEN BROWSER
      localhost:7272      ff
      localhost:7272      gc
      localhost:7272      ie

test
      SERVER START

*** Keywords ***
OPEN BROWSER
      [Arguments]      ${URL}      ${BROWSER}
      Sel.Open Browser      ${URL}      ${BROWSER}
      [Teardown]      Sel.Close Browser

AI.Run
      [Arguments]      ${arg1}

SERVER START
      OS.Run      E:\\KeywordAutomation\\TestTool\\4_2_SeleniumLibrary\\WebServer\\server.py
      Should Contain      cmd.exe      Demo Server
