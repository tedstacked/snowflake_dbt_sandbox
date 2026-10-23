{{ config(static_analysis='strict') }}
select
      ID,
      SETTLEMENT_TYPE,
      AMOUNT,
      CREATED_AT
  from {{ ref('settlement_credit_eod') }}
