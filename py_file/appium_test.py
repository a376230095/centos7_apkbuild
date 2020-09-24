from time import sleep
from appium import webdriver
from appium.webdriver.common.mobileby import MobileBy as By

class TestFind():
    #设置caps的值
    def setup(self):
        self.desire_cap= {
            #默认是Android
            "platformName":"android",
            #adb devices的sn名称
            "deviceName":"LR6PFUPFS4YSM7BM",
            #包名
            "appPackage":"com.xueqiu.android",
            #activity名字
            "appActivity":".view.WelcomeActivityAlias",
            "noReset":"true",
            "unicodeKeyboard":True
        }
        #运行appium，前提是要打开appium server
        self.driver=webdriver.Remote("http://127.0.0.1:4723/wd/hub",self.desire_cap)
        self.driver.implicitly_wait(5)
        self.driver.launch_app()

    def test_search(self):
        print("ok")
