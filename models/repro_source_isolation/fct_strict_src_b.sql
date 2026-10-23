select
    camera_id
    , device_serial
from {{ ref('stg_strict_src_b') }}
