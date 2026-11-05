with kaynak as (
    select * from {{ source('external', 'census_posta_kodu_2016') }}
)

select
    cast(zcta as varchar) as posta_kodu,
    B01003_001E as nufus,
    case when B19013_001E < 0 then null else B19013_001E end as medyan_hane_geliri_usd,
    case when B25064_001E < 0 then null else B25064_001E end as medyan_kira_usd
from kaynak