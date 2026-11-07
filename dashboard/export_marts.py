from pathlib import Path
import duckdb

VERITABANI = "airbnb.duckdb"
CIKTI_KLASORU = Path("../../dashboard/data")

TABLOLAR = [
    "dim_ev_sahibi",
    "fct_ilan_performans",
]

CIKTI_KLASORU.mkdir(parents=True, exist_ok=True)
baglanti = duckdb.connect(VERITABANI, read_only=True)

for tablo in TABLOLAR:
    hedef = CIKTI_KLASORU / f"{tablo}.csv"
    baglanti.execute(f"COPY (SELECT * FROM {tablo}) TO '{hedef.as_posix()}' (HEADER, DELIMITER ',')")
    satir = baglanti.execute(f"SELECT count(*) FROM {tablo}").fetchone()[0]
    print(f"{tablo}: {satir} satır -> {hedef}")

baglanti.close()