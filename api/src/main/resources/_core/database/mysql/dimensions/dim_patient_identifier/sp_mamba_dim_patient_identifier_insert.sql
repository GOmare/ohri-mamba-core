-- $BEGIN

INSERT INTO mamba_dim_patient_identifier (patient_id,
                                          identifier,
                                          identifier_type,
                                          preferred,
                                          location_id,
                                          date_created,
                                          uuid,
                                          voided,
                                          date_changed,
                                          changed_by,
                                          voided_by,
                                          date_voided,
                                          void_reason)
SELECT patient_id,
       identifier,
       identifier_type,
       preferred,
       location_id,
       date_created,
       uuid,
       voided,
       date_changed,
       changed_by,
       voided_by,
       date_voided,
       void_reason
FROM mamba_source_db.patient_identifier;

-- $END