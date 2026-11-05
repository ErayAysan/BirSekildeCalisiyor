select
    ilan_id,
    gecelik_fiyat_usd,
    kisi_basi_fiyat_usd,
    min_konaklama_maliyeti_usd
from {{ ref('fct_ilan_performans') }}
where kisi_basi_fiyat_usd <= 0
   or min_konaklama_maliyeti_usd <= 0
   or kisi_basi_fiyat_usd > gecelik_fiyat_usd