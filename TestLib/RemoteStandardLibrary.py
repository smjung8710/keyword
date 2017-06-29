#!/usr/bin/env python

import os
import sys
from robot.libraries.OperatingSystem import OperatingSystem
from robot.libraries.Screenshot import Screenshot
from robot.libraries.XML import XML
from robot.libraries.Telnet import Telnet
from robot.libraries.Process import Process

try:
    from collections import OrderedDict as _default_dict
except ImportError:
    # fallback for setup.py which hasn't yet built _collections
    _default_dict = dict


class RemoteStandardLibrary(Process, OperatingSystem, Screenshot, XML, Telnet):

    def __init__(self):
        Screenshot.__init__(self,"\\\\192.168.60.10\\Commander_Log_Repository\\bb")
        XML.__init__(self,use_lxml=True)
        Telnet.__init__(self, timeout='3 seconds', newline='CRLF', prompt=None, prompt_is_regexp=False,encoding='UTF-8', encoding_errors='ignore',default_log_level='INFO')
        Process.__init__(self)
        """Also this doc should be in shown in library doc."""    """Also this doc should be in shown in library doc."""

if __name__ == '__main__':
    from robotremoteserver import RobotRemoteServer
    RobotRemoteServer(RemoteStandardLibrary(), *sys.argv[1:])