-- ZD 138972 repro: model on top of a strict snapshot (like int_companies_es_companies_versions)
select
    asset_camera_id,
    camera_id,
    date_installed,
    dbt_valid_from,
    dbt_valid_to
from {{ ref('repro_cameras_snapshot') }}
