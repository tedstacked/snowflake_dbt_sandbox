select
    id
    , amount
    , session_id
from {{ ref('r138972_stg_foo') }}
