# -*- coding: cp949 -*-
from pywinauto.application import Application

app = Application().start("notepad.exe")
app.menu_select("도움말->메모장정보")
app.AboutNotepad.OK.click()
