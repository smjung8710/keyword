*** Settings ***
Library           OperatingSystem    WITH NAME    OS
Library           RemoteLibrary    http://${TARGET_IP}:8270    WITH NAME    STD

*** Variables ***
${TARGET_IP}      10.2.6.104

*** Keywords ***
