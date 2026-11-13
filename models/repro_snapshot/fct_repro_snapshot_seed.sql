-- ZD 138972 repro: a fact with both a snapshot and a seed upstream (like fact_quotes)
select
    v.asset_camera_id,
    v.camera_id,
    c.device_serial,
    v.date_installed,
    v.dbt_valid_from
from {{ ref('int_repro_snapshot_versions') }} as v
left join {{ ref('stg_repro_snapshot_cameras') }} as c
    on v.camera_id = c.camera_id
