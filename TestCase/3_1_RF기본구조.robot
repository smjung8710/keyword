*** Settings ***
Suite Setup       테스트스윗_SETUP
Suite Teardown    테스트스윗_TEARDOWN
Test Setup        테스트스윗_하위의_테스트케이스_SETUP
Test Teardown     테스트스윗_하위의_테스트케이스_TEARDOWN
Resource          Resource/common.robot

*** Variables ***
${이름}             robot    # Scalar Variable Example
${암호}             secret    # Scalar Variable Example

*** Test Cases ***
TC1_RF_테스트스윗픽스쳐
    [Tags]    structure
    Log    테스트 스윗설정만 실행    console=true

TC2_RF_변수
    [Tags]    structure
    Log many    사용자 이름변수는 ${이름}    사용자 암호는 ${암호}
    Log To Console    사용자 이름변수는 ${이름}
    Log To Console    사용자 암호는 ${암호}

TC3_RF_사용자키워드
    [Tags]    structure
    사용자키워드    #Call User keyword

TC4_RF_테스트케이스픽스쳐
    [Tags]    structure
    [Setup]    테스트케이스_SETUP
    log    테스트 케이스 픽스처 예시 테스트 케이스    console=true
    [Teardown]    테스트케이스_TEARDOWN

*** Keywords ***
사용자키워드
    Log many    사용자 키워드입니다.    사용자이름은 ${이름} 입니다.
    Log To Console    사용자 키워드입니다.
    Log To Console    사용자이름은 ${이름} 입니다.
    [Teardown]    사용자키워드_TEARDOWN

테스트스윗_SETUP
    log    1.테스트스윗_SETUP    console=true

테스트스윗_하위의_테스트케이스_SETUP
    log    2.테스트스윗_하위의_테스트케이스_SETUP    console=true

테스트케이스_SETUP
    log    3.예시_SETUP    console=true

사용자키워드_TEARDOWN
    log    4.사용자키워드 Teardown    console=true

테스트케이스_TEARDOWN
    log    5.예시_TEARDOWN    console=true

테스트스윗_하위의_테스트케이스_TEARDOWN
    log    6.테스트스윗_하위의_테스트케이스_TEARDOWN    console=true

테스트스윗_TEARDOWN
    log    7.테스트스윗_TEARDOWN    console=true
