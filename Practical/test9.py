# -*- coding: cp949 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait  
from selenium.webdriver.support import expected_conditions as EC  

class MyLibrary(object):
    def Open_Firefox(self, url):
        #파이어폭스 브라우저로 url 열기
        driver = webdriver.Firefox()
        driver.get(url)
        try:
            wait=WebDriverWait(driver, 10)
            wait.until(EC.presence_of_element_located((By.ID, "login_button")))
            print driver.title
        finally:
            driver.close()
        
        

if __name__ == "__main__":
    test=MyLibrary()
    #test. Open_Chrome('http://localhost:7272')
    test. Open_Firefox('http://localhost:7272')
