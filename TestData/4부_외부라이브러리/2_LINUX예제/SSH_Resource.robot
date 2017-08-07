*** Settings ***
Library             SSHLibrary      WITH NAME      ssh
Library             RemoteLibrary      http://${TARGET_IP}:8270      WITH NAME      Remote

*** Variables ***
${Target_IP}        127.0.0.1
