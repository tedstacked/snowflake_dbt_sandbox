-- ZD 141212 repro control: same 180 s query, no warning. Expected to stay under Running.
{{ config(
    materialized='table',
    static_analysis='off'
) }}
select system$wait(180) as waited_seconds
