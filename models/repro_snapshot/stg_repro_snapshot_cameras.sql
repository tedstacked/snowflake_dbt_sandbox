-- ZD 138972 repro: model on a seed that is strict only through the project-level seeds: block
select
    camera_id,
    device_serial
from {{ ref('repro_138972_cameras') }}
