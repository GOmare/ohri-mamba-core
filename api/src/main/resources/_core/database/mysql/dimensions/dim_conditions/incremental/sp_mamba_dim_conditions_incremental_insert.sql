-- $BEGIN

-- Insert only new records
INSERT INTO mamba_dim_conditions (condition_id,
                                  additional_detail,
                                  previous_version,
                                  condition_coded,
                                  condition_non_coded,
                                  condition_coded_name,
                                  clinical_status,
                                  verification_status,
                                  onset_date,
                                  date_created,
                                  voided,
                                  date_voided,
                                  void_reason,
                                  uuid,
                                  creator,
                                  voided_by,
                                  changed_by,
                                  patient_id,
                                  end_date,
                                  date_changed,
                                  encounter_id,
                                  form_namespace_and_path,
                                  incremental_record)

SELECT
    condition_id,
    additional_detail,
    previous_version,
    condition_coded,
    condition_non_coded,
    condition_coded_name,
    clinical_status,
    verification_status,
    onset_date,
    c.date_created,
    c.voided,
    c.date_voided,
    c.void_reason,
    c.uuid,
    c.creator,
    c.voided_by,
    c.changed_by,
    c.patient_id,
    c.end_date,
    c.date_changed,
    c.encounter_id,
    c.form_namespace_and_path,
    1
FROM mamba_source_db.conditions c
         INNER JOIN mamba_etl_incremental_columns_index_new ic
                    ON c.conditions = ic.incremental_table_pkey
         INNER JOIN mamba_dim_patient p
                    ON c.patient_id = p.patient_id

-- $END