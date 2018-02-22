#!/usr/bin/env python
# -*- coding: cp949 -*-


import platform
import os, sys, random
import csv
from selenium import webdriver
from selenium.webdriver.common.keys import Keys

sys.path.append("c:\\lib")

from robot.libraries.OperatingSystem import OperatingSystem
from robot.libraries.Process import Process


class ExampleRemoteLibrary(object):

    def __init__(self):
        
        """Also this doc should be in shown in library doc."""

if __name__ == '__main__':
    from robotremoteserver import RobotRemoteServer
    RobotRemoteServer(ExampleRemoteLibrary(), *sys.argv[1:])

