*** Settings ***
Library             AutoItLibrary      WITH NAME      AI      # 오토잇라이브러리
Library             OperatingSystem      WITH NAME      OS
Library             Collections
Library             DateTime
Library             Dialogs
Library             Process
Library             Screenshot
Library             string
Library             Telnet
Library             XML

*** Variables ***
${HOST}             9.9.9.9

*** Keywords ***
TS_SETUP
      log      1

TC_SETUP
      log      2

SETUP
      log      3

K_TEARDOWN
      log      4

TEARDOWN
      log      5

TC_TEARDOWN
      log      6

TS_TEARDOWN
      log      7
