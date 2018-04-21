# -*- coding: utf-8 -*-
#!/usr/bin/env python


import platform
import os, sys, random
import csv
import pywinauto

import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')

class MyWinLibrary(object):

    def Change_blank_to_underbar(self,path):
        '''
        폴더의 파일이름에 빈칸을 언더바로 바꿔준다.
        '''
        logging.debug('Start of Change_blank_to_underbar')
        FileList = os.listdir(path)
        print(FileList)
        for files in FileList:
            if ' ' in files:
                NewName = files.replace(" ", "_")
                os.rename(os.path.join(path, files), os.path.join(path, NewName))
        FileList = os.listdir(path)
        print(FileList)

    def Change_under_to_blank(self,path):
        '''
        폴더의 파일이름을 언더바 를 빈칸으로 바꿔준다.
        '''
        logging.debug('Start of Change_under_to_blank')
        FileList = os.listdir(path)
        print(FileList)
        for files in FileList:
            if '_' in files:
                NewName = files.replace("_", " ")
                os.rename(os.path.join(path, files), os.path.join(path, NewName))
        FileList = os.listdir(path)
        print(FileList)

    def Get_ARCH(self):
	    # �ӽ� ������ machine ������ ����
        machine=platform.machine()
		# �ӽ� ������ x86, x64 �� �����ϵ��� ����
        if machine == "AMD64":
            machine = 'x64'
        else:
            machine = 'x86'
        return machine

    def FileMaker(self, path, count, ext):
        '''
        폴더의 위치와 갯수 확장자를 지정하면 파일을 만들어 줍니다.
        '''
        os.mkdir(path)
        for i in range (1,count):
            f=random.random()
            filename= file is f.join(ext)
            csvtest = open(filename,'w')
            #csvtest = open(r"c:\users\automation\test\file is %f".join(%ext), 'w')
            csvtest.close()


    def readcsv(self,file):
        ''' csv 라이브러리 
        '''
        with open(file) as filename:
            csvfile=csv.reader(filename)
            csvData=list(csvfile)
        return csvData


"""
    def autoit(self):
	# �� ��Ʈ �е� ����
	autoit.run("notepad.exe")
	# �� ��Ʈ�е� ���� Ȯ��
	autoit.win_wait_active("[CLASS:Notepad]", 3)
	# �� "hello world!" �Է�
	autoit.control_send("[CLASS:Notepad]", "Edit1", "hello world{!}")
	# �� ��Ʈ�е� ����
	autoit.win_close("[CLASS:Notepad]")
	# �� �������� ��ư Ŭ��
	autoit.control_click("[Class:#32770]", "Button2")

"""
if __name__ == "__main__":
    test=MyWinLibrary()
    print(test.Get_ARCH())
    folder=r"C:\Users\automation\test3"
    test.FileMaker(folder,20,str(csv))
    test.Change_blank_to_underbar(folder)
    print(test.readcsv('example.csv'))
