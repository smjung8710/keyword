*** Settings ***
Resource            ../Resource2.robot

*** Test Cases ***
Example Reg
      [Documentation]      테스트 타겟 플랫폼 정보 얻기
      ${arch}=      GET ARCH
      log      ${arch}
      ${key}=      Set Variable If      '${arch}'=='x64'      HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup      HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
      AI.Reg Write      ${key}      update      REG_DWORD      1
      ${check}      AI.Reg Read      ${key}      update
      Should Contain      ${check}      1
      Comment      AI.Reg Delete Val      ${key}      update

*** Keywords ***
