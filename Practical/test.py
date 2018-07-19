import requests
import pandas as pd 
from bs4 import BeautifulSoup
import re, base64, pickle, time, os
from datetime import datetime
url = "http://m.cafe.naver.com/swtester"
 
user_agent = "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) " + \
            "Chrome/65.0.3325.181 Safari/537.36"
headers = {"User-Agent": user_agent}
response = requests.get(url, headers=headers)
dom = BeautifulSoup(response.content, "html.parser")
rows = dom.select("#articleListArea li")
df = pd.DataFrame(columns=["title","writer","date"])
for row in rows:
    title = row.select_one(".tit").text.strip()
    writer = row.select_one(".nick").text
    date = row.select_one(".time").text
    
    data_dict = {
        "title":title, 
        "writer":writer, 
        "date":date, 
    }
    df.loc[len(df)] = data_dict   

ndt = datetime.now()
path = ndt.strftime("%Y%m%d%H%M%S") + '_result.plk'
path2 = 'result.plk'
pickle.dump(df, open(path, 'wb'))
pickle.dump(df, open(path2, 'wb'))
