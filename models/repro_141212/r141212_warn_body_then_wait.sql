-- ZD 141212 repro variant: the warning is in the model body, gated on `execute`.
{{ config(
    materialized='table',
    static_analysis='off'
) }}
{% if execute %}{% do exceptions.warn('ZD 141212 repro (body): node-level warning while the model is still running') %}{% endif %}
select system$wait(180) as waited_seconds
