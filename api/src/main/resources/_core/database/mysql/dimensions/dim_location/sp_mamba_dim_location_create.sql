-- $BEGIN

CREATE TABLE mamba_dim_location
(
    id              INT          NOT NULL AUTO_INCREMENT,
    location_id     INT          NOT NULL,
    name            VARCHAR(255) NOT NULL,
    description     VARCHAR(255) NULL,
    city_village    VARCHAR(255) NULL,
    state_province  VARCHAR(255) NULL,
    postal_code     VARCHAR(50)  NULL,
    country         VARCHAR(50)  NULL,
    latitude        VARCHAR(50)  NULL,
    longitude       VARCHAR(50)  NULL,
    county_district VARCHAR(255) NULL,
    address1        VARCHAR(255) NULL,
    address2        VARCHAR(255) NULL,
    address3        VARCHAR(255) NULL,
    address4        VARCHAR(255) NULL,
    address5        VARCHAR(255) NULL,
    address6        VARCHAR(255) NULL,
    address7        VARCHAR(255) NULL,
    address8        VARCHAR(255) NULL,
    address9        VARCHAR(255) NULL,
    address10       VARCHAR(255) NULL,
    address11       VARCHAR(255) NULL,
    address12       VARCHAR(255) NULL,
    address13       VARCHAR(255) NULL,
    address14       VARCHAR(255) NULL,
    address15       VARCHAR(255) NULL,
    date_created    DATETIME     NULL,
    changed_by      INT          NULL,
    date_changed    DATETIME     NULL,
    retired         TINYINT(1)   NULL,
    retired_by      INT          NULL,
    date_retired    DATETIME     NULL,
    retire_reason   VARCHAR(255) NULL,
    incremental_record INT DEFAULT 0 NOT NULL, -- whether a record has been inserted after the first ETL run,

    PRIMARY KEY (id)
)
    CHARSET = UTF8MB4;

CREATE INDEX mamba_dim_location_location_id_index
    ON mamba_dim_location (location_id);

CREATE INDEX mamba_dim_location_name_index
    ON mamba_dim_location (name);

CREATE INDEX mamba_dim_location_incremental_record_index
    ON mamba_dim_location (incremental_record);

-- $END
