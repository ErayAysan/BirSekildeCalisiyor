# BirSekildeCalisiyor

YBS305 İş Zekâsı ve Veri Madenciliği dönem projesi: Seattle Airbnb verisiyle dbt ETL, Power BI dashboard ve fiyat tahmin modeli.

## Ekip

-Eray Aysan - 030424046 - Rol1
-Rauf Hakan Gençeli - 030424013 - Rol2
-Zeynep Sude Çengel - 030424012 - Rol3
-Suden Eraslan -030424026 - Rol4

## Problem

- Seattle’da bir Airbnb ilanının gecelik fiyatını ve doluluğunu hangi faktörler belirliyor; ev sahibi ilanını nasıl fiyatlandırmalı?

## Veri Kaynakları

- Inside Airbnb – Seattle ilanları (link ve çekilme tarihi eklenecek)
- Dış kaynak: 
Kaynak: ABD Nüfus Bürosu, American Community Survey (ACS) 
Veri seti: 2016 ACS 5 yıllık tahminler 
Erişim: Census API: https://api.census.gov/data/2016/acs/acs5 
Değişkenler: B01003_001E nüfus, B19013_001E medyan hane geliri, B25064_001E medyan brüt kira
Coğrafya: Posta kodu bölgesi (ZCTA), 981 ile başlayan Seattle kodları 
Çekme script'i: data/fetch_census.py 
Çekilme tarihi: 6 Kasım 2026 

Script'i çalıştırmak için ücretsiz bir Census API anahtarı gerekir(https://api.census.gov/data/key_signup.html). Anahtarın GitHub'a gönderilmemesi için terminalde `$env:CENSUS_API_KEY="ANAHTAR"` komutuyla tanımlandı.

Veri seti kullanımı için eğitmen onayı alınmıştır.

## Proje Yapısı

- data/ – ham ve dış veriler
- dbt/ – dbt projesi
- model/ – model eğitimi ve değerlendirme
- app/ – Streamlit uygulaması

## Nasıl Çalıştırılır

(dbt aşamasında doldurulacak)
