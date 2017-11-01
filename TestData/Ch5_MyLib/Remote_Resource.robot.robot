*** Settings ***
Library           Remote    http://${TARGET_IP}:8270    WITH NAME    STD
Library           Remote    http://${TARGET_IP}:8271    WITH NAME    AI

*** Variables ***
${TARGET_IP}      127.0.0.1

*** Keywords ***
