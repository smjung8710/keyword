*** Settings ***
Library             AutoItLibrary      WITH NAME      AI      # 오토잇라이브러리

*** Keywords ***
GET ARCH
      [Documentation]      Reg Read 키워드를 이용하여 \ 테스트 타겟 플랫폼 정보 얻기
      ...
      ...      HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
      ${key}=      Set Variable      HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
      ${arch}      AI.Reg Read      ${key}      PROCESSOR_ARCHITECTURE
      ${first}      ${second}      Run Keyword And Ignore Error      Should Contain      ${arch}      x86
      ${arch}      Set Variable If      '${first}' == 'PASS'      x86      x64
      [Return]      ${arch}
