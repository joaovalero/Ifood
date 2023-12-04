-- Gerado por Oracle SQL Developer Data Modeler 21.4.2.059.0838
--   em:        2022-05-31 21:40:46 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_cli_endereco (
    cd_endereco          NUMBER NOT NULL,
    t_cliente_cd_cliente NUMBER NOT NULL,
    ds_endereco          VARCHAR2(30) NOT NULL,
    ds_complemento       VARCHAR2(30) NOT NULL,
    nr_cep               NUMBER NOT NULL,
    nr_endereco          NUMBER NOT NULL,
    nm_cidade            VARCHAR2(30) NOT NULL,
    nm_estado            VARCHAR2(30) NOT NULL,
    nm_bairro            VARCHAR2(30) NOT NULL
);

CREATE UNIQUE INDEX t_cliente_endereco__idx ON
    t_cli_endereco (
        t_cliente_cd_cliente
    ASC );

ALTER TABLE t_cli_endereco ADD CONSTRAINT t_cliente_endereco_pk PRIMARY KEY ( cd_endereco );

CREATE TABLE t_cliente (
    cd_cliente                 NUMBER NOT NULL,
    cd_sexo                    CHAR 
--  WARNING: CHAR size not specified 
     NOT NULL,
    t_cli_endereco_cd_endereco NUMBER NOT NULL,
    ds_nome_cliente            VARCHAR2(50) NOT NULL,
    ds_sobrenome_cliente       VARCHAR2(50) NOT NULL,
    dt_nasc_cliente            DATE NOT NULL,
    nr_cpf_cliente             NUMBER(11) NOT NULL,
    nr_rg_cliente              NUMBER(9) NOT NULL,
    t_sexo_cd_sexo             NUMBER NOT NULL
);

CREATE UNIQUE INDEX t_cliente__idx ON
    t_cliente (
        t_cli_endereco_cd_endereco
    ASC );

CREATE UNIQUE INDEX t_cliente__idxv1 ON
    t_cliente (
        cd_sexo
    ASC );

ALTER TABLE t_cliente ADD CONSTRAINT t_cliente_pk PRIMARY KEY ( cd_cliente );

CREATE TABLE t_entregador (
    cd_entregador           NUMBER NOT NULL,
    t_sexo_cd_sexo          CHAR 
--  WARNING: CHAR size not specified 
     NOT NULL,
    ds_nome_entregador      VARCHAR2(50) NOT NULL,
    ds_sobrenome_entregador VARCHAR2(50) NOT NULL,
    dt_nasc_entregador      DATE NOT NULL,
    nr_cpf_entregador       NUMBER(11) NOT NULL,
    nr_rg_entregador        NUMBER(9) NOT NULL,
    nr_avaliacao            NUMBER(5) NOT NULL,
    t_sexo_cd_sexo1         NUMBER NOT NULL
);

CREATE UNIQUE INDEX t_entregador__idx ON
    t_entregador (
        t_sexo_cd_sexo
    ASC );

ALTER TABLE t_entregador ADD CONSTRAINT t_entregador_pk PRIMARY KEY ( cd_entregador );

CREATE TABLE t_estabelecimento (
    nr_cnpj         NUMBER NOT NULL,
    ds_razao_social VARCHAR2(50) NOT NULL,
    nm_fantasia     VARCHAR2(50) NOT NULL,
    ds_categoria    VARCHAR2(30) NOT NULL,
    nr_avaliacao    NUMBER(5) NOT NULL
);

ALTER TABLE t_estabelecimento ADD CONSTRAINT t_estabelecimento_pk PRIMARY KEY ( nr_cnpj );

CREATE TABLE t_metodo_pagamento (
    cd_pagamento         NUMBER NOT NULL,
    t_cliente_cd_cliente NUMBER NOT NULL,
    ds_metodo_pagamento  VARCHAR2(10) NOT NULL,
    ds_bandeira_cartao   VARCHAR2(20) NOT NULL
);

