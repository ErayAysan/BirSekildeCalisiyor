import csv
import os
import requests

URL = "https://api.census.gov/data/2016/acs/acs5"
PARAMETRELER = {
    "get": "NAME,B01003_001E,B19013_001E,B25064_001E",
    "for": "zip code tabulation area:*",
    "key": os.environ["CENSUS_API_KEY"],
}

yanit = requests.get(URL, params=PARAMETRELER, timeout=120)
yanit.raise_for_status()
satirlar = yanit.json()
veri = satirlar[1:]

seattle = [satir for satir in veri if satir[5].startswith("981")]

with open("data/external/census_posta_kodu_2016.csv", "w", newline="", encoding="utf-8") as f:
    yazici = csv.writer(f)
    yazici.writerow(["NAME", "B01003_001E", "B19013_001E", "B25064_001E", "zcta"])
    for satir in seattle:
        yazici.writerow([satir[0], satir[1], satir[2], satir[3], satir[5]])

print(f"{len(seattle)} Seattle posta kodu kaydedildi.")

