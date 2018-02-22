#!/usr/bin/env python
# -*- coding: cp949 -*-

import platform
import os, sys, random
import csv
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')


class MyWebLibrary(object):
    def Open_Chrome(self,url):
        driver=webdriver.Chrome()
        driver.get(url)

    def Open_Firefox(self, url):
        driver=webdriver.Firefox()
        driver.get(url)
    def Get_Attribute(self, url):
        driver=webdriver.Firefox()
        driver.get(url)


if __name__ == "__main__":
    test = MyWebLibrary()
