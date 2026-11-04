select
    ilan_id,
    gecelik_fiyat_usd,
    doluluk_orani_yuzde
from {{ ref('stg_ilanlar') }}
where gecelik_fiyat_usd <= 0
   or doluluk_orani_yuzde < 0
   or doluluk_orani_yuzde > 100