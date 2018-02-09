*** Settings ***
Documentation     standard library example testsuite
Test Template
Test Timeout      1 hour 40 minutes 30 seconds
Resource          Ukey_Standard.robot

*** Variables ***

*** Test Cases ***    File               Extension                               Directory
Ex9_Example Template
                      [Documentation]    test
                      [Template]         There is file.ext file in dir folder
                      1                  txt                                     RF_Template
                      2                  docx                                    RF_Template
                      3                  xlsx                                    RF_Template
                      4                  png                                     RF_Template
                      5                  zip                                     RF_Template
                      6                  hwp                                     RF_Template
                      7                  py                                      RF_Template
                      8                  pyc                                     RF_Template
                      9                  ppt                                     RF_Template
                      10                 7zip                                    RF_Template
