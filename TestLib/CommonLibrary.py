#!/usr/bin/env python

import os
import sys

sys.path.append("c:\\BuFF\\TestLib")

from robot.libraries.OperatingSystem import OperatingSystem
from robot.libraries.Process import Process


class ExampleRemoteLibrary(Process, OperatingSystem):

    def __init__(self):
        Process.__init__(self)
        """Also this doc should be in shown in library doc."""

if __name__ == '__main__':
    from robotremoteserver import RobotRemoteServer
    RobotRemoteServer(ExampleRemoteLibrary(), *sys.argv[1:])

