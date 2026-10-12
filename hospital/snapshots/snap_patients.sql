-- Crie este arquivo na pasta snapshots/snap_patients.sql
{% snapshot snap_patients %}

{{
    config(
      target_database='HOSPITAL_DB',
      target_schema='SNAPSHOTS',
      unique_key='patient_id',
      strategy='check',
      check_cols=['patient_name', 'blood_type', 'patient_gender'],
    )
}}

select * from {{ ref('stg_patients') }}

{% endsnapshot %}