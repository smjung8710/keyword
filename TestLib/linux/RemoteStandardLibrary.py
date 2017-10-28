#!/usr/bin/env python

import os
import sys
from robot.libraries.OperatingSystem import OperatingSystem
from robot.libraries.Screenshot import Screenshot
from robot.libraries.XML import XML
from robot.libraries.Telnet import Telnet
from robot.libraries.Process import Process
from robot.libraries.difference import diff

try:
    from collections import OrderedDict as _default_dict
except ImportError:
    # fallback for setup.py which hasn't yet built _collections
    _default_dict = dict

import re

class ExampleRemoteLibrary(Process, OperatingSystem, Screenshot, XML, Telnet):

    def __init__(self):
        Screenshot.__init__(self,"\\\\192.168.60.10\\Commander_Log_Repository\\bb")
        XML.__init__(self,use_lxml=True)
        """CommonUtil.__init__(self, None, dict , False)"""
        Telnet.__init__(self, timeout='3 seconds', newline='CRLF', prompt=None, prompt_is_regexp=False,encoding='UTF-8', encoding_errors='ignore',default_log_level='INFO')
        Process.__init__(self)
        """Also this doc should be in shown in library doc."""
        
    def pause_execution(self, message='Test execution paused. Press OK to continue.'):
        dialogs.pause_execution(message)
        
    def execute_manual_step(self, message, default_error=''):
        dialogs.execute_manual_step(message, default_error)
        
    def get_value_from_user(self, message, default_value=''):
        dialogs.get_value_from_user(message, default_value)
                                    
    def get_selection_from_user(self, message, *values):
        dialogs.get_selection_from_user(message, *values)
                                    

if __name__ == '__main__':
    from robotremoteserver import RobotRemoteServer
    RobotRemoteServer(ExampleRemoteLibrary(), *sys.argv[1:])

