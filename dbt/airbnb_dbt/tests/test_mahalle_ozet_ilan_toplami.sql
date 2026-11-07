with ozet as (
    select sum(ilan_sayisi) as toplam from {{ ref('mart_mahalle_ozet') }}
),

kaynak as (
    select count(*) as toplam from {{ ref('stg_ilanlar') }}
)

select
    ozet.toplam   as ozet_toplam,
    kaynak.toplam as kaynak_toplam
from ozet, kaynak
where ozet.toplam != kaynak.toplam