ALTER TABLE t_metodo_pagamento ADD CONSTRAINT t_metodo_pagamento_pk PRIMARY KEY ( cd_pagamento,
                                                                                  t_cliente_cd_cliente );

CREATE TABLE t_pedido (
    cd_pedido                  NUMBER NOT NULL,
    t_cliente_cd_cliente       NUMBER NOT NULL,
    t_estabelecimento_nr_cnpj  NUMBER NOT NULL,
    t_entregador_cd_entregador NUMBER NOT NULL,
    t_status_pedido_cd_status  NUMBER NOT NULL,
    ds_pedido                  VARCHAR2(30) NOT NULL,
    vl_pedido                  NUMBER(7, 2) NOT NULL,
    dt_hr_pedido               DATE NOT NULL,
    dt_hr_entrega_pedido       DATE NOT NULL,
    ds_quantidade              NUMBER NOT NULL,
    tp_entrega                 VARCHAR2(30) NOT NULL
);

CREATE UNIQUE INDEX t_pedido__idx ON
    t_pedido (
        t_status_pedido_cd_status
    ASC );

ALTER TABLE t_pedido ADD CONSTRAINT t_pedido_pk PRIMARY KEY ( cd_pedido,
                                                              t_cliente_cd_cliente );

CREATE TABLE t_sexo (
    cd_sexo       NUMBER NOT NULL,
    cd_entregador NUMBER NOT NULL,
    ds_sexo       VARCHAR2(9) NOT NULL,
    cd_cliente    NUMBER NOT NULL
);

CREATE UNIQUE INDEX t_sexo__idx ON
    t_sexo (
        cd_entregador
    ASC );

CREATE UNIQUE INDEX t_sexo__idxv1 ON
    t_sexo (
        cd_cliente
    ASC );

ALTER TABLE t_sexo ADD CONSTRAINT t_sexo_pk PRIMARY KEY ( cd_sexo );

CREATE TABLE t_status_pedido (
    cd_status                     NUMBER NOT NULL,
    t_pedido_cd_pedido            NUMBER NOT NULL,
    ds_status                     VARCHAR2(30) NOT NULL,
    t_pedido_t_cliente_cd_cliente NUMBER NOT NULL
);

CREATE UNIQUE INDEX t_status_pedido__idx ON
    t_status_pedido (
        t_pedido_cd_pedido
    ASC );

CREATE UNIQUE INDEX t_status_pedido__idxv1 ON
    t_status_pedido (
        t_pedido_cd_pedido
    ASC,
        t_pedido_t_cliente_cd_cliente
    ASC );

ALTER TABLE t_status_pedido ADD CONSTRAINT t_status_pedido_pk PRIMARY KEY ( cd_status );

CREATE TABLE t_telefone (
    nr_fone_completo          NUMBER(11) NOT NULL,
    t_estabelecimento_nr_cnpj NUMBER NOT NULL,
    t_cliente_cd_cliente      NUMBER NOT NULL,
    t_tipo_fone_cd_tipo_fone  NUMBER NOT NULL,
    nr_telefone               NUMBER(9) NOT NULL,
    nr_ddd                    NUMBER(2) NOT NULL
);

CREATE UNIQUE INDEX t_telefone__idx ON
    t_telefone (
        t_tipo_fone_cd_tipo_fone
    ASC );

ALTER TABLE t_telefone ADD CONSTRAINT t_telefone_pk PRIMARY KEY ( nr_fone_completo,
                                                                  t_cliente_cd_cliente );

CREATE TABLE t_tipo_fone (
    cd_tipo_fone                NUMBER NOT NULL,
    t_telefone_nr_fone_completo NUMBER(11) NOT NULL,
    ds_tipo_fone                VARCHAR2(10) NOT NULL,
    cd_cliente                  NUMBER NOT NULL
);

CREATE UNIQUE INDEX t_tipo_fone__idx ON
    t_tipo_fone (
        t_telefone_nr_fone_completo
    ASC );

CREATE UNIQUE INDEX t_tipo_fone__idxv1 ON
    t_tipo_fone (
        t_telefone_nr_fone_completo
    ASC,
        cd_cliente
    ASC );

