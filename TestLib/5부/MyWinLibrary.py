#!/usr/bin/python
# -*- coding: cp949 -*-


import platform
import os, sys, random
import csv
import pywinauto

import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')

class MyWinLibrary(object):

    def Change_blank_to_underbar(self,path):
        #변경할 디렉토리를 받아온다.
        FileList = os.listdir(path)
        print(FileList)
        for files in FileList:
            #빈칸인경우에 언더바로 교체한다
            if ' ' in files:
                NewName = files.replace(" ", "_")
                os.rename(os.path.join(path, files), os.path.join(path, NewName))
        FileList = os.listdir(path)
        print(FileList)

    def Change_under_to_blank(self,path):
        #변경할 디렉토리를 받아온다.
        FileList = os.listdir(path)
        print(FileList)
        for files in FileList:
            #빈칸인경우에 언더바로 교체한다
            if '_' in files:
                NewName = files.replace("_", " ")
                os.rename(os.path.join(path, files), os.path.join(path, NewName))
        print(FileList)
        
    def Get_ARCH(self):
	    # 머신 정보를 machine 변수에 선언
        machine=platform.machine()
		# 머신 정보를 x86, x64 로 구분하도록 정의 
        if machine == "AMD64":
            machine = 'x64'
        else:
            machine = 'x86'
        return machine

    def FileMaker(path, count, ext):
        os.mkdir(path)
        for i in range (1,count):
            f=random.random()
            filename= file is f.join(ext)
            csvtest = open(filename,'w')
            csvtest.close()

    def readcsv(self,file):
        with open(file) as filename:
            csvfile=csv.reader(filename)
            csvData=list(csvfile)
        return csvData


"""		
    def autoit(self):
	# ① 노트 패드 실행
	autoit.run("notepad.exe")
	# ② 노트패드 실행 확인 
	autoit.win_wait_active("[CLASS:Notepad]", 3)
	# ③ "hello world!" 입력
	autoit.control_send("[CLASS:Notepad]", "Edit1", "hello world{!}")
	# ④ 노트패드 종료
	autoit.win_close("[CLASS:Notepad]")
	# ⑤ 저장안함 버튼 클릭 
	autoit.control_click("[Class:#32770]", "Button2")

"""		
if __name__ == "__main__":
    test=MyWinLibrary()
    print(test.Get_ARCH())
    folder=r"C:\Users\automation\test"
    test.Change_blank_to_underbar(folder)
    #print(test.readcsv('example.csv'))	
    
