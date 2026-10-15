-- ZD 138972 control: simplest possible column lineage (plain passthrough)
select
    camera_id
    , date_installed
from {{ ref('stg_repro_138972__asset_camera_assignments') }}
