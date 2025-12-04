import requests
from bs4 import BeautifulSoup
import os
import urllib.parse

tools = [
    {"id": "midjourney", "url": "https://www.midjourney.com"},
    {"id": "openai_sora", "url": "https://openai.com/sora"},
    # Add more tools here...
]

os.makedirs("icons", exist_ok=True)

def get_favicon_url(site_url):
    try:
        html = requests.get(site_url, timeout=5).text
        soup = BeautifulSoup(html, 'html.parser')
        icon_link = soup.find("link", rel=lambda x: x and 'icon' in x.lower())
        if icon_link and icon_link.get("href"):
            href = icon_link["href"]
            return urllib.parse.urljoin(site_url, href)
    except Exception as e:
        print(f"Error fetching favicon for {site_url}: {e}")
    return None

for tool in tools:
    favicon = get_favicon_url(tool["url"])
    if favicon:
        try:
            img = requests.get(favicon, timeout=5).content
            with open(f"icons/{tool['id']}.png", "wb") as f:
                f.write(img)
            print(f"Saved favicon for {tool['id']}")
        except Exception as e:
            print(f"Error saving favicon for {tool['id']}: {e}")