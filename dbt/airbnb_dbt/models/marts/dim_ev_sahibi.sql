with ilanlar as (
    select * from {{ ref('stg_ilanlar') }}
),
ev_sahipleri as (
    select
        ev_sahibi_id,
        any_value(ev_sahibi_baslangic_tarihi) as ev_sahibi_baslangic_tarihi,
        any_value(super_ev_sahibi) as super_ev_sahibi,
        any_value(kimlik_dogrulandi) as kimlik_dogrulandi,
        any_value(yanit_suresi) as yanit_suresi,
        any_value(yanit_orani_yuzde) as yanit_orani_yuzde,
        any_value(kabul_orani_yuzde) as kabul_orani_yuzde,
        any_value(ev_sahibi_ilan_sayisi) as platform_ilan_sayisi,
        count(*) as seattle_ilan_sayisi,
        round(avg(gecelik_fiyat_usd), 2) as ort_gecelik_fiyat_usd,
        round(avg(genel_puan_100), 1) as ort_genel_puan_100,
        round(avg(doluluk_orani_yuzde), 1) as ort_doluluk_orani_yuzde,
        sum(yorum_sayisi) as toplam_yorum_sayisi,
        min(takvim_baslangic) as veri_tarihi
    from ilanlar
    group by ev_sahibi_id
)
select
    ev_sahibi_id,
    ev_sahibi_baslangic_tarihi,
    round(date_diff('day', ev_sahibi_baslangic_tarihi, veri_tarihi) / 365.25, 1) as deneyim_yili,
    super_ev_sahibi,
    kimlik_dogrulandi,
    yanit_suresi,
    yanit_orani_yuzde,
    kabul_orani_yuzde,
    platform_ilan_sayisi,
    seattle_ilan_sayisi,
    seattle_ilan_sayisi > 1 as profesyonel_ev_sahibi,
    ort_gecelik_fiyat_usd,
    ort_genel_puan_100,
    ort_doluluk_orani_yuzde,
    toplam_yorum_sayisi
from ev_sahipleri