-- ZD 138972: source WITHOUT static_analysis strict (EquipmentShare's setup)
with source as (

    select * from {{ source('repro_src_plain', 'repro_seed_strict') }}

)

select
    asset_camera_id
    , camera_id
    , date_installed
from source
where date_uninstalled is null
