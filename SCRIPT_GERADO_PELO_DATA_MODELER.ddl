-- Gerado por Oracle SQL Developer Data Modeler 21.2.0.183.1957
--   em:        2021-08-31 11:09:57 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_pip_bairro (
    cd_bairro           NUMBER(10) NOT NULL,
    bairro_fk_cd_cidade NUMBER(10) NOT NULL,
    nm_bairro           VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_bairro ADD CONSTRAINT t_bairro_pk PRIMARY KEY ( cd_bairro );

CREATE TABLE t_pip_categoria_produto (
    cd_categoria_prod NUMBER NOT NULL,
    ds_categoria_prod VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_categoria_produto ADD CONSTRAINT t_pip_categoria_produto_pk PRIMARY KEY ( cd_categoria_prod );

CREATE TABLE t_pip_cidade (
    cd_cidade           NUMBER(10) NOT NULL,
    cidade_fk_cd_estado NUMBER(10) NOT NULL,
    nm_cidade           VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_cidade ADD CONSTRAINT t_cidade_pk PRIMARY KEY ( cd_cidade );

CREATE TABLE t_pip_cliente (
    cd_cliente                  NUMBER(10) NOT NULL,
    tcliente_fk_cd_tipo_cliente NUMBER(10) NOT NULL,
    nm_cliente                  VARCHAR2(60) NOT NULL,
    ds_email                    VARCHAR2(40)
);

ALTER TABLE t_pip_cliente
    ADD CONSTRAINT arc_1_lov CHECK ( tcliente_fk_cd_tipo_cliente IN ( tcliente_fk_cod_tipo_cliente, tcliente_fk_cod_tipo_cliente ) );

ALTER TABLE t_pip_cliente ADD CONSTRAINT t_cliente_pk PRIMARY KEY ( cd_cliente );

CREATE TABLE t_pip_cliente_endereco (
    cend_fk_cd_cliente NUMBER(10) NOT NULL,
    cend_fk_nr_cep     NUMBER(8) NOT NULL,
    nr_endereco        NUMBER(5) NOT NULL,
    ds_complemento     VARCHAR2(30)
);

ALTER TABLE t_pip_cliente_endereco ADD CONSTRAINT t_cliente_endereco_pk PRIMARY KEY ( cend_fk_cd_cliente,
                                                                                      cend_fk_nr_cep );

CREATE TABLE t_pip_cor (
    cd_cor NUMBER NOT NULL,
    ds_cor VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_cor ADD CONSTRAINT t_pip_cor_pk PRIMARY KEY ( cd_cor );

CREATE TABLE t_pip_endereço (
    nr_cep                NUMBER(8) NOT NULL,
    end_fk_cd_tipo_lograd NUMBER(10) NOT NULL,
    end_fk_cd_bairro      NUMBER(10) NOT NULL,
    ds_logradouro         VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_endereço ADD CONSTRAINT t_endereço_pk PRIMARY KEY ( nr_cep );

CREATE TABLE t_pip_entregador (
    cd_entregador               NUMBER NOT NULL,
    entregador_fk_cd_loja       NUMBER(2) NOT NULL,
    entregador_fk_cd_fornecedor NUMBER(10) NOT NULL,
    nm_entregador               VARCHAR2(30) NOT NULL,
    dt_entrega                  DATE NOT NULL
);

ALTER TABLE t_pip_entregador ADD CONSTRAINT t_entregador_pk PRIMARY KEY ( cd_entregador );

CREATE TABLE t_pip_estado (
    cd_estado NUMBER(10) NOT NULL,
    nm_estado VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_estado ADD CONSTRAINT t_estado_pk PRIMARY KEY ( cd_estado );

CREATE TABLE t_pip_estoque (
    cd_estoque            NUMBER(10) NOT NULL,
    estoque_fk_cd_produto NUMBER(10),
    estoque_fk_cd_loja    NUMBER(10) NOT NULL,
    estoque_loja_cd_loja  NUMBER(2) NOT NULL,
    qt_produto            NUMBER(20) NOT NULL
);

CREATE UNIQUE INDEX t_estoque__idx ON
    t_pip_estoque (
        estoque_loja_cd_loja
    ASC );

CREATE UNIQUE INDEX t_pip_estoque__idx ON
    t_pip_estoque (
        estoque_fk_cd_loja
    ASC );

ALTER TABLE t_pip_estoque ADD CONSTRAINT t_estoque_pk PRIMARY KEY ( cd_estoque );

CREATE TABLE t_pip_fornecedor (
    cd_fornecedor   NUMBER(10) NOT NULL,
    nm_fornecedor   VARCHAR2(30) NOT NULL,
    dr_area_atuante VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_fornecedor ADD CONSTRAINT t_fornecedor_pk PRIMARY KEY ( cd_fornecedor );

CREATE TABLE t_pip_funcionario (
    cd_funcionario       NUMBER(10) NOT NULL,
    func_fk_cd_tipo_func NUMBER(2) NOT NULL,
    func_fk_cd_loja      NUMBER(2) NOT NULL,
    vr_salario           NUMBER(10) NOT NULL,
    dt_contratação       DATE NOT NULL,
    dt_demissão          DATE,
    ds_endereco          VARCHAR2(30) NOT NULL,
    nr_cpf               NUMBER(11) NOT NULL,
    nm_funcionario       VARCHAR2(60) NOT NULL,
    cd_loja              NUMBER(10) NOT NULL
);

ALTER TABLE t_pip_funcionario
    ADD CONSTRAINT arc_2_lov CHECK ( func_fk_cd_tipo_func IN ( func_fk_cod_tipo_func, func_fk_cod_tipo_func, func_fk_cod_tipo_func ) );

CREATE UNIQUE INDEX t_un_funcionario__idx ON
    t_pip_funcionario (
        nr_cpf
    ASC );

ALTER TABLE t_pip_funcionario ADD CONSTRAINT t_funcionario_pk PRIMARY KEY ( cd_funcionario );

CREATE TABLE t_pip_gerente (
    gerente_fk_cd_funcionario NUMBER(10) NOT NULL,
    ds_escolaridade           VARCHAR2(30) NOT NULL,
    cd_gerente                NUMBER(10) NOT NULL
);

ALTER TABLE t_pip_gerente ADD CONSTRAINT t_gerente_pk PRIMARY KEY ( gerente_fk_cd_funcionario );

CREATE TABLE t_pip_loja (
    cd_loja            NUMBER(2) NOT NULL,
    loja_fk_cd_estoque NUMBER(10) NOT NULL,
    dr_endereço        VARCHAR2(30) NOT NULL
);

CREATE UNIQUE INDEX t_loja__idx ON
    t_pip_loja (
        loja_fk_cd_estoque
    ASC );

ALTER TABLE t_pip_loja ADD CONSTRAINT t_loja_pk PRIMARY KEY ( cd_loja );

CREATE TABLE t_pip_marca (
    cd_marca NUMBER(10) NOT NULL,
    nm_marca VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_marca ADD CONSTRAINT t_marca_pk PRIMARY KEY ( cd_marca );

CREATE TABLE t_pip_nota_fiscal (
    cd_nota_fiscal             NUMBER(44) NOT NULL,
    notafiscal_fk_cd_transport NUMBER(10) NOT NULL,
    dr_data_emissao            DATE NOT NULL,
    hr_emissao                 DATE NOT NULL
);

ALTER TABLE t_pip_nota_fiscal ADD CONSTRAINT t_nota_fiscal_pk PRIMARY KEY ( cd_nota_fiscal );

CREATE TABLE t_pip_pedido (
    cd_pedido                NUMBER(20) NOT NULL,
    pedido_fk_cd_cliente     NUMBER(10) NOT NULL,
    pedido_fk_cd_nota_fiscal NUMBER(20) NOT NULL,
    pedido_fk_cd_funcionario NUMBER(10) NOT NULL,
    dt_pedido                DATE NOT NULL,
    vr_pedido                NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX t_pedido__idx ON
    t_pip_pedido (
        pedido_fk_cd_nota_fiscal
    ASC );

ALTER TABLE t_pip_pedido ADD CONSTRAINT t_pedido_pk PRIMARY KEY ( cd_pedido );

CREATE TABLE t_pip_pedido_produto (
    pedidoproduto_fk_cd_produto NUMBER(10) NOT NULL,
    pedidoproduto_fk_cd_pedido  NUMBER(20) NOT NULL,
    qt_vendida                  NUMBER(20) NOT NULL,
    vr_vend_unitario            NUMBER(20) NOT NULL
);

ALTER TABLE t_pip_pedido_produto ADD CONSTRAINT t_produto_nf_pk PRIMARY KEY ( pedidoproduto_fk_cd_produto,
                                                                              pedidoproduto_fk_cd_pedido );

CREATE TABLE t_pip_pessoa_fisica (
    pfisica_fk_cd_cliente NUMBER(10) NOT NULL,
    nr_cpf                NUMBER(11) NOT NULL,
    nr_rg                 NUMBER(12),
    dt_nascimento         DATE
);

CREATE UNIQUE INDEX t_un_pessoa_fisica__idx ON
    t_pip_pessoa_fisica (
        nr_cpf
    ASC );

ALTER TABLE t_pip_pessoa_fisica ADD CONSTRAINT t_pessoa_fisica_pk PRIMARY KEY ( pfisica_fk_cd_cliente );

CREATE TABLE t_pip_pessoa_juridicav2 (
    pjuridica_fk_cd_cliente NUMBER(10) NOT NULL,
    nr_cnpj                 NUMBER(14) NOT NULL,
    ds_razo_social          VARCHAR2(30) NOT NULL,
    ds_ramo_ativ            VARCHAR2(30) NOT NULL
);

CREATE UNIQUE INDEX t_un_pessoa_juridicav2__idx ON
    t_pip_pessoa_juridicav2 (
        nr_cnpj
    ASC );

ALTER TABLE t_pip_pessoa_juridicav2 ADD CONSTRAINT t_pessoa_juridicav2_pk PRIMARY KEY ( pjuridica_fk_cd_cliente );

CREATE TABLE t_pip_produto (
    cd_produto                   NUMBER(10) NOT NULL,
    produto_fk_cd_marca          NUMBER(10) NOT NULL,
    produto_fk_cd_categoria_prod NUMBER NOT NULL,
    produto_fk_cd_pedido         NUMBER(20),
    produto_fk_cd_unid_medida    NUMBER(4) NOT NULL,
    produto_fk_cd_cor            NUMBER NOT NULL,
    ds_nome                      VARCHAR2(30) NOT NULL,
    ds_descricao                 VARCHAR2(30) NOT NULL,
    vr_unitario                  NUMBER(10) NOT NULL
);

ALTER TABLE t_pip_produto ADD CONSTRAINT t_produto_pk PRIMARY KEY ( cd_produto );

CREATE TABLE t_pip_supervisor (
    supervisor_fk_cd_funcionario NUMBER(10) NOT NULL,
    cd_supervisor                NUMBER(10) NOT NULL,
    ds_hora_extra                NUMBER(10)
);

ALTER TABLE t_pip_supervisor ADD CONSTRAINT t_supervisor_pk PRIMARY KEY ( supervisor_fk_cd_funcionario );

CREATE TABLE t_pip_telefone (
    cd_telefone              NUMBER(10) NOT NULL,
    telefone_fk_cd_tipo_fone NUMBER(10) NOT NULL,
    telefone_fk_cd_cliente   NUMBER(10) NOT NULL,
    nr_telefone              NUMBER(11) NOT NULL,
    nm_ddd                   NUMBER(3) NOT NULL
);

ALTER TABLE t_pip_telefone ADD CONSTRAINT t_telefone_pk PRIMARY KEY ( cd_telefone );

CREATE TABLE t_pip_tipo_cliente (
    cd_tipo_cliente NUMBER(10) NOT NULL,
    ds_tipo_cliente VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_tipo_cliente ADD CONSTRAINT t_pip_tipo_cliente_pk PRIMARY KEY ( cd_tipo_cliente );

CREATE TABLE t_pip_tipo_func (
    cd_tipo_func NUMBER(2) NOT NULL,
    ds_tipo_func VARCHAR2(30)
);

ALTER TABLE t_pip_tipo_func ADD CONSTRAINT t_pip_tipo_func_pk PRIMARY KEY ( cd_tipo_func );

CREATE TABLE t_pip_tipo_logradouro (
    cd_tipo_logradouro NUMBER(10) NOT NULL,
    ds_tipo_logradouro VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_tipo_logradouro ADD CONSTRAINT t_tipo_logradouro_pk PRIMARY KEY ( cd_tipo_logradouro );

CREATE TABLE t_pip_tipo_telefone (
    cd_tipo_fone NUMBER(10) NOT NULL,
    ds_tipo_fone VARCHAR2(30)
);

ALTER TABLE t_pip_tipo_telefone ADD CONSTRAINT t_tipo_telefone_pk PRIMARY KEY ( cd_tipo_fone );

CREATE TABLE t_pip_transportadora (
    cd_transportadora NUMBER(10) NOT NULL,
    ds_razao_social   VARCHAR2(60) NOT NULL,
    nr_cnpj           NUMBER(14) NOT NULL
);

CREATE UNIQUE INDEX t_un_transportadora__idx ON
    t_pip_transportadora (
        nr_cnpj
    ASC );

ALTER TABLE t_pip_transportadora ADD CONSTRAINT t_transportadora_pk PRIMARY KEY ( cd_transportadora );

CREATE TABLE t_pip_unidade_medida (
    cd_unid_medida NUMBER(4) NOT NULL,
    ds_unid_medida VARCHAR2(30) NOT NULL
);

ALTER TABLE t_pip_unidade_medida ADD CONSTRAINT t_pip_unidade_medida_pk PRIMARY KEY ( cd_unid_medida );

CREATE TABLE t_pip_vendedor (
    vendedor_fk_cd_funcionario NUMBER(10) NOT NULL,
    qt_vendas                  NUMBER(20) NOT NULL,
    vr_comissao_vendas         NUMBER(10) NOT NULL
);

ALTER TABLE t_pip_vendedor ADD CONSTRAINT t_vendedor_pk PRIMARY KEY ( vendedor_fk_cd_funcionario );

ALTER TABLE t_pip_bairro
    ADD CONSTRAINT bairro_t_pip_cidade_fk FOREIGN KEY ( bairro_fk_cd_cidade )
        REFERENCES t_pip_cidade ( cd_cidade );

ALTER TABLE t_pip_cidade
    ADD CONSTRAINT cid_t_pip_estado_fk FOREIGN KEY ( cidade_fk_cd_estado )
        REFERENCES t_pip_estado ( cd_estado );

ALTER TABLE t_pip_cliente_endereco
    ADD CONSTRAINT cli_end_t_pip_cliente_fk FOREIGN KEY ( cend_fk_cd_cliente )
        REFERENCES t_pip_cliente ( cd_cliente );

ALTER TABLE t_pip_cliente_endereco
    ADD CONSTRAINT cli_end_t_pip_endereço_fk FOREIGN KEY ( cend_fk_nr_cep )
        REFERENCES t_pip_endereço ( nr_cep );

ALTER TABLE t_pip_cliente
    ADD CONSTRAINT cliente_tipo_cliente_fk FOREIGN KEY ( tcliente_fk_cd_tipo_cliente )
        REFERENCES t_pip_tipo_cliente ( cd_tipo_cliente );

ALTER TABLE t_pip_endereço
    ADD CONSTRAINT end_t_pip_tipo_lograd_fk FOREIGN KEY ( end_fk_cd_tipo_lograd )
        REFERENCES t_pip_tipo_logradouro ( cd_tipo_logradouro );

ALTER TABLE t_pip_endereço
    ADD CONSTRAINT endereço_t_pip_bairro_fk FOREIGN KEY ( end_fk_cd_bairro )
        REFERENCES t_pip_bairro ( cd_bairro );

ALTER TABLE t_pip_entregador
    ADD CONSTRAINT entregador_fornecedor_fk FOREIGN KEY ( entregador_fk_cd_fornecedor )
        REFERENCES t_pip_fornecedor ( cd_fornecedor );

ALTER TABLE t_pip_entregador
    ADD CONSTRAINT entregador_t_pip_loja_fk FOREIGN KEY ( entregador_fk_cd_loja )
        REFERENCES t_pip_loja ( cd_loja );

ALTER TABLE t_pip_funcionario
    ADD CONSTRAINT func_tipo_func_fk FOREIGN KEY ( func_fk_cd_tipo_func )
        REFERENCES t_pip_tipo_func ( cd_tipo_func );

ALTER TABLE t_pip_funcionario
    ADD CONSTRAINT funcionario_loja_fk FOREIGN KEY ( func_fk_cd_loja )
        REFERENCES t_pip_loja ( cd_loja );

ALTER TABLE t_pip_gerente
    ADD CONSTRAINT gerente_funcionario_fk FOREIGN KEY ( gerente_fk_cd_funcionario )
        REFERENCES t_pip_funcionario ( cd_funcionario );

ALTER TABLE t_pip_nota_fiscal
    ADD CONSTRAINT nota_fiscal_transport_fk FOREIGN KEY ( notafiscal_fk_cd_transport )
        REFERENCES t_pip_transportadora ( cd_transportadora );

ALTER TABLE t_pip_pedido_produto
    ADD CONSTRAINT ped_produto_pedido_fk FOREIGN KEY ( pedidoproduto_fk_cd_pedido )
        REFERENCES t_pip_pedido ( cd_pedido );

ALTER TABLE t_pip_pedido_produto
    ADD CONSTRAINT ped_produto_produto_fk FOREIGN KEY ( pedidoproduto_fk_cd_produto )
        REFERENCES t_pip_produto ( cd_produto );

ALTER TABLE t_pip_pedido
    ADD CONSTRAINT pedido_cliente_fk FOREIGN KEY ( pedido_fk_cd_cliente )
        REFERENCES t_pip_cliente ( cd_cliente );

ALTER TABLE t_pip_pedido
    ADD CONSTRAINT pedido_nota_fiscal_fk FOREIGN KEY ( pedido_fk_cd_nota_fiscal )
        REFERENCES t_pip_nota_fiscal ( cd_nota_fiscal );

ALTER TABLE t_pip_pedido
    ADD CONSTRAINT pedido_vendedor_fk FOREIGN KEY ( pedido_fk_cd_funcionario )
        REFERENCES t_pip_vendedor ( vendedor_fk_cd_funcionario );

ALTER TABLE t_pip_pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_cliente_fk FOREIGN KEY ( pfisica_fk_cd_cliente )
        REFERENCES t_pip_cliente ( cd_cliente );

ALTER TABLE t_pip_pessoa_juridicav2
    ADD CONSTRAINT pessoa_juridica_cliente_fk FOREIGN KEY ( pjuridica_fk_cd_cliente )
        REFERENCES t_pip_cliente ( cd_cliente );

ALTER TABLE t_pip_produto
    ADD CONSTRAINT prod_categoria_produto_fk FOREIGN KEY ( produto_fk_cd_categoria_prod )
        REFERENCES t_pip_categoria_produto ( cd_categoria_prod );

ALTER TABLE t_pip_produto
    ADD CONSTRAINT prod_cor_fk FOREIGN KEY ( produto_fk_cd_cor )
        REFERENCES t_pip_cor ( cd_cor );

ALTER TABLE t_pip_produto
    ADD CONSTRAINT prod_marca_fk FOREIGN KEY ( produto_fk_cd_marca )
        REFERENCES t_pip_marca ( cd_marca );

ALTER TABLE t_pip_produto
    ADD CONSTRAINT prod_unidade_medida_fk FOREIGN KEY ( produto_fk_cd_unid_medida )
        REFERENCES t_pip_unidade_medida ( cd_unid_medida );

ALTER TABLE t_pip_produto
    ADD CONSTRAINT produto_t_pedido_fk FOREIGN KEY ( produto_fk_cd_pedido )
        REFERENCES t_pip_pedido ( cd_pedido );

ALTER TABLE t_pip_supervisor
    ADD CONSTRAINT sup_funcionario_fk FOREIGN KEY ( supervisor_fk_cd_funcionario )
        REFERENCES t_pip_funcionario ( cd_funcionario );

ALTER TABLE t_pip_estoque
    ADD CONSTRAINT t_pip_estoque_t_pip_produto_fk FOREIGN KEY ( estoque_fk_cd_produto )
        REFERENCES t_pip_produto ( cd_produto );

ALTER TABLE t_pip_telefone
    ADD CONSTRAINT tele_cliente_fk FOREIGN KEY ( telefone_fk_cd_cliente )
        REFERENCES t_pip_cliente ( cd_cliente );

ALTER TABLE t_pip_telefone
    ADD CONSTRAINT tele_tipo_telefone_fk FOREIGN KEY ( telefone_fk_cd_tipo_fone )
        REFERENCES t_pip_tipo_telefone ( cd_tipo_fone );

ALTER TABLE t_pip_vendedor
    ADD CONSTRAINT vend_funcionario_fk FOREIGN KEY ( vendedor_fk_cd_funcionario )
        REFERENCES t_pip_funcionario ( cd_funcionario );

CREATE OR REPLACE TRIGGER arc_arc_2_t_pip_vendedor BEFORE
    INSERT OR UPDATE OF vendedor_fk_cd_funcionario ON t_pip_vendedor
    FOR EACH ROW
DECLARE
    d NUMBER(2);
BEGIN
    SELECT
        a.func_fk_cd_tipo_func
    INTO d
    FROM
        t_pip_funcionario a
    WHERE
        a.cd_funcionario = :new.vendedor_fk_cd_funcionario;

    IF ( d IS NULL OR d <> func_fk_cod_tipo_func ) THEN
        raise_application_error(-20223,
                               'FK VEND_FUNCIONARIO_FK in Table T_PIP_VENDEDOR violates Arc constraint on Table T_PIP_FUNCIONARIO - discriminator column FUNC_FK_cd_tipo_func doesn''t have value FUNC_FK_cod_tipo_func');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_2_t_pip_gerente BEFORE
    INSERT OR UPDATE OF gerente_fk_cd_funcionario ON t_pip_gerente
    FOR EACH ROW
DECLARE
    d NUMBER(2);
BEGIN
    SELECT
        a.func_fk_cd_tipo_func
    INTO d
    FROM
        t_pip_funcionario a
    WHERE
        a.cd_funcionario = :new.gerente_fk_cd_funcionario;

    IF ( d IS NULL OR d <> func_fk_cod_tipo_func ) THEN
        raise_application_error(-20223,
                               'FK GERENTE_FUNCIONARIO_FK in Table T_PIP_GERENTE violates Arc constraint on Table T_PIP_FUNCIONARIO - discriminator column FUNC_FK_cd_tipo_func doesn''t have value FUNC_FK_cod_tipo_func');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_2_t_pip_supervisor BEFORE
    INSERT OR UPDATE OF supervisor_fk_cd_funcionario ON t_pip_supervisor
    FOR EACH ROW
DECLARE
    d NUMBER(2);
BEGIN
    SELECT
        a.func_fk_cd_tipo_func
    INTO d
    FROM
        t_pip_funcionario a
    WHERE
        a.cd_funcionario = :new.supervisor_fk_cd_funcionario;

    IF ( d IS NULL OR d <> func_fk_cod_tipo_func ) THEN
        raise_application_error(-20223,
                               'FK SUP_FUNCIONARIO_FK in Table T_PIP_SUPERVISOR violates Arc constraint on Table T_PIP_FUNCIONARIO - discriminator column FUNC_FK_cd_tipo_func doesn''t have value FUNC_FK_cod_tipo_func');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_ar_t_pip_pessoa_juridicav2 BEFORE
    INSERT OR UPDATE OF pjuridica_fk_cd_cliente ON t_pip_pessoa_juridicav2
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.tcliente_fk_cd_tipo_cliente
    INTO d
    FROM
        t_pip_cliente a
    WHERE
        a.cd_cliente = :new.pjuridica_fk_cd_cliente;

    IF ( d IS NULL OR d <> tcliente_fk_cod_tipo_cliente ) THEN
        raise_application_error(-20223,
                               'FK PESSOA_JURIDICA_CLIENTE_FK in Table T_PIP_PESSOA_JURIDICAv2 violates Arc constraint on Table T_PIP_CLIENTE - discriminator column TCLIENTE_FK_cd_tipo_cliente doesn''t have value TCLIENTE_FK_cod_tipo_cliente');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_1_t_pip_pessoa_fisica BEFORE
    INSERT OR UPDATE OF pfisica_fk_cd_cliente ON t_pip_pessoa_fisica
    FOR EACH ROW
DECLARE
    d NUMBER(10);
BEGIN
    SELECT
        a.tcliente_fk_cd_tipo_cliente
    INTO d
    FROM
        t_pip_cliente a
    WHERE
        a.cd_cliente = :new.pfisica_fk_cd_cliente;

    IF ( d IS NULL OR d <> tcliente_fk_cod_tipo_cliente ) THEN
        raise_application_error(-20223,
                               'FK PESSOA_FISICA_CLIENTE_FK in Table T_PIP_PESSOA_FISICA violates Arc constraint on Table T_PIP_CLIENTE - discriminator column TCLIENTE_FK_cd_tipo_cliente doesn''t have value TCLIENTE_FK_cod_tipo_cliente');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            30
-- CREATE INDEX                             8
-- ALTER TABLE                             62
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           5
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
-- WARNINGS                                 0
