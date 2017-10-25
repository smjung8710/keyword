*** Settings ***
Library             OperatingSystem      WITH NAME      OS

*** Variables ***
${IP}               ${EMPTY}
${ID}               ${EMPTY}
${PWD}              ${EMPTY}

*** Keywords ***
There is file.ext file in dir folder
      [Arguments]      ${file}      ${ext}      ${dir}
      ${ret}=      Run Keyword And Return Status      OS.Directory Should Exist      C:\\${dir}
      Run Keyword If      '${ret}'=='False'      OS.Create Directory      C:\\${dir}
      OS.Directory Should Exist      C:\\${dir}      No Directory
      OS.Create File      C:\\${dir}\\${file}.${ext}
      OS.File Should Exist      C:\\${dir}\\${file}.${ext}      No Files

Connect Share Folder
      [Arguments]      ${ip}      ${id}      ${pwd}
      : FOR      ${count}      IN RANGE      5
      \      ${output}      OS.Run And Return Rc      net use \\\\${IP} /user:${ID} ${PWD} /PERSISTENT:YES
      \      Exit For Loop If      '${output}' == '0'
      \      log      count:${count}
      \      Sleep      0.5s
      \      OS.Run      net use * /delete /yes
      [Return]      ${output}

Count Files
      [Arguments]      ${dir_path}
      ${count}=      OS.Count Files In Directory      ${dir_path}
      [Return]      ${count}

Connect Share Folder Simple
      [Arguments]      ${ip}      ${id}      ${pwd}
      : FOR      ${count}      IN RANGE      5
      \      ${output}      OS.Run And Return Rc      net use \\\\${IP} /user:${ID} ${PWD} /PERSISTENT:YES
      \      Exit For Loop If      '${output}' == '0'
      \      log      count:${count}
      \      Sleep      0.5s
      \      OS.Run      net use * /delete /yes
      [Return]      ${output}
