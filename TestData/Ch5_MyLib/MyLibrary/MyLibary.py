#!/usr/bin/python
# -*- coding: cp949 -*-


import platform
import os, sys, random
import csv
from selenium import webdriver
from bs4 import BeautifulSoup
from selenium.webdriver.common.keys import Keys

import autoit

import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')

class MyLibrary(object):

    def Change_blank_to_underbar(self,path):
        #변경할 디렉토리를 받아온다.
        FileList = os.listdir(path)
        for files in FileList:
            #빈칸인경우에 언더바로 교체한다
            if ' ' in files:
                NewName = files.replace(" ", "_")
                os.rename(os.path.join(path, files), os.path.join(path, NewName))

    def Change_under_to_blank(self,path):
        #변경할 디렉토리를 받아온다.
        FileList = os.listdir(path)
        for files in FileList:
            #빈칸인경우에 언더바로 교체한다
            if '_' in files:
                NewName = files.replace("_", " ")
                os.rename(os.path.join(path, files), os.path.join(path, NewName))
            
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

    def Chrome_web(self,url):
        Chrome = webdriver.Chrome()
        Chrome.get(url)
        Chrome.implicitly_wait(3)  # wait 3 sec

        html = Chrome.page_source
        soup = BeautifulSoup(html, 'html.parser')
        notices = soup.select('body > table > tbody > tr:nth-child(4) > td:nth-child(2) > a')

        for n in notices:
            print(n.text.strip())

        # setup Driver|Chrome : 크롬드라이버를 사용하는 driver 생성
        driver = webdriver.Chrome()
        driver.implicitly_wait(3)  # 암묵적으로 웹 자원을 (최대) 3초 기다리기
        # Login
        driver.get('https://nid.naver.com/nidlogin.login')  # 네이버 로그인 URL로 이동하기
        driver.find_element_by_name('id').send_keys('id')  # 값 입력
        driver.find_element_by_name('pw').send_keys('pw')
        driver.find_element_by_xpath('//*[@id="frmNIDLogin"]/fieldset/input').click()  # 버튼클릭하기
        driver.implicitly_wait(3)
        driver.find_element_by_xpath('//*[@id="frmNIDLogin"]/fieldset/span[2]/a').click()

        driver.get('https://order.pay.naver.com/home')  # Naver 페이 들어가기
        html = driver.page_source  # 페이지의 elements모두 가져오기
        soup = BeautifulSoup(html, 'html.parser')  # BeautifulSoup사용하기
        notices = soup.select('div.p_inr > div.p_info > a > span')

        for n in notices:
            print(n.text.strip())

    def OpenLoginPageChrome(self, id, pw):
        chrome = webdriver.Chrome()
        chrome.get("localhost:7272")
        # login id
        login = chrome.find_element_by_xpath("//*[@id='username_field']")
        login.send_keys(id)
        # login pw
        login = chrome.find_element_by_xpath("//*[@id='password_field']")
        login.send_keys(pw, Keys.ENTER)
        chrome.quit()

    def OpenLoginPageChrome2(self, id, pw):
        chrome = webdriver.Chrome()
        chrome.get("localhost:7272")
        loginid = chrome.find_element_by_id("username_field")
        loginid.send_keys(id)
        # login pw
        loginpw = chrome.find_element_by_id("password_field")
        loginpw.send_keys(pw)
        loginbutton = chrome.find_element_by_id("login_button")
        loginbutton.send_keys(Keys.ENTER)
        chrome.quit()
		
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

		
if __name__ == "__main__":
    test=MyLibrary()
    print(test.Get_ARCH())
    #test.Change_blank_to_underbar(r"C:\Users\automation\test")
    print(test.readcsv('example.csv'))
	
    test.OpenLoginPageChrome2('demo','mode')

    
