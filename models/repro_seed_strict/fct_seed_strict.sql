select
    camera_id
    , date_installed
from {{ ref('stg_seed_strict') }}
