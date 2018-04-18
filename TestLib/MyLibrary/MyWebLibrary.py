# -*- coding: utf-8 -*-
#!/usr/bin/env python

import platform
import os, sys, random
import csv
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup

import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')


class MyWebLibrary(object):

    def OpenLoginPageChrome (self, id, pw):
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
        with open(file) as page:
            soup= BeautifulSoup(page,'html.parser')
            print(soup)



if __name__ == "__main__":
    test = MyWebLibrary()
    test.OpenLoginPageChrome('demo','mode')
