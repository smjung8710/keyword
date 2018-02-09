*** Settings ***
Resource          ../../common.robot

*** Test Cases ***
Ex20_Example_Keyboard
    AI.Win Minimize All
    sleep    3
    AI.send    \#r
    ${ret}=    AI.Win Get Title    실행
    Should Contain    ${ret}    실행
    AI.send    calc
    AI.send    {enter}
    AI.Process Exists    calc.exe
    sleep    3
    AI.Process Close    calc.exe

Ex20_Example_Run
    AI.run    calc.exe
    AI.Process Exists    calc.exe
    sleep    3
    AI.Process Close    calc.exe
