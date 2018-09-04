from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import unittest

class Search(unittest.TestCase):
    """docstring for [object Object]."""
    def setup(self):
        self.driver=webdriver.Chrome()

    def search_pycon(self):
        driver=webdriver.Chrome()
        driver.get("http://www.python.org")
        assert "Python.org" in driver.title

        elem=driver.find_element_by_name("q")
        elem.clear()
        elem.send_keys("pycon")
        elem.send_keys(Keys.RETURN)
        assert "No results found." not in driver.page_source

    def teardown(self):
        self.driver.close()

if __name__=="__main__":
    unittest.main()
