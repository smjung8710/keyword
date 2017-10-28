#!/usr/bin/env python

from __future__ import print_function

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

    def strings_should_be_equal(self, str1, str2):
        print("Comparing '%s' to '%s'." % (str1, str2))
        if not (isinstance(str1, basestring) and isinstance(str2, basestring)):
            raise AssertionError("Given strings are not strings.")
        if str1 != str2:
            raise AssertionError("Given strings are not equal.")

if __name__ == '__main__':
    RobotRemoteServer(ExampleLibrary(), *sys.argv[1:])
