*** Settings ***
Library           DiffLibrary    WITH NAME    Diff
Library           OperatingSystem    WITH NAME    OS

*** Test Cases ***
Ex21_Example Diff Files
    OS.Create File    C:\\Files1.txt    this is file management
    OS.Create File    C:\\Files2.txt    this is file management test
    Comment    ${ret1}=    Diff.Diff Files    C:\\Files1.txt    C:\\Files2.txt    fail=TRUE    #같으면 PASS
    ${ret2}=    Diff.Diff Files    C:\\Files1.txt    C:\\Files2.txt    fail=FALSE    #같으면 PASS

Ex21_Example Diff Outputs
    OS.Create File    C:\\Files3.txt    this is file management
    OS.Create File    C:\\Fi${retles4.txt    this is file management
    Diff.Diff Outputs    C:\\Files3.txt    C:\\Files4.txt    fail=TRUE    #같으면 PASS

Ex22_Example Diff Files2
    OS.Create File    D:\\Files.txt    this is file management
    OS.Create File    D:\\Files2.txt    this is file management
    OS.Create File    D:\\Files3.txt    this is not file management
    Run Keyword And Expect Error    differences*    Diff.Diff Files    D:\\Files.txt    D:\\Files3.txt
    Run Keyword And Expect Error    *doesn’t*    Diff.Diff Files    D:\\Files.txt    D:\\Files4.txt

Ex23_Example
    OS.Create File    C:\\Files3.txt    this is file management
    OS.Create File    C:\\Files4.txt    this is file management
    ${ret}=    Run Keyword And Return Status    Diff.Diff Files    C:\\Files.txt    C:\\Files2.txt
    Run Keyword If    '${ret}'=='TRUE'    Diff.Diff Outputs    C:\\Files.txt    C:\\Files2.txt
