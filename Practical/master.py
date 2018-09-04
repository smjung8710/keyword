from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup
import requests

class master(object):
    def find_link(self, url):
        res=requests.get(url)
        res.raise_for_status()
        soup=BeautifulSoup(res.text, 'html.parser')
        print(soup)

    def naver(self):
        chrome = webdriver.Chrome('./chromedriver')
        chrome.get("http://news.naver.com")

        child=chrome.find_element_by_xpath('//*[@id="right.ranking_contents"]/ul/li[2]/a')
        print(child)
        chrome.quit()


if __name__=='__main__':
    test=master()
    test.naver()
    #test.find_link('http://robotframework.org/#libraries')
