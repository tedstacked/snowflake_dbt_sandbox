select
    id
    , amount
    , session_id
from {{ ref('r138972_settlement_credit_eod') }}
