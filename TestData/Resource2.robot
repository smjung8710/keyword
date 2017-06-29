*** Settings ***
Library             Remote      http://${TARGET_IP}:8270      WITH NAME      STD
Library             Remote      http://${TARGET_IP}:8271      WITH NAME      AI

*** Variables ***
${TARGET_IP}        127.0.0.1

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
