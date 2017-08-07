*** Settings ***
Library             AutoItLibrary      WITH NAME      AI      # 오토잇라이브러리
Library             OperatingSystem      WITH NAME      OS

*** Test Cases ***
계산기
      AI.send      \#r
      AI.Win Get Text      실행
      AI.send      calc
      AI.send      {enter}
      AI.Win Get Text      계산기
      Process Exists      calc.exe
      OS.run      calc.exe
