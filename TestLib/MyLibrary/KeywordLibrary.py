#-*- coding: utf-8 -*-
from calculator import Calculator, CalculationError
from robot.api.deco import keyword
import os
from robot.api import logger
import logging
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s-%(levelname)s - %(message)s')
logging.debug('Start of program')

class KeywordLibrary(object):
    """Test library for testing *Calculator* business logic.

    Interacts with the calculator directly using its ``push`` method.
    """

    def __init__(self):
        self._calc = Calculator()
        self._result = ''

    @keyword('Please press the calculator button', tags=['push', 'cal'])
    def push_button(self, button):
        """Pushes the specified ``button``.

        The given value is passed to the calculator directly. Valid buttons
        are everything that the calculator accepts.

        Examples:
        | Push Button | 1 |
        | Push Button | C |

        Use `Push Buttons` if you need to input longer expressions.
        """
        self._result = self._calc.push(button)

    @keyword('Please press the calculator buttons', tags=['push', 'cal'])
    def push_buttons(self, buttons):
        """Pushes the specified ``buttons``.

        Uses `Push Button` to push all the buttons that must be given as
        a single string. Possible spaces are ignored.

        Example:
        | Push Buttons | 1 + 2 = |
        """
        for button in buttons.replace(' ', ''):
            self.push_button(button)

    @keyword('the calculator said it is', tags=['push', 'cal'])
    def result_should_be(self, expected):
        """Verifies that the current result is ``expected``.

        Example:
        | Push Buttons     | 1 + 2 = |
        | Result Should Be | 3       |
        """
        if self._result != expected:
            raise AssertionError('%s != %s' % (self._result, expected))

    def should_cause_error(self, expression):
        """Verifies that calculating the given ``expression`` causes an error.

        The error message is returned and can be verified using, for example,
        `Should Be Equal` or other keywords in `BuiltIn` library.

        Examples:
        | Should Cause Error | invalid            |                   |
        | ${error} =         | Should Cause Error | 1 / 0             |
        | Should Be Equal    | ${error}           | Division by zero. |
        """
        try:
            self.push_buttons(expression)
        except CalculationError as err:
            return str(err)
        else:
            raise AssertionError("'%s' should have caused an error."
                                 % expression)

    def any_arguments(self, *args):
        '''키워드 인자값 실습 예시'''
        print "Got Agruments"
        for arg in args:
            print args

    def any_int_arguments(self, args):
        '''키워드 인자값 실습 예시'''
        print "Got Agruments"
        args=int(args)
        print args

    def return_two_values(self, arg1, arg2):
        '''키워드 리턴값 실습 예시'''
        return arg1, arg2

    def return_multiple_values(self, arg):
        '''키워드 리턴값 3개 실습 예시'''
        return ['a', 'list', 'of', 'strings']

    def keyword_debug(self, arg):
        '''키워드 디버깅 실습 예시'''
        logger.debug('Got argument %s' %arg)
        logger.info('<i>This</i> is a boring example', html=True)
        logger.console('Hello, console!')

    def keyword_debug2(self, arg):
        logging.debug('Got argument %s' % arg)
        logging.info('This is a boring example')

if __name__=='__main__':
    keyword_debug('keyword testing')
