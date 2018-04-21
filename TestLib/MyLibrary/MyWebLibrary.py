# -*- coding: utf-8 -*-


import platform
import os, sys, random
import csv
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup
import requests

import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')

from robot.output import Output as result

class MyWebLibrary(object):

    def OpenLoginPageChrome (self, id, pw):
        ''' id 엘리멘트를 이용한 테스트 웹서버 로그인
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
        ''' xpath 엘리멘트를 이용한 테스트 웹서버 로그인
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

    def soup_file(self, file):
        ''' 웹 페이지 파일 file을 이용한 파싱 키워드
        '''
        with open(file) as page:
            soup= BeautifulSoup(page,'html.parser')
            print(soup.prettify())

    def soup_url(self,url):
        ''' 웹 페이지 주소 url를 이용한 파싱 키워드
        '''
        res=requests.get(url)
        res.raise_for_status()
        soup= BeautifulSoup(res.text, 'html.parser')
        print(soup)

    def soup_tag(self, file, tag):
        ''' 태그를 이용한 페이지 상세 파싱 키워드
        '''
        with open(file) as page:
            soup= BeautifulSoup(page,'html.parser')
            ret = os.patch.join(soup.tag)
        print(ret)

    def check_title(self, path, expected):
         ''' 웹페이지 파일에서 타이틀 확인 키워드
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
                  print "Fail URL. There is no title"
                  ROBOT_EXIT_ON_FAILURE = True
                  return False
         else:
             with open(path) as page:
                 soup= BeautifulSoup(page,'html.parser')
             title=str(soup.title)
             if expected in title:
                 print "Pass FILE"
                 return True
             else:
                 print "Fail FILE. There is no title"
                 return False


if __name__ == "__main__":
    test = MyWebLibrary()
    #test.OpenLoginPageChrome('demo','mode')
    #test.soup_file('C:\WebServer\html\index.html')
    #test.soup_url("http://localhost:7272/")
    test.check_title("http://localhost:7272/index.html", "Lg")
    test.check_title("C:\WebServer\html\index.html", "Lon")

    #print(soup.title)
    #print(soup.find_all('title'))
    #print(soup.select('title'))
