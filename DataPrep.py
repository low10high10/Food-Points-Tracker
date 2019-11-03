import selenium
from selenium import webdriver
from selenium.webdriver.support.ui import Select
import time
from queue import Queue
from selenium.webdriver.chrome.options import Options
import json

chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--window-size=1920x1080")

driver = webdriver.Chrome("/Users/anshul/Desktop/chromedriver", options=chrome_options)
lst = []
driver.get('https://duke-sp.blackboard.com/eaccounts/AccountTransaction.aspx')
time.sleep(1)
usr = driver.find_element_by_id("j_username")
usr.send_keys("as817")
pword = driver.find_element_by_id("j_password")
pword.send_keys("Amadorvalley2017")
driver.find_element_by_id("Submit").click()
time.sleep(1)
select = Select(driver.find_element_by_id('MainContent_Accounts'))
select.select_by_value("50f415b5-2d1b-4e12-8b3c-92c312fe2c29")
start = driver.find_element_by_id("ctl00_MainContent_BeginRadDateTimePicker_dateInput")
start.click()
start.send_keys("08/01/19 12:00 AM")
time.sleep(1)
driver.find_element_by_id("MainContent_ContinueButton").click()
time.sleep(2)
x = driver.find_element_by_class_name("rgPager")
links = x.find_elements_by_tag_name("a")
test = driver.find_element_by_id('ctl00_MainContent_ResultRadGrid_ctl00')
rows = test.find_elements_by_tag_name("tr") # get all of the rows in the table
for i in range(4, len(rows)):
    lst.append(rows[i].text)
#link_set = set(links)
i = 1
while i < num:
    l = links[i]
    l.click()
    time.sleep(2)
    test = driver.find_element_by_id('ctl00_MainContent_ResultRadGrid_ctl00')
    rows = test.find_elements_by_tag_name("tr") # get all of the rows in the table
    for k in range(4, len(rows)):
        lst.append(rows[k].text)
    x = driver.find_element_by_class_name("rgPager")
    links = x.find_elements_by_tag_name("a")      
    i += 1

data = {}
monthD = {"11": "November", "10": "October", "9": "September"}
for txt in lst:
    txt = txt.split()
    date = txt[0]
    m = date.split("/")[0]
    month = monthD[m]
    day = date.split("/")[1]
    if month not in data:
        data[month] = {}
    if day not in data[month]:
        data[month][day] = []
    
    
    hour = " ".join([txt[1], txt[2]])
    price = txt[-2][1:-1]
    location = " ".join([txt[5], txt[-5]])
    #print(location)
    if location == "Au Reg":
        location = "Au Bon Pain"
    if location.startswith("Lobby"):
        location = "Lobby Shop"
    if location.startswith("Vending"):
        location = "Vending Machine"
    if location.split()[0] == location.split()[1]:
        location = location.split()[0]
    smallD = {"Time": hour, "Used": price, "Location": location}
    data[month][day].append(smallD)
print(data)

with open("final.json", "w") as write_file:
    json.dump(data, write_file)
