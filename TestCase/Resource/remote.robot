*** Settings ***
Documentation     리소스 파일은 재사용 가능한 키워드와 변수로 구성합니다.
...               셀레니움 라이브러리에서 제공하는 키워드를 이용하여 웹 서버에 맞게
...               유저 키워드로 재구성하였습니다.
Library           Remote    http://${ADDRESS}:${PORT}    WITH NAME    Remote
Library           Remote    http://${ADDRESS}:8271    WITH NAME    AI    # AutoitLibrary
Library           Remote    http://${ADDRESS}:8273    WITH NAME    Sel    # Selenium2Library
Resource          common.robot

*** Variables ***
${ADDRESS}        127.0.0.1
${PORT}           8270
