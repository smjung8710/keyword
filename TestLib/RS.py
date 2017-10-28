#!/usr/bin/env python

import os
import sys

from robotremoteserver import RobotRemoteServer


try:
    basestring
except NameError:   # Python 3
    basestring = str


class ExampleLibrary(object):

    def count_items_in_directory(self, path):
        """Returns the number of items in the directory specified by `path`."""
        items = [i for i in os.listdir(path) if not i.startswith('.')]
        return len(items)


if __name__ == '__main__':
    RobotRemoteServer(ExampleLibrary(), *sys.argv[1:])