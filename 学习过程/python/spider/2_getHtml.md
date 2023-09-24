# lib

```python
import requests


def getHtml(url):
    headers = {
        # 构造请求头
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36"
    }

    proxies = {
        # 构造代理 IP
        # "http": "http://192.168.5.102:3128",
        # "https": "http://192.168.5.102:1080",
    }
    return requests.get(url, headers=headers, proxies=proxies)
```

示例

```PYTHON
import requests
from bs4 import BeautifulSoup
import re

url = 'http://www.cntour.cn'


def getHtml(url):
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36"
    }
    proxies = {
        # proxy ip
        # "http": "http://192.168.5.102:3128",
        # "https": "http://192.168.5.102:1080",
    }

    return requests.get(url, headers=headers, proxies=proxies)


html = getHtml(url)
soup = BeautifulSoup(html.text, 'lxml')
data = soup.select('#main > div > div.mtop.firstMod.clearfix > div.centerBox > ul.newsList > li> a')
for item in data:
    res = {
        'ID': re.findall('\d+', item.get('href')),
        'title': item.get('title'),
        'link': item.get('href')
    }
    print(res)
```

## 参考

1. [Python爬虫入门教程：超级简单的Python爬虫教程](http://c.biancheng.net/view/2011.html)
