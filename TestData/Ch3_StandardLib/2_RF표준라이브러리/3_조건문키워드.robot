*** Test Cases ***
Example Condition
      ${condition}=      Set Variable      no
      ${input}=      Dialogs.Get Value From User      yes, no를 선택해주세요
      Run Keyword If      '${condition}'=='${input}'      Dialogs.Pause Execution
      Run Keyword Unless      '${condition}'=='${input}'      Dialogs.Get Selection From User      user1      user2      user3
