-- ZD 141212 repro: a node-level WARN logged after the model has started, while its query is still running.
-- Expected UI bug: during the run the model is listed under the Warning tab instead of Running.
{{ config(
    materialized='table',
    static_analysis='off',
    pre_hook="{% do exceptions.warn('ZD 141212 repro: node-level warning while the model is still running') %}select 1"
) }}
select system$wait(180) as waited_seconds
