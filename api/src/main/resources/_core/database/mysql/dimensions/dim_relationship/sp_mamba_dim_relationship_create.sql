-- $BEGIN
CREATE TABLE mamba_dim_relationship
(

    relationship_id INT          NOT NULL AUTO_INCREMENT,
    person_a        INT          NOT NULL,
    relationship    INT          NOT NULL,
    person_b        INT          NOT NULL,
    start_date      DATETIME     NULL,
    end_date        DATETIME     NULL,
    creator         INT          NOT NULL,
    date_created    DATETIME     NOT NULL,
    date_changed    DATETIME     NULL,
    changed_by      INT          NULL,
    voided          TINYINT(1)   NOT NULL,
    voided_by       INT          NULL,
    date_voided     DATETIME     NULL,
    void_reason     VARCHAR(255) NULL,
    uuid            CHAR(38)     NOT NULL,
    flag            INT          NULL,

    PRIMARY KEY (relationship_id)

) CHARSET = UTF8MB3;

CREATE INDEX mamba_dim_relationship_person_a_index
    ON mamba_dim_relationship (person_a);

CREATE INDEX mamba_dim_relationship_person_b_index
    ON mamba_dim_relationship (person_b);

-- $END
