{{ config(static_analysis='strict') }}
select
      1 as ID,
      'credit' as SETTLEMENT_TYPE,
      cast(10.50 as number(10, 2)) as AMOUNT,
      cast('2026-01-01 00:00:00' as timestamp_ntz) as CREATED_AT
union all
select
      2 as ID,
      'debit' as SETTLEMENT_TYPE,
      cast(20.25 as number(10, 2)) as AMOUNT,
      cast('2026-01-02 00:00:00' as timestamp_ntz) as CREATED_AT
