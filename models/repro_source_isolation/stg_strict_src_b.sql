-- ZD 138972: control, source WITH static_analysis strict
with source as (

    select * from {{ source('repro_src_strict_b', 'repro_138972_cameras') }}

)

select
    camera_id
    , device_serial
from source
