*** Settings ***
Resource            resource.robot

*** Test Cases ***
ReadReg
      [Documentation]      테스트 타겟 플랫폼 정보 얻기
      ${arch}=      GET ARCH
      log      ${arch}
      ${key}=      Set Variable If      '${arch}'=='x64'      HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup      HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
      AI.Reg Write      ${key}      update      REG_DWORD      1
      ${check}      AI.Reg Read      ${key}      update
      Should Contain      ${check}      1
      Comment      AI.Reg Delete Val      ${key}      update

DeleteReg
      [Documentation]      레지스트리 키 삭제 테스트 케이스
      ...
      ...      추가한 레지스트리는 테스트 완료후 삭제해야 다음 테스트에 영향을 주지 않으므로 삭제하는 키워드를 만들어 teardown에 사용한다.
      DeleteReg

*** Keywords ***
DeleteReg
      ${arch}=      GET ARCH
      log      ${arch}
      ${key}=      Set Variable If      '${arch}'=='x64'      HKEY_CURRENT_USER\\Software\\Wow6432Node\\Microsoft\\Active Setup      HKEY_CURRENT_USER\\Software\\Microsoft\\Active Setup
      AI.Reg Delete Val      ${key}      update
