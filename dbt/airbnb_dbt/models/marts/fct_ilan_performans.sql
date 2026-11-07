with ilanlar as (
    select * from {{ ref('stg_ilanlar') }}
)

select
    ilan_id,
    ev_sahibi_id,
    mahalle,
    mahalle_grubu,
    posta_kodu,
    oda_tipi,
    mulk_tipi,
    kapasite,
    yatak_odasi_sayisi,
    iptal_politikasi,

    gecelik_fiyat_usd,
    temizlik_ucreti_usd,
    min_gece,
    round(gecelik_fiyat_usd / nullif(kapasite, 0), 2) as kisi_basi_fiyat_usd,
    gecelik_fiyat_usd * min_gece + coalesce(temizlik_ucreti_usd, 0) as min_konaklama_maliyeti_usd,
    case
        when gecelik_fiyat_usd is null then 'Bilinmiyor'
        when gecelik_fiyat_usd < 85 then 'Ekonomik'
        when gecelik_fiyat_usd < 130 then 'Orta'
        else 'Lüks'
    end as fiyat_segmenti,

    doluluk_orani_yuzde,
    dolu_gun,
    dolu_gun = takvim_gun_sayisi as takvim_tamamen_kapali,
    round(dolu_gun * coalesce(takvim_ort_fiyat_usd, gecelik_fiyat_usd), 0) as tahmini_yillik_gelir_usd,

    genel_puan_100,
    yorum_sayisi,
    genel_puan_100 is not null as puani_var

from ilanlar