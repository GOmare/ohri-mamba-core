DROP PROCEDURE IF EXISTS sp_mamba_flat_table_obs_incremental_insert;

DELIMITER //

CREATE PROCEDURE sp_mamba_flat_table_obs_incremental_insert(
    IN encounter_id INT,
    IN flat_encounter_table_name VARCHAR(60) CHARACTER SET UTF8MB4
)
BEGIN

    SET session group_concat_max_len = 20000;

    SET @enc_id = encounter_id;
    SET @tbl_name = flat_encounter_table_name;

    SELECT GROUP_CONCAT(DISTINCT
                        CONCAT(' MAX(CASE WHEN column_label = ''', column_label, ''' THEN ',
                               fn_mamba_get_obs_value_column(concept_datatype), ' END) ', column_label)
                        ORDER BY id ASC)
    INTO @column_labels
    FROM mamba_concept_metadata
    WHERE flat_table_name = @tbl_name;

    -- if enc_id exits in the table @tbl_name, then delete the record (to be replaced with the new one)
    SET @delete_stmt = CONCAT('DELETE FROM `', @tbl_name, '` WHERE encounter_id = ', @enc_id);
    PREPARE deletetb FROM @delete_stmt;
    EXECUTE deletetb;
    DEALLOCATE PREPARE deletetb;

    IF @column_labels IS NOT NULL THEN
        SET @insert_stmt = CONCAT(
                'INSERT INTO `', @tbl_name,
                '` SELECT o.encounter_id, MAX(o.visit_id) AS visit_id, o.person_id, o.encounter_datetime, MAX(o.location_id) AS location_id, ',
                @column_labels, '
                FROM mamba_z_encounter_obs o
                    INNER JOIN mamba_concept_metadata cm
                    ON IF(cm.concept_answer_obs=1, cm.concept_uuid=o.obs_value_coded_uuid, cm.concept_uuid=o.obs_question_uuid)
                WHERE cm.flat_table_name = ''', @tbl_name, '''
                AND o.encounter_id = ''', @enc_id, '''
                AND o.encounter_type_uuid = cm.encounter_type_uuid
                AND o.voided = 0
                GROUP BY o.encounter_id, o.person_id, o.encounter_datetime;');
    END IF;

    IF @column_labels IS NOT NULL THEN
        PREPARE inserttbl FROM @insert_stmt;
        EXECUTE inserttbl;
        DEALLOCATE PREPARE inserttbl;
    END IF;

END //

DELIMITER ;