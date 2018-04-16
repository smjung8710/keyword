#!/usr/bin/env python

import os
import sys

from Selenium2Library import Selenium2Library

class SeleniumLib(Selenium2Library):

    def __init__(self):
        Selenium2Library.__init__(self)
        """Also this doc should be in shown in library doc."""
        
if __name__ == '__main__':
    from robotremoteserver import RobotRemoteServer
    RobotRemoteServer(SeleniumLib(), *sys.argv[1:])

