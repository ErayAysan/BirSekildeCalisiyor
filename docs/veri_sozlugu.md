# Veri Sözlüğü

Projedeki tabloların sütun açıklamaları. Ayrıntılı ve etkileşimli sürüm: docs/dbt_docs.html

## dim_ev_sahibi (mart, table)

Her satır bir ev sahibi (2.751 satır). stg_ilanlar'daki ilanlar ev_sahibi_id'ye göre gruplanarak oluşturulur; fct_ilan_performans ile ev_sahibi_id üzerinden bağlanır. Sahibi: Hakan.

| Sütun                      | Tip     | Açıklama                                                                                                                               |
| -------------------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| ev_sahibi_id               | BIGINT  | Ev sahibinin anonim kimliği (birincil anahtar)                                                                                         |
| ev_sahibi_baslangic_tarihi | DATE    | Ev sahibinin platforma katıldığı (ev sahipliğine başladığı) tarih                                                                      |
| deneyim_yili               | DOUBLE  | Ev sahipliğine başladığı tarihten verinin takvim başlangıcına (2016-01-04) kadar geçen yıl                                             |
| super_ev_sahibi            | BOOLEAN | Ev sahibi süper ev sahibi statüsündeyse true                                                                                           |
| kimlik_dogrulandi          | BOOLEAN | Ev sahibinin kimliği doğrulanmışsa true                                                                                                |
| yanit_suresi               | VARCHAR | Misafir mesajlarına yanıt süresi kategorisi: 1 saat içinde, Birkaç saat içinde, 1 gün içinde veya Birkaç gün veya daha fazla           |
| yanit_orani_yuzde          | BIGINT  | Ev sahibinin misafir mesajlarına yanıt verme oranı (%)                                                                                 |
| kabul_orani_yuzde          | BIGINT  | Ev sahibinin rezervasyon taleplerini kabul etme oranı (%)                                                                              |
| platform_ilan_sayisi       | BIGINT  | Ev sahibinin Airbnb genelindeki toplam ilan sayısı                                                                                     |
| seattle_ilan_sayisi        | BIGINT  | Ev sahibinin bu veri setindeki (Seattle) ilan sayısı                                                                                   |
| profesyonel_ev_sahibi      | BOOLEAN | Seattle'da birden fazla ilanı varsa true                                                                                               |
| ort_gecelik_fiyat_usd      | DOUBLE  | Ev sahibinin Seattle ilanlarının ortalama gecelik fiyatı (USD), 2 ondalığa yuvarlanmış                                                 |
| ort_genel_puan_100         | DOUBLE  | Ev sahibinin Seattle ilanlarının ortalama genel puanı (100 üzerinden), 1 ondalığa yuvarlanmış; puanı olmayan ilanlar ortalamaya girmez |
| ort_doluluk_orani_yuzde    | DOUBLE  | Ev sahibinin Seattle ilanlarının ortalama doluluk oranı (%), 1 ondalığa yuvarlanmış                                                    |
| toplam_yorum_sayisi        | HUGEINT | Ev sahibinin Seattle ilanlarının aldığı toplam yorum sayısı                                                                            |

## fct_ilan_performans (mart, table)

Her satır bir ilan (3.818 satır). Fiyat, doluluk ve gelir metrikleri stg_ilanlar'dan hesaplanır. Sahibi: Suden.

