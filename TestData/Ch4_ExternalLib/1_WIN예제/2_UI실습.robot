*** Settings ***
Library           AutoItLibrary    WITH NAME    AI
Library           OperatingSystem    WITH NAME    OS

*** Test Cases ***
104_계산기실행
    AI.Win Minimize All
    sleep    3
    AI.send    \#r
    AI.Win Get Text    실행
    AI.send    calc
    AI.send    {enter}
    AI.Win Get Text    계산기
    AI.Process Exists    calc.exe
    sleep    3
    AI.Process Close    calc.exe

105_계산기실행
    AI.run    calc.exe
    AI.Process Exists    calc.exe
    sleep    3
    AI.Process Close    calc.exe
