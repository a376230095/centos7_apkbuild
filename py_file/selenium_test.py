from selenium import webdriver
chrome_options = webdriver.ChromeOptions()
chrome_options.add_argument('--headless') #
chrome_options.add_argument('--no-sandbox')  # 这句一定要加
#我一开始没加，就一直报‘selenium.common.exceptions.WebDriverException: Message: unknown error: Chrome failed to start: exited abnormally’。搞了很久。
driver = webdriver.Chrome(chrome_options=chrome_options)
driver.get("https://www.baidu.com")
print(driver.title)
