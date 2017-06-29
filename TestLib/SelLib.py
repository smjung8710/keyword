#!/usr/bin/env python

import os
import sys

from Selenium2Library import Selenium2Library

class ExampleRemoteLibrary(Selenium2Library):

    def __init__(self):
        Selenium2Library.__init__(self)
        """Also this doc should be in shown in library doc."""
        
if __name__ == '__main__':
    from robotremoteserver import RobotRemoteServer
    RobotRemoteServer(ExampleRemoteLibrary(), *sys.argv[1:])