ALTER TABLE t_tipo_fone ADD CONSTRAINT t_tipo_fone_pk PRIMARY KEY ( cd_tipo_fone );

ALTER TABLE t_cli_endereco
    ADD CONSTRAINT t_cli_endereco_t_cliente_fk FOREIGN KEY ( t_cliente_cd_cliente )
        REFERENCES t_cliente ( cd_cliente );

ALTER TABLE t_metodo_pagamento
    ADD CONSTRAINT t_cliente_fk FOREIGN KEY ( t_cliente_cd_cliente )
        REFERENCES t_cliente ( cd_cliente );

ALTER TABLE t_cliente
    ADD CONSTRAINT t_cliente_t_cli_endereco_fk FOREIGN KEY ( t_cli_endereco_cd_endereco )
        REFERENCES t_cli_endereco ( cd_endereco );

ALTER TABLE t_cliente
    ADD CONSTRAINT t_cliente_t_sexo_fk FOREIGN KEY ( t_sexo_cd_sexo )
        REFERENCES t_sexo ( cd_sexo );

ALTER TABLE t_entregador
    ADD CONSTRAINT t_entregador_t_sexo_fk FOREIGN KEY ( t_sexo_cd_sexo1 )
        REFERENCES t_sexo ( cd_sexo );

ALTER TABLE t_telefone
    ADD CONSTRAINT t_estabelecimento_fk FOREIGN KEY ( t_estabelecimento_nr_cnpj )
        REFERENCES t_estabelecimento ( nr_cnpj );

ALTER TABLE t_pedido
    ADD CONSTRAINT t_pedido_t_cliente_fk FOREIGN KEY ( t_cliente_cd_cliente )
        REFERENCES t_cliente ( cd_cliente );

ALTER TABLE t_pedido
    ADD CONSTRAINT t_pedido_t_entregador_fk FOREIGN KEY ( t_entregador_cd_entregador )
        REFERENCES t_entregador ( cd_entregador );

ALTER TABLE t_pedido
    ADD CONSTRAINT t_pedido_t_estabelecimento_fk FOREIGN KEY ( t_estabelecimento_nr_cnpj )
        REFERENCES t_estabelecimento ( nr_cnpj );

ALTER TABLE t_pedido
    ADD CONSTRAINT t_pedido_t_status_pedido_fk FOREIGN KEY ( t_status_pedido_cd_status )
        REFERENCES t_status_pedido ( cd_status );

ALTER TABLE t_sexo
    ADD CONSTRAINT t_sexo_t_cliente_fk FOREIGN KEY ( cd_cliente )
        REFERENCES t_cliente ( cd_cliente );

ALTER TABLE t_sexo
    ADD CONSTRAINT t_sexo_t_entregador_fk FOREIGN KEY ( cd_entregador )
        REFERENCES t_entregador ( cd_entregador );

ALTER TABLE t_status_pedido
    ADD CONSTRAINT t_status_pedido_t_pedido_fk FOREIGN KEY ( t_pedido_cd_pedido )
        REFERENCES t_pedido ( cd_pedido,
                              t_cliente_cd_cliente );

ALTER TABLE t_telefone
    ADD CONSTRAINT t_telefone_t_cliente_fk FOREIGN KEY ( t_cliente_cd_cliente )
        REFERENCES t_cliente ( cd_cliente );

ALTER TABLE t_telefone
    ADD CONSTRAINT t_telefone_t_tipo_fone_fk FOREIGN KEY ( t_tipo_fone_cd_tipo_fone )
        REFERENCES t_tipo_fone ( cd_tipo_fone );

ALTER TABLE t_tipo_fone
    ADD CONSTRAINT t_tipo_fone_t_telefone_fk FOREIGN KEY ( t_telefone_nr_fone_completo )
        REFERENCES t_telefone ( nr_fone_completo,
                                t_cliente_cd_cliente );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                            12
-- ALTER TABLE                             26
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 2
