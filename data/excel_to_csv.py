import csv
from openpyxl import load_workbook

wb = load_workbook("data/raw/airbnb_seattle.xlsx", read_only=True)
ws = wb.active

satir_sayisi = 0
with open("data/raw/airbnb_seattle.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    for row in ws.iter_rows(values_only=True):
        writer.writerow(["" if v is None else v for v in row])
        satir_sayisi += 1

print(f"{satir_sayisi - 1} satır CSV'ye yazıldı.")