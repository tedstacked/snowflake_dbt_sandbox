-- ZD 138972: passthrough staging model, same shape as
-- stg_equipmentshare__public__silver__asset_camera_assignments
with source as (

    select * from {{ ref('repro_138972_asset_camera_assignments') }}

)

select
    asset_camera_id
    , asset_id
    , camera_id
    , date_installed
    , date_uninstalled
from source
