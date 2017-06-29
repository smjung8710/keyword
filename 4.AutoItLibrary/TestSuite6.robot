*** Settings ***
Resource            ../Resource1.robot

*** Test Cases ***
Example Reg
      [Documentation]      테스트 타겟 플랫폼 정보 얻기
      ${arch}=      GET ARCH
      ${key}=      Set Variable If      '${arch}'=='x64'      HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup      HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
      AI.Reg Write      ${key}      update      REG_DWORD      0
      ${check}      AI.Reg Read      ${key}      update
      Should Contain      ${check}      0

test
      Comment      ${key}=      Set Variable      HKEY_CURRENT_USER\\SOFTWARE\\Ahnlab\\AhnReport\\7
      ${key}=      Set Variable      HKEY_CURRENT_USER\\Software\\Python 2.7\\Python for Win32
      ${value}      AI.Reg Write      ${key}      update      REG_DWORD      0
      ${keya}      AI.Reg Read      ${key}      update
      Should Contain      ${keya}      0

*** Keywords ***
GET ARCH
      [Documentation]      Reg Read 키워드를 이용하여 \ 테스트 타겟 플랫폼 정보 얻기
      ${key}=      Set Variable      HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\Environment
      ${arch}      AI.Reg Read      ${key}      PROCESSOR_ARCHITECTURE
      ${first}      ${second}      Run Keyword And Ignore Error      Should Contain      ${arch}      x86
      ${arch}      Set Variable If      '${first}' == 'PASS'      x86      x64
      [Return]      ${arch}
