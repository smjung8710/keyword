# -*- coding: cp949 -*-
from pywinauto.application import Application

app = Application().start("notepad.exe")
app.menu_select("����->�޸�������")
app.AboutNotepad.OK.click()
