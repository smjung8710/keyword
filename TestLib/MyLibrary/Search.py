# -*- coding: utf-8 -*-
import unittest
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')


class TestPythonOrgSerach(unittest.TestCase):
    '''
    단위 테스트 모듈 unittest 사용방법 실습 코드
    '''

    def setUp(self):
        self.driver= webdriver.Chrome()

    def test_search_in_python_org(self):
        driver=self.driver
        driver.get("http://www.python.org")
        self.assertIn("Python", driver.title)
        # q 이름을 가진 element 찾기
        element= driver.find_element_by_name("q")
        element.send_keys("selenium")
        element.send_keys(Keys.RETURN)
        self.assertTrue("Results",driver.page_source)

    def tearDown(self):
        self.driver.close()

if __name__=="__main__":
    unittest.main()
