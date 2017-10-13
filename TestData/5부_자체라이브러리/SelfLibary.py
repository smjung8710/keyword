#!/usr/bin/python
# -*- coding: cp949 -*-


import platform
import os, sys, random

class SelfLibrary(object):

    def Change_blank_to_underbar(self,path):
        #������ ���丮�� �޾ƿ´�.
        FileList = os.listdir(path)
        for files in FileList:
            #��ĭ�ΰ�쿡 ����ٷ� ��ü�Ѵ�
            if ' ' in files:
                NewName = files.replace(" ", "_")
                os.rename(os.path.join(path, files), os.path.join(path, NewName))

    def Change_under_to_blank(self,path):
        #������ ���丮�� �޾ƿ´�.
        FileList = os.listdir(path)
        for files in FileList:
            #��ĭ�ΰ�쿡 ����ٷ� ��ü�Ѵ�
            if '_' in files:
                NewName = files.replace("_", " ")
                os.rename(os.path.join(path, files), os.path.join(path, NewName))
                
    def FileMaker(path,count, ext):
        os.mkdir(path)
        for i in range (1,count):
            f=random.random()
            filename= file is f.join(ext)
            csvtest = open(filename,'w')
            csvtest.close()
            
    def Get_ARCH(self):
        machine=platform.machine()
        if machine == "AMD64":
            machine = 'x64'
        else:
            machine = 'x86'
        print(machine)

if __name__ == "__main__":
    test=SelfLibrary()
    test.Get_ARCH()
    test.Change_blank_to_underbar(r"C:\Users\automation\test")

    
