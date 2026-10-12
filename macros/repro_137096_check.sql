{% macro repro_137096_check() %}
  {% set db = target.database %}
  {% set sch = target.schema | upper %}
  {% set q1 %}
    select t.table_name, t.table_type, coalesce(v.is_secure, '-') as is_secure
    from {{ db }}.information_schema.tables t
    left join {{ db }}.information_schema.views v
      on v.table_schema = t.table_schema and v.table_name = t.table_name
    where t.table_schema = '{{ sch }}' and t.table_name like 'LVP_%'
    order by 1
  {% endset %}
  {% set r1 = run_query(q1) %}
  {{ log('REPRO137096 OBJECTS (name | type | is_secure):', info=True) }}
  {% for row in r1.rows %}
    {{ log('REPRO137096 ' ~ row[0] ~ ' | ' ~ row[1] ~ ' | ' ~ row[2], info=True) }}
  {% endfor %}
  {% set q2 %}
    select table_name, privilege_type, grantee
    from {{ db }}.information_schema.table_privileges
    where table_schema = '{{ sch }}' and table_name like 'LVP_%' and grantee = 'PUBLIC'
    order by 1
  {% endset %}
  {% set r2 = run_query(q2) %}
  {{ log('REPRO137096 PUBLIC GRANTS (name | privilege | grantee):', info=True) }}
  {% for row in r2.rows %}
    {{ log('REPRO137096 ' ~ row[0] ~ ' | ' ~ row[1] ~ ' | ' ~ row[2], info=True) }}
  {% endfor %}
{% endmacro %}
