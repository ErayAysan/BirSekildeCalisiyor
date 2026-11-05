select
    posta_kodu,
    nufus,
    medyan_hane_geliri_usd,
    medyan_kira_usd
from {{ ref('stg_census_posta_kodu') }}
where nufus < 0
   or medyan_hane_geliri_usd < 0
   or medyan_kira_usd < 0