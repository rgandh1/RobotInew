#
# This is a Selenium web testing library for Robot Framework.
#
# Author walter.heincz
#
from org.openqa.selenium import By
from org.openqa.selenium import WebDriver
from org.openqa.selenium import WebElement
from org.openqa.selenium.firefox import FirefoxDriver
from org.openqa.selenium.support.ui import ExpectedCondition
from org.openqa.selenium.support.ui import WebDriverWait
import org.openqa.selenium.OutputType as OutputType

import org.apache.commons.io.FileUtils as FileUtils
import java.io.File as File


import logging
import time
import robot

#import Selenium2Library

#import thread

class InewSelenium2Library:

    ROBOT_LIBRARY_SCOPE = 'TEST CASE'
    ROBOT_LIBRARY_VERSION = '0.2'


    def __init__(self): 

        self._logger = logging.getLogger('scope.name')
        file_log_handler = logging.FileHandler('logfile.log')
        self._logger.addHandler(file_log_handler)
        stderr_log_handler = logging.StreamHandler()
        self._logger.addHandler(stderr_log_handler)
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        file_log_handler.setFormatter(formatter)
        stderr_log_handler.setFormatter(formatter)

        self.__firefoxDriver=None
        self._speed = 0.4



    def open_browser(self, url, browser):
        #self._logger.error('open_browser(' + url + ', ' + browser +')')
        self.__firefoxDriver=FirefoxDriver()
        self.__firefoxDriver.get(url)


    def maximize_browser_window(self):
        #self._logger.error('maximize_browser_window()')
        #self.__firefoxDriver.maximize_window()
        dosomething='here'

    def close_browser(self):
        #self.__firefoxDriver.close(url)
        #TODO: Find out why the Browser instance is not killed by close()
        #self.__firefoxDriver.close()
        self.__firefoxDriver.quit()
        self.__firefoxDriver = None




    def set_selenium_speed(self, seconds):
        #self._logger.error('set_selenium_speed()')
        self._speed=seconds

    def get_selenium_speed(self):
        return self._speed


    def save_screenshot(self, filepath):
        tempfile = self.__firefoxDriver.getScreenshotAs(OutputType.FILE)
        FileUtils.copyFile(tempfile, File(filepath))

  
    def input_text(self, locator, text):
        #self._logger.error('input_text(' + locator + ', ' + text+')')
        element = self._find_element(locator)
        element.sendKeys(text);



    def go_to(self, url):
        #self._logger.error('go_to(' + url + ')')
        self.__firefoxDriver.get(url)

    def click_element(self, locator):
        #self._logger.error('click_element(' + locator + ')')
        element = self._find_element(locator)
        element.click();


    def page_contains_element(self, locator): 
        return self._is_element_present(locator)     


    def wait_until_page_contains_element(self, locator, timeout=None, error=None):
        if not error:
            error = "Element '%s' did not appear in <TIMEOUT>" % locator
        self._wait_until(timeout, error, self._is_element_present, locator)



    def select_frame(self, locator):
        #self._logger.error('select_frame(' + locator + ')')
        element = self._find_element(locator)
        #self.__firefoxDriver.switch_to_frame(element)
        self.__firefoxDriver.switchTo().frame(element)


    def unselect_frame(self):
        #self.__firefoxDriver.switch_to_default_content()
        self.__firefoxDriver.switchTo().defaultContent() 



    def get_table_cell(self, table_locator, row, column, loglevel='INFO'):
        #self._logger.error('get_table_cell(' + table_locator + ', ' + row + ', ' + column  + ')')
        row = int(row)
        row_index = row - 1
        column = int(column)
        column_index = column - 1
        tableElement = self._find_element(table_locator)
        if tableElement is not None:
            rows = tableElement.findElementsByXPath("./thead/tr")
            if row_index >= len(rows): rows.addAll(tableElement.findElementsByXPath("./tbody/tr"))
            if row_index >= len(rows): rows.addAll(tableElement.findElementsByXPath("./tfoot/tr"))
            if row_index < len(rows):
                columns = rows[row_index].findElementsByTagName('th')
                if column_index >= len(columns): columns.addAll(rows[row_index].findElementsByTagName('td'))
                if column_index < len(columns):
                    return columns[column_index].text

        raise AssertionError("Cell in table %s in row #%s and column #%s could not be found."
            % (table_locator, str(row), str(column)))


############### private ###################

    def _find_element(self, locator):

        splitLocator=locator.split("=") #id/name/link=value
        strategy=''
        value=''

        if locator.startswith( '//' ): 
            strategy='xpath'
            value = splitLocator[0]         

        elif len(splitLocator)==2:
            strategy=splitLocator[0]
            value = splitLocator[1]

        else:   #default strategy
            strategy='id'
            value = splitLocator[0]

        element = None

        if strategy == 'id':
            #element = self.__firefoxDriver.findElement(By.id(value))
            element = self.__firefoxDriver.findElementById(value)

        elif strategy == 'name':
            #element = self.__firefoxDriver.findElement(By.name(value))
            element = self.__firefoxDriver.findElementByName(value)

        elif strategy == 'link':
            element = self.__firefoxDriver.findElementByLinkText(value)

        elif strategy == 'xpath':
            element = self.__firefoxDriver.findElementByXPath(locator)

        else:
            raise AssertionError('Unknown locator strategy: ' + locator) 


        return element


    def _wait_until(self, timeout, error, function, *args):
        error = error.replace('<TIMEOUT>', self._format_timeout(timeout))
        def wait_func():
            return None if function(*args) else error
        self._wait_until_no_error(timeout, wait_func)

    def _wait_until_no_error(self, timeout, wait_func, *args):
        timeout = robot.utils.timestr_to_secs(timeout) if timeout is not None else self._timeout_in_secs
        maxtime = time.time() + timeout
        while True:
            timeout_error = wait_func(*args)
            if not timeout_error: return
            if time.time() > maxtime:
                raise AssertionError(timeout_error)
            time.sleep(0.2)


    def _format_timeout(self, timeout):
        timeout = robot.utils.timestr_to_secs(timeout) if timeout is not None else self._timeout_in_secs
        return robot.utils.secs_to_timestr(timeout)

    def _is_element_present(self, locator):
        elementFound = 'true'
        try:
            element = self._find_element(locator)         
        except:
            elementFound = 'false'
        return elementFound 