| Sütun                      | Tip     | Açıklama                                                                                                                                                                  |
| -------------------------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ilan_id                    | BIGINT  | İlanın benzersiz kimliği (birincil anahtar)                                                                                                                               |
| ev_sahibi_id               | BIGINT  | İlanın ev sahibi; dim_ev_sahibi tablosuna bağlanır                                                                                                                        |
| mahalle                    | VARCHAR | İlanın bulunduğu mahalle                                                                                                                                                  |
| mahalle_grubu              | VARCHAR | İlanın bağlı olduğu daha geniş mahalle grubu                                                                                                                              |
| posta_kodu                 | VARCHAR | İlanın posta kodu (metin; Census ile birleştirmek için). Bazı ilanlarda boş                                                                                               |
| oda_tipi                   | VARCHAR | Kiralanan alanın türü: Tüm ev/daire, Özel oda veya Paylaşılan oda                                                                                                         |
| mulk_tipi                  | VARCHAR | Mülk türü                                                                                                                                                                 |
| kapasite                   | BIGINT  | İlanın ağırlayabileceği en fazla misafir sayısı                                                                                                                           |
| yatak_odasi_sayisi         | BIGINT  | İlandaki yatak odası sayısı                                                                                                                                               |
| iptal_politikasi           | VARCHAR | İlanın iptal politikası: Esnek, Orta veya Katı                                                                                                                            |
| gecelik_fiyat_usd          | BIGINT  | Gecelik fiyat (USD)                                                                                                                                                       |
| temizlik_ucreti_usd        | BIGINT  | Konaklama başına tek seferlik temizlik ücreti (USD). Kaynakta boş olan değerler staging'de 0 yapılır                                                                      |
| min_gece                   | BIGINT  | İlanın kabul ettiği en az gece sayısı                                                                                                                                     |
| kisi_basi_fiyat_usd        | DOUBLE  | Gecelik fiyatın kapasiteye bölümü, 2 ondalığa yuvarlanmış (USD). Kapasite 0 ya da boşsa boş                                                                               |
| min_konaklama_maliyeti_usd | BIGINT  | Gecelik fiyat × minimum gece sayısı + temizlik ücreti (USD)                                                                                                               |
| fiyat_segmenti             | VARCHAR | Gecelik fiyata göre segment: 85 USD altı Ekonomik, 85–129 Orta, 130 ve üzeri Lüks; fiyat boşsa Bilinmiyor. Sınırlar fiyatların üçte birlik dilimlerinden belirlendi       |
| doluluk_orani_yuzde        | DOUBLE  | 365 günlük takvim döneminde dolu günlerin yüzdesi (kaynak sütun: MesguliyetOrani_Yuzde)                                                                                   |
| dolu_gun                   | BIGINT  | 365 günlük takvim döneminde müsait olmayan gün sayısı; rezerve edilmiş günler ile ev sahibinin kapattığı günleri içerir                                                   |
| takvim_tamamen_kapali      | BOOLEAN | Dolu gün sayısı takvimdeki toplam gün sayısına (takvim_gun_sayisi) eşitse true; büyük ihtimalle pasif ilan                                                                |
| tahmini_yillik_gelir_usd   | DOUBLE  | Dolu gün × takvim ortalama fiyatı (USD); takvim fiyatı yoksa gecelik fiyat kullanılır. Üst sınır tahminidir: 'dolu' günler ev sahibinin kendi kapattığı günleri de içerir |
| genel_puan_100             | BIGINT  | İlanın genel değerlendirme puanı (100 üzerinden); puanı olmayan ilanlarda boş                                                                                             |
| yorum_sayisi               | BIGINT  | İlanın aldığı yorum sayısı                                                                                                                                                |
| puani_var                  | BOOLEAN | genel_puan_100 boş değilse true                                                                                                                                           |

## stg_census_posta_kodu (staging, view)

Her satır bir Seattle posta kodu bölgesi (39 satır). Kaynak: ABD Nüfus Bürosu, 2016 ACS 5 yıllık tahminleri; data/fetch_census.py ile Census API'sinden çekilmiştir. Census'un negatif özel kodları boş değere çevrilmiştir. Sahibi: Zeynep.

| Sütun                  | Tip     | Açıklama                                                          |
| ---------------------- | ------- | ----------------------------------------------------------------- |
| posta_kodu             | VARCHAR | 5 haneli posta kodu (metin); stg_ilanlar ile birleştirme anahtarı |
| nufus                  | BIGINT  | Posta kodu bölgesindeki toplam nüfus                              |
| medyan_hane_geliri_usd | BIGINT  | Medyan yıllık hane geliri (USD); hesaplanamayan bölgelerde boş    |
| medyan_kira_usd        | BIGINT  | Medyan aylık brüt kira (USD); hesaplanamayan bölgelerde boş       |

## mart_mahalle_ozet (mart, table)

Her satır bir mahalle grubu (17 satır). stg_ilanlar ile stg_census_posta_kodu posta kodu üzerinden left join ile birleştirilir; bölge geliri ve kirası ilan ağırlıklı ortalamadır. Doluluk ortalaması takvimi tamamen kapalı ilanları içermez. Sahibi: Zeynep.

