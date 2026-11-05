select
    ev_sahibi_id,
    deneyim_yili,
    seattle_ilan_sayisi
from {{ ref('dim_ev_sahibi') }}
where deneyim_yili < 0
   or seattle_ilan_sayisi < 1