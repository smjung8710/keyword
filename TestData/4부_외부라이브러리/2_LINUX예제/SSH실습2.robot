*** Settings ***
Library                SSHLibrary	WITH NAME	ssh
Suite Setup            SSH ���� �α���
Suite Teardown         SSH ���� ����

*** Variables ***
${HOST}                localhost
${USERNAME}            root
${PASSWORD}            keyword

*** Test Cases ***
SSH �ǽ�2
    [Documentation]  Write Ű����, Read Until Ű���� �ǽ�.
    ssh.Write    cd ..
    ssh.Write    echo Hello keword automation
    ${output}=   ssh.Read Until    automation
    Should End With     ${output}   Hello keword automation

*** Keywords ***
SSH ���� �α���
   Open Connection    ${HOST}
   Login    ${USERNAME}    ${PASSWORD}

SSH ���� ����
   ssh.Close All Connections