| Sütun                    | Tip     | Açıklama                                                                                             |
| ------------------------ | ------- | ---------------------------------------------------------------------------------------------------- |
| mahalle_grubu            | VARCHAR | Mahalle grubu adı (birincil anahtar)                                                                 |
| ilan_sayisi              | BIGINT  | Mahalle grubundaki ilan sayısı                                                                       |
| ort_gecelik_fiyat_usd    | DOUBLE  | Gecelik fiyatın ortalaması (USD), 2 ondalığa yuvarlanmış                                             |
| medyan_gecelik_fiyat_usd | DOUBLE  | Gecelik fiyatın medyanı (USD); aykırı değerlerden etkilenmez                                         |
| ort_doluluk_orani_yuzde  | DOUBLE  | Ortalama doluluk oranı (%), 1 ondalığa yuvarlanmış; takvimi tamamen kapalı (pasif) ilanlar hariç     |
| ort_genel_puan_100       | DOUBLE  | Ortalama genel puan (100 üzerinden), 1 ondalığa yuvarlanmış; puanı olmayan ilanlar ortalamaya girmez |
| super_ev_sahibi_yuzdesi  | DOUBLE  | Mahalle grubundaki ilanların süper ev sahibine ait olanlarının yüzdesi                               |
| bolge_medyan_geliri_usd  | DOUBLE  | İlanların posta kodlarının Census medyan hane gelirlerinin ilan ağırlıklı ortalaması (USD/yıl)       |
| bolge_medyan_kira_usd    | DOUBLE  | İlanların posta kodlarının Census medyan aylık kiralarının ilan ağırlıklı ortalaması (USD)           |
| airbnb_kira_orani        | DOUBLE  | Ortalama gecelik fiyat × 30 / bölge medyan aylık kirası; tam dolu ay varsayan üst sınır              |
| ort_enlem                | DOUBLE  | İlanların ortalama enlemi (harita konumu için)                                                       |
| ort_boylam               | DOUBLE  | İlanların ortalama boylamı (harita konumu için)                                                      |
| konum                    | VARCHAR | Harita için 'enlem,boylam' metni                                                                     |

## stg_ilanlar (staging, view)

Her satır bir Airbnb ilanı (3.818 satır). Kaynak: Inside Airbnb Seattle. Ev sahibi adı KVKK gereği çıkarılmıştır. Tabloda 53 sütun vardır; aşağıda en önemli 19 sütun listelenmiştir, tüm sütunlar için docs/dbt_docs.html dosyasına bakınız. Sahibi: Eray.

| Sütun                | Tip     | Açıklama                                                                                                     |
| -------------------- | ------- | ------------------------------------------------------------------------------------------------------------ |
| ilan_id              | BIGINT  | İlanın benzersiz kimliği                                                                                     |
| mahalle              | VARCHAR | İlanın bulunduğu mahalle                                                                                     |
| mahalle_grubu        | VARCHAR | İlanın bağlı olduğu daha geniş mahalle grubu                                                                 |
| posta_kodu           | VARCHAR | İlanın 5 haneli posta kodu (metin); Census ile birleştirme anahtarı. Bazı ilanlarda boş                      |
| mulk_tipi            | VARCHAR | Mülk türü                                                                                                    |
| oda_tipi             | VARCHAR | Kiralanan alanın tipi: Tüm ev/daire, Özel oda veya Paylaşılan oda                                            |
| kapasite             | BIGINT  | İlanın ağırlayabileceği en fazla misafir sayısı                                                              |
| gecelik_fiyat_usd    | BIGINT  | İlanın gecelik fiyatı (USD)                                                                                  |
| temizlik_ucreti_usd  | BIGINT  | Temizlik ücreti (USD); ücret alınmayan ya da kaynakta boş olan ilanlarda 0                                   |
| min_gece             | BIGINT  | İlanın kabul ettiği en az gece sayısı                                                                        |
| iptal_politikasi     | VARCHAR | İptal politikasının katılığı: Esnek, Orta veya Katı                                                          |
| ev_sahibi_id         | BIGINT  | Ev sahibinin anonim kimliği                                                                                  |
| super_ev_sahibi      | BOOLEAN | Ev sahibi süper ev sahibi statüsündeyse true                                                                 |
| genel_puan_100       | BIGINT  | 100 üzerinden genel puan; yorum almamış ilanlarda boş                                                        |
| yorum_sayisi         | BIGINT  | İlanın aldığı yorum sayısı                                                                                   |
| takvim_gun_sayisi    | BIGINT  | Takvim döneminin toplam gün sayısı (tüm ilanlarda 365)                                                       |
| dolu_gun             | BIGINT  | Takvim döneminde müsait olmayan gün sayısı; rezerve edilmiş günler ile ev sahibinin kapattığı günleri içerir |
| doluluk_orani_yuzde  | DOUBLE  | Takvim dönemindeki rezervasyona kapalı gün yüzdesi (0–100)                                                   |
| takvim_ort_fiyat_usd | DOUBLE  | Takvim döneminde ilanın ortalama fiyatı (USD)                                                                |
