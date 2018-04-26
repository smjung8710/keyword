# -*- coding: utf-8 -*-
#!/usr/bin/env python


import platform
import os, sys, random
import csv
import pywinauto
import requests
import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')

class MyWinLibrary(object):

    def Change_blank_to_underbar(self,path):
        '''
        [os 모듈실습]
        폴더의 파일이름에 빈칸을 언더바로 바꿔줍니다.
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
        [os 모듈실습]
        폴더의 파일이름을 언더바를 빈칸으로 바꿔줍니다.
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

    def Get_Platform_Info(self):
        '''
        [platform 모듈실습]
        유저키워드 Get_Platform_Info를 함수로 만든 키워드입니다.
        출력값은 x86이나 x64로 표시됩니다.
        '''
        machine=platform.machine()
        if machine == "AMD64":
            machine = 'x64'
        else:
            machine = 'x86'
        return machine

    def FileMaker(self, path, count, ext):
        '''
        [open 내장함수 실습]
        폴더의 위치와 갯수 확장자를 지정하면 파일을 만들어 줍니다.
        '''
        #os.mkdir(path)
        for i in range (1,count):
            f=random.random()
            filename= file is f.join(ext)
            #csvtest = open(r"path\filename",'w')
            
            csvtest = open(r"c:\users\automation\test\filename", 'w')
            csvtest.close()


    def ReadCSV(self,file):
        '''
        [csv 모듈 실습]
        csv 라이브러리
        '''
        with open(file) as filename:
            csvfile=csv.reader(filename)
            csvData=list(csvfile)
        return csvData

    def Check_year_temperature (self,url):
        response = requests.get(url)
        if response.status_code != 200:
            raise AssertionError('Failed to get data:', response.status_code)
        else:
            wrapper = csv.reader(response.text.strip().split('\n'))

        for record in wrapper:
            year = int(record[0])
            value = float(record[1])
            print(year, value)

        return year, value


if __name__ == "__main__":
    test=MyWinLibrary()
    #print(test.Get_Platform_Info())   #Get_Platform_Info 테스트
    #folder=r"C:\Users\automation\test3"
    test.FileMaker("c:\\users\\automation\\test1",20,str(csv))
    #test.Change_blank_to_underbar(folder)
    #print(test.readcsv('example.csv'))
