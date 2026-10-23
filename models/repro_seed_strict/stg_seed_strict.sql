-- ZD 138972: seed-rooted chain where the seed itself is static_analysis: strict
select
    asset_camera_id
    , asset_id
    , camera_id
    , date_installed
    , date_uninstalled
from {{ ref('repro_seed_strict') }}
