*** Settings ***
Library           RemoteLibrary    http://${TARGET_IP}:8270    WITH NAME    Remote

*** Variables ***
${Target_IP}      127.0.0.1

*** Test Cases ***
File
    Remote.Create Directory    /tmp/keyword
