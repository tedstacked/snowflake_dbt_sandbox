select
    camera_id
    , date_installed
from {{ ref('stg_src_assignments') }}
