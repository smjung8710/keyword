# -*- coding: utf-8 -*-
#!/usr/bin/env python
from __future__ import print_function
import os
import sys
from robot.libraries.OperatingSystem import OperatingSystem
from robot.libraries.Screenshot import Screenshot
from robot.libraries.XML import XML
from robot.libraries.Process import Process
import robot.libraries
import re
from robotremoteserver import RobotRemoteServer
try:
    from collections import OrderedDict as _default_dict
except ImportError:
    # fallback for setup.py which hasn't yet built _collections
    _default_dict = dict

try:
    basestring
except NameError:   # Python 3
    basestring = str

class ExampleRemoteLib(Process, OperatingSystem, Screenshot, XML):
    '''
    Remote Server 테스트 위한 Remoe Library
    원격 실행에 사용되는 표준 라이브러리 모듈과 제차 라이브러리를 포함

    '''
    def __init__(self):
        Screenshot.__init__(self,"C:\\WebServer\\Results")
        XML.__init__(self,use_lxml=True)
        Process.__init__(self)

    def count_items_in_directory(self, path):
        """Returns the number of items in the directory specified by `path`."""
        items = [i for i in os.listdir(path) if not i.startswith('.')]
        return len(items)

    def strings_should_be_equal(self, str1, str2):
        print("Comparing '%s' to '%s'." % (str1, str2))
        if not (isinstance(str1, basestring) and isinstance(str2, basestring)):
            raise AssertionError("Given strings are not strings.")
        if str1 != str2:
            raise AssertionError("Given strings are not equal.")





if __name__ == '__main__':
    RobotRemoteServer(ExampleRemoteLib(), *sys.argv[1:])
