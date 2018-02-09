*** Settings ***
Force Tags        builtin
Resource          ../../common.robot

*** Test Cases ***
Ex12_Example Evaluate
    ${count}=    Set Variable    99
    ${count}=    Evaluate    ${count}-1
    Should Be Equal As Numbers    ${count}    98

Ex13_Example Call Method
    Call Method    ${hashtable}    put    myname myvalue
    ${isempty} =    Call Method    ${hashtable}    isEmpty
    Should Not Be True    ${isempty}
