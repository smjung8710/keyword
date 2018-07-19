# -*- coding: utf-8 -*-
#MyWebLibrary.py

import os, sys, random
import platform
import csv

#for web browser test
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup as bs
import requests

#for email test
import smtplib
from email.mime.text import MIMEText
from email.mime import base
from email.mime import multipart

from robot.api import ExecutionResult
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')


class MyLibrary(object):

    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'
    def OpenLoginPageChrome (self, id, pw):
        '''
        [selenium 실습] 4장 4절 셀레니움 실습
        id 엘리멘트를 이용한 테스트 웹서버 로그인
        '''
        chrome = webdriver.Chrome()
        chrome.get("localhost:7272")
        loginid = chrome.find_element_by_id("username_field")
        loginid.send_keys(id)
        #login pw
        loginpw = chrome.find_element_by_id("password_field")
        loginpw.send_keys(pw)
        loginbutton = chrome.find_element_by_id("login_button")
        loginbutton.send_keys(Keys.ENTER)
        chrome.quit()

    def OpenLoginPageChrome_ByXpath(self, id, pw):
        '''
        [selenium 실습] 4장 4절 셀레니움 실습
        xpath 엘리멘트를 이용한 테스트 웹서버 로그인
        '''
        chrome = webdriver.Chrome()
        chrome.get("localhost:7272")
        chrome.implicitly_wait(30)
        # login id
        loginid = chrome.find_element_by_xpath("//*[@id='username_field']")
        loginid.send_keys(id)
        # login pw
        loginpw = chrome.find_element_by_xpath("//*[@id='password_field']")
        loginpw.send_keys(pw, Keys.ENTER)
        chrome.quit()


    def Change_blank_to_underbar(self,path):
        '''
        [os 모듈실습] 6장 3절 기본모듈 실습
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
        [platform 모듈실습] 6장 3.1.2 실습
        유저키워드 Get_Platform_Info를 함수로 만든 키워드입니다.
        출력값은 x86이나 x64로 표시됩니다.
        '''
        machine=platform.machine()
        if machine == "AMD64":
            machine = 'x64'
        else:
            machine = 'x86'
        return machine

    def soup_file(self, file):
        '''
        [BeautifulSoup 실습]6장 3.2.1 실습
        웹 페이지 파일 file을 이용한 파싱 키워드
        '''
        with open(file) as page:
            soup= BeautifulSoup(page,'html.parser')
            print(soup.prettify())

    def soup_tag(self, file):
        '''
        [BeautifulSoup 실습] 6장 3.2.1 실습
        파일을 이용하여 태그를 이용한 페이지 상세 파싱 키워드
        '''
        with open(file) as page:
            soup= BeautifulSoup(page,'html.parser')

        #print(soup.head)
        #print(soup.title)
        #print(soup.link)
        #print(soup.script)
        #print(soup.body)
        #print(soup.body.div)
        #print(soup.body.h1)
        #print(soup.body.p)
        print(soup.body.div.table) #.prettify())
        #print(soup.body.form)
        return soup

    def soup_url(self,url):
        '''
        [BeautifulSoup 실습] 6장 3.2.1 실습
        웹 페이지 주소 url를 이용한 파싱 키워드
        '''
        res=requests.get(url)
        res.raise_for_status()
        soup= BeautifulSoup(res.text, 'html.parser')
        print(soup)

    def request_status(self,url):
        '''
        [requests 실습] 6장 3.2.2.requeset 실습
        request status 상태값 알아오기
        '''
        res=requests.get(url)
        code=res.status_code
        print(code)

    def check_title(self, path, expected):
         '''
         [BeautifulSoup 실습] 6장 3.2.2 실습
         웹페이지 파일(url, file)에서 타이틀 확인 키워드
         '''
         if "http" in path:
              res=requests.get(path)
              res.raise_for_status()
              soup= BeautifulSoup(res.text, 'html.parser')
              title=str(soup.title)
              if expected in title:
                  print "Pass URL"
                  return True
              else:
                  raise AssertionError("Fail URL. There is no title")

         else:
             with open(path) as page:
                 soup= BeautifulSoup(page,'html.parser')
             title=str(soup.title)
             if expected in title:
                 print "Pass FILE"
                 return True
             else:
                 raise AssertionError("Fail FAIL. There is no title")

    def FileMaker(self, path, ext, count):
        '''
        [open 내장함수 실습]
        폴더의 위치와 갯수 확장자를 지정하면 파일을 만들어 줍니다.
        path: 파일 생성 위치
        ext : 확장자명
        count : 파일 생성  갯수
        '''
        if not os.path.exists(path):
            os.makedirs(path)

        for i in range(int(count)):
            filename =str(i)+'.'+str(ext)
            f=open(os.path.join(path, filename), 'wb')
        f.close()

    def CSVFileMaker(self, path, count):
        '''
        [csv write, read 함수 실습]
        csv dialect 이용하여 파일 생성 기술을 익힙니다.
        path: 파일 생성 위치
        count : 파일 생성  갯수
        '''
        if not os.path.exists(path):
            os.makedirs(path)

        for i in range(int(count)):
            filename =str(i)+'.csv'
            with open(os.path.join(path, filename), 'wb') as f:
                wr = csv.writer(f)
                wr.writerow(['1Spam'] * 5 + ['Baked Beans'])
                wr.writerow(['2Spam', 'Lovely Spam', 'Wonderful Spam'])
                writer = csv.writer(f, delimiter=' ',quotechar='|', quoting=csv.QUOTE_MINIMAL)
                writer.writerow(['3Spam'] * 5 + ['Baked Beans'])
                writer.writerow(['4Spam', 'Lovely Spam', 'Wonderful Spam'])

    def CSVFileReader(self,path):
        '''
        [csv 모듈 실습]
        csv 라이브러리
        '''
        with open(path, 'rb') as f:
            rd=csv.reader(f, delimiter=' ', quotechar='|')
            for row in rd:
                csvData=list(rd)
            return csvData


    def Collect_Issue (self,url):
        '''
        request, bs4, csv.writer 이용 실습
        RF 이슈 등록 페이지를 읽어와서 csv 파일로 저장
        '''
        #RF 이슈 등록 페이지
        url=r'https://github.com/robotframework/robotframework/issues'
        res=requests.get(url)
        res.raise_for_status()
        soup= bs(res.text, 'html.parser')

        #이슈 클래스로 크롤링
        issues = soup.findAll(class_='link-gray-dark v-align-middle no-underline h4 js-navigation-open')
        with open("c:\\users\\automation\\issues.csv","wb") as f:
            writer = csv.writer(f, delimiter=' ', quotechar='|', quoting=csv.QUOTE_MINIMAL)
            for i in range(len(issues)):
                issue = issues[i].getText()
                writer.writerow(issue)

    def Read_Issue (self, path):
        '''
        csv reader 실습
        '''
        with open(path,"rb") as f:
            reader = csv.reader(f)
            csvDatae = list(reader)
            return csvDatae


    def send_mail_smtp(self,from_addr,from_password,to_addr, subject, text):
        '''
        [smtplib 실습]6장 3.4.2 실습
        gmail 서버에서 이메일을 발신하는 실습
        다른 서버에서 발신을 원할 경우 SMTP 정보 변경 필요
        '''

        #서버정보
        SMTPServer = smtplib.SMTP('smtp.gmail.com', 587)
        SMTPServer.ehlo()
        SMTPServer.starttls()
        SMTPServer.login(from_addr,from_password)

        #이메일 내용
        SMTPMessage = MIMEText(text)
        SMTPMessage ['Subject'] = subject
        SMTPMessage ['To'] = to_addr

        #메일전송
        SMTPServer.sendmail(from_addr, to_addr, SMTPMessage.as_string())

        #서버연결종료
        SMTPServer.quit()
    def updatechrome(self):
        '''
        [selenium 실습]
        '''
        chrome = webdriver.Chrome()
        chrome.get("https://chromedriver.storage.googleapis.com/LATEST_RELEASE")
        ver = chrome.find_element_by_xpath("/html/body/pre")
        driver_url="https://chromedriver.storage.googleapis.com/index.html?path="+ver
        chrome.get(driver_url)

        #login pw
        lateatver = chrome.find_element_by_xpath("/html/body/table/tbody/tr[6]/td[2]/a")
        win32.send_keys(lateatver)
        loginbutton = chrome.find_element_by_id("login_button")
        loginbutton.send_keys(Keys.ENTER)
        chrome.quit()

    def naver(self):
        chrome = webdriver.Chrome()
        chrome.get("http://news.naver.com")

        child=chrome.find_element_by_xpath('//*[@id="right.ranking_contents"]/ul/li[2]/a')
        print(child)
        chrome.quit()



if __name__ == "__main__":
    test = MyLibrary()
    test.naver()
    #test.OpenLoginPageChrome('demo','mode')
    #print(test.Get_Platform_Info())   #Get_Platform_Info 테스트
    #folder=r"C:\Users\automation\test3"
    #test.FileMaker("c:\\users\\automation\\test2", "txt", 20)
    #test.Change_blank_to_underbar(folder)
    #print(test.readcsv('example.csv'))
    #test.CSVFileMaker("c:\\users\\automation\\test2", 3)
    #ret=test.CSVFileReader("c:\\users\\automation\\test2\\1.csv")
    #print(ret)
    #test.soup_file('C:\WebServer\html\index.html')
    #test.soup_url("http://localhost:7272/")
    #test.soup_tag('C:\WebServer\html\index.html')
    #soup=test.soup_tag('C:\WebServer\html\index.html')
    #print(soup.title)
    #print(soup.find_all('title'))
    #print(soup.select('title'))
    #test. request_status ("http://localhost:7272/")
    #test.check_title("http://localhost:7272/index.html", "Lg")
    #test.check_title("C:\WebServer\html\index.html", "Lon")
    #test.send_mail_smtp("test@gmail.com", "testpass", "test@naver.com", "test", "email test")
