CREATE TABLE IF NOT EXISTS ${schema}.re_parted
(
    id numeric DEFAULT nextval('${schema}.re_seq'::regclass),
    data_ora_evento character varying(23) COLLATE pg_catalog."default" NOT NULL,
    identificativo_dominio character varying(35) COLLATE pg_catalog."default",
    identificativo_univoco_versamento character varying(35) COLLATE pg_catalog."default",
    codice_contesto_pagamento character varying(35) COLLATE pg_catalog."default",
    identificativo_prestatore_servizi_pagamento character varying(35) COLLATE pg_catalog."default",
    tipo_versamento character varying(35) COLLATE pg_catalog."default",
    componente character varying(35) COLLATE pg_catalog."default" NOT NULL,
    categoria_evento character varying(35) COLLATE pg_catalog."default" NOT NULL,
    tipo_evento character varying(35) COLLATE pg_catalog."default",
    sotto_tipo_evento character varying(35) COLLATE pg_catalog."default" NOT NULL,
    identificativo_fruitore character varying(35) COLLATE pg_catalog."default",
    identificativo_erogatore character varying(35) COLLATE pg_catalog."default",
    identificativo_stazione_intermediario_pa character varying(35) COLLATE pg_catalog."default",
    canale_pagamento character varying(35) COLLATE pg_catalog."default",
    parametri_specifici_interfaccia character varying(512) COLLATE pg_catalog."default",
    esito character varying(30) COLLATE pg_catalog."default",
    id_sessione character varying(36) COLLATE pg_catalog."default",
    status character varying(35) COLLATE pg_catalog."default",
    payload bytea,
    info character varying(255) COLLATE pg_catalog."default",
    inserted_timestamp timestamp(6) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    business_process character varying(255) COLLATE pg_catalog."default",
    fruitore_descr character varying(255) COLLATE pg_catalog."default",
    erogatore_descr character varying(255) COLLATE pg_catalog."default",
    psp_descr character varying(255) COLLATE pg_catalog."default",
    notice_id character varying(100) COLLATE pg_catalog."default",
    creditor_reference_id character varying(100) COLLATE pg_catalog."default",
    payment_token character varying(100) COLLATE pg_catalog."default",
    id_sessione_originale character varying(36) COLLATE pg_catalog."default",
    id_eventhub character varying(36) COLLATE pg_catalog."default",
    flag_standin character(1) COLLATE pg_catalog."default"
) partition by range ("inserted_timestamp");

--

DROP TABLE IF EXISTS ${schema}.tab_part; -- TODO remove
