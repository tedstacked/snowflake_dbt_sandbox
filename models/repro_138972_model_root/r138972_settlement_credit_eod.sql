-- ZD 138972: model-rooted chain mirroring the working dbt#15396 repro
-- (settlement_credit_eod -> stg_foo -> foo), but on Snowflake.
select
    1 as id
    , cast(10.50 as number(10, 2)) as amount
    , 'abc' as session_id
union all
select
    2 as id
    , cast(20.25 as number(10, 2)) as amount
    , 'def' as session_id
