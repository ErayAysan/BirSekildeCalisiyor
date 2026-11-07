with ilanlar as (
    select * from {{ ref('stg_ilanlar') }}
),

census as (
    select * from {{ ref('stg_census_posta_kodu') }}
),

ilan_census as (
    select
        ilanlar.*,
        census.nufus,
        census.medyan_hane_geliri_usd,
        census.medyan_kira_usd
    from ilanlar
    left join census
        on ilanlar.posta_kodu = census.posta_kodu
)

select
    mahalle_grubu,
    count(*)                                                    as ilan_sayisi,
    round(avg(gecelik_fiyat_usd), 2)                            as ort_gecelik_fiyat_usd,
    round(median(gecelik_fiyat_usd), 2)                         as medyan_gecelik_fiyat_usd,
    round(avg(case when dolu_gun < takvim_gun_sayisi
                   then doluluk_orani_yuzde end), 1)            as ort_doluluk_orani_yuzde,
    round(avg(genel_puan_100), 1)                               as ort_genel_puan_100,
    round(avg(case when super_ev_sahibi then 1.0 else 0.0 end) * 100, 1)
                                                                as super_ev_sahibi_yuzdesi,
    round(avg(medyan_hane_geliri_usd), 0)                       as bolge_medyan_geliri_usd,
    round(avg(medyan_kira_usd), 0)                              as bolge_medyan_kira_usd,
    round(avg(gecelik_fiyat_usd) * 30 / nullif(avg(medyan_kira_usd), 0), 2)
                                                                as airbnb_kira_orani,
    round(avg(enlem), 5)                                        as ort_enlem,
    round(avg(boylam), 5)                                       as ort_boylam,
    cast(round(avg(enlem), 5) as varchar) || ','
        || cast(round(avg(boylam), 5) as varchar)               as konum

from ilan_census
group by mahalle_grubu