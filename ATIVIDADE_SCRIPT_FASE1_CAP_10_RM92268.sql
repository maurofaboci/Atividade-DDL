    -- TABELAS RELACAOS CLIENTES --
    
    CREATE TABLE T_PIP_CLIENTE
    (
        cd_cliente   NUMERIC(5)     NOT NULL,
        cd_tipo_cliente     NUMERIC(2)     NOT NULL, --fk
        nm_cliente      VARCHAR2(50)    NOT NULL,
        ds_email    VARCHAR(50),
        CONSTRAINT PK_PIP_CLIENTE PRIMARY KEY (cd_cliente)
    );
    
    CREATE TABLE T_PIP_TIPO_CLIENTE
    (
        cd_tipo_cliente     NUMERIC(2)  NOT NULL,
        ds_tipo_cliente     VARCHAR2 (30) NOT NULL,
        CONSTRAINT PK_TIPO_CLIENTE PRIMARY KEY (cd_tipo_cliente)
    );
    
    CREATE TABLE T_PIP_PESSOA_FISICA
    (
        cd_cliente      NUMERIC(5)      NOT NULL,
        nr_cpf      NUMERIC(11)     NOT NULL,
        nr_rg       NUMERIC(12),
        dt_nascimento       DATE,
        CONSTRAINT PK_PESSOA_FISICA PRIMARY KEY (cd_cliente),
        CONSTRAINT FK_PESSOA_FISICA FOREIGN KEY (cd_cliente)
        REFERENCES T_PIP_PESSOA_FISICA (cd_cliente)
    );
    
    CREATE TABLE T_PIP_PESSOA_JURIDICA
    (
        cd_cliente      NUMERIC (5)     NOT NULL,
        nr_cnpj     NUMERIC (14)    NOT NULL,
        ds_razao_social     VARCHAR2(50) NOT NULL,
        ds_ramo_ativ        VARCHAR2(50) NOT NULL,
        CONSTRAINT PK_PESSOA_JURIDICA PRIMARY KEY (cd_cliente),
        CONSTRAINT FK_PESSOA_JURIDICA FOREIGN KEY (cd_cliente)
        REFERENCES T_PIP_PESSOA_JURIDICA (cd_cliente)
    );
    
    CREATE TABLE T_PIP_TELEFONE
    (
        cd_telefone     NUMERIC(10)     NOT NULL,
        cd_tipo_telefone     NUMERIC(2)    NOT NULL,
        cd_cliente      NUMERIC(5)  NOT NULL,
        nr_telefone    NUMERIC(11) NOT NULL,
        nm_ddd      NUMERIC(3) NOT NULL,
        CONSTRAINT PK_CD_TELEFONE PRIMARY KEY (cd_telefone)
    );
    
    CREATE TABLE    T_PIP_TIPO_TELEFONE
    (
        cd_tipo_telefone        NUMERIC(2)  NOT NULL,
        ds_tipo_telefone        VARCHAR2(40)    NOT NULL,
        CONSTRAINT PK_CD_TIPO_TELEFONE PRIMARY KEY (cd_tipo_telefone)
    );
    
    CREATE TABLE T_PIP_ENDERECO
    (
        nr_cep      NUMERIC(8)  NOT NULL,
        cd_tipo_logradouro  NUMERIC(5) NOT NULL,
        cd_bairro   NUMERIC(5),
        ds_logradouro   VARCHAR2(40),
        CONSTRAINT PK_ENDERECO PRIMARY KEY (nr_cep)
    );
    
    CREATE TABLE T_PIP_CLIENTE_ENDERECO
    (
        cd_cliente      NUMERIC(5) NOT NULL,
        nr_cep      NUMERIC(8)  NOT NULL,
        nr_endereço     NUMERIC (5),
        ds_complemento      VARCHAR2(30),
        CONSTRAINT PK_CLIENTE_ENDERECO PRIMARY KEY (cd_cliente,nr_cep),
        CONSTRAINT FK_CLIENTE_ENDERECO FOREIGN KEY (cd_cliente)
        REFERENCES T_PIP_CLIENTE(cd_cliente),
        CONSTRAINT FK_CLIENTE_ENDERECO2 FOREIGN KEY (nr_cep)
        REFERENCES T_PIP_ENDERECO (nr_cep)
    );
    
    CREATE TABLE T_PIP_TIPO_LOGRADOURO
    (
        cd_tipo_logradouro  NUMERIC(5)  NOT NULL,
        ds_tipo_logradouro VARCHAR2(40) NOT NULL,
        CONSTRAINT PK_TIPO_LOGRADOURO PRIMARY KEY (cd_tipo_logradouro)
    );
    
    CREATE TABLE T_PIP_BAIRRO
    (
        cd_bairro   NUMERIC(5) NOT NULL,
        cd_cidade   NUMERIC(5) NOT NULL,
        nm_bairro   VARCHAR2(50) NOT NULL,
        CONSTRAINT PK_BAIRRO PRIMARY KEY (cd_bairro)
    );
    
    CREATE TABLE T_PIP_CIDADE
    (
        cd_cidade   NUMERIC(5) NOT NULL,
        cd_estado   NUMERIC(5) NOT NULL,
        nm_cidade   VARCHAR(40) NOT NULL,
        CONSTRAINT PK_CIDADE PRIMARY KEY (cd_cidade)
    );
    
    CREATE TABLE T_PIP_ESTADO
    (
        cd_estado   NUMERIC(5) NOT NULL,
        nm_estado   VARCHAR(40) NOT NULL,
        CONSTRAINT PK_ESTADO PRIMARY KEY (cd_estado)
    );
    
   -- FOREIGN KEYS CLIENTES TELEFONES ENDERECOS 
    
    ALTER TABLE T_PIP_TELEFONE
    ADD CONSTRAINT FK_FONE_CLIENTE FOREIGN KEY (cd_cliente)
    REFERENCES T_PIP_CLIENTE (cd_cliente);
    
    ALTER TABLE T_PIP_TELEFONE
    ADD CONSTRAINT FK_CD_TIPO_TELEFONE FOREIGN KEY (cd_tipo_telefone)
    REFERENCES T_PIP_TIPO_TELEFONE (cd_tipo_telefone);
    
    ALTER TABLE T_PIP_CLIENTE
    ADD CONSTRAINT FK__TIPO_CLIENTE FOREIGN KEY (cd_tipo_cliente)
    REFERENCES T_PIP_TIPO_CLIENTE (cd_tipo_cliente);
    
    ALTER TABLE T_PIP_ENDERECO
    ADD CONSTRAINT FK_TIPO_LOGRADOURO FOREIGN KEY (cd_tipo_logradouro)
    REFERENCES T_PIP_TIPO_LOGRADOURO (cd_tipo_logradouro);
    
    ALTER TABLE T_PIP_ENDERECO
    ADD CONSTRAINT FK_BAIRRO FOREIGN KEY (cd_bairro)
    REFERENCES T_PIP_BAIRRO (cd_bairro);
    
    ALTER TABLE T_PIP_BAIRRO
    ADD CONSTRAINT FK_CIDADE FOREIGN KEY (cd_cidade)
    REFERENCES T_PIP_CIDADE (cd_cidade);
    
    ALTER TABLE T_PIP_CIDADE
    ADD CONSTRAINT FK_ESTADO FOREIGN KEY(cd_estado)
    REFERENCES T_PIP_ESTADO (cd_estado);
    
    
    -- TABELAS RELACOES PEDIDOS --
    
    CREATE TABLE T_PIP_PEDIDO
    (
        cd_pedido       NUMERIC(10)   NOT NULL,
        cd_cliente      NUMERIC(5)  NOT NULL,
        cd_nota_fiscal      NUMERIC(10) NOT NULL,
        cd_funcionario  NUMERIC (5) NOT NULL,
        dt_pedido       DATE    NOT NULL,
        vr_pedido       NUMERIC(7,2),
        CONSTRAINT PK_PEDIDOS PRIMARY KEY (cd_pedido)
    );
    
    CREATE TABLE T_PIP_NOTA_FISCAL
    (
        cd_nota_fiscal      NUMERIC(10) NOT NULL,
        cd_transportadora       NUMERIC(5) NOT NULL,
        tm_data_emissao     DATE    NOT NULL,
        CONSTRAINT PK_NOTA_FISCAL PRIMARY KEY (cd_nota_fiscal)
    );
    
    CREATE TABLE T_PIP_TRANSPORTADORA
    (
        cd_transportadora   NUMERIC(4)  NOT NULL,
        ds_razao_social   VARCHAR(60) NOT NULL,
        nr_cnpj     NUMERIC(14) NOT NULL,
        CONSTRAINT PK_TRANSPORTADORA PRIMARY KEY(cd_transportadora)
    );
    
    
    CREATE TABLE T_PIP_PRODUTO
    (
        cd_produto      NUMERIC(10)     NOT NULL,
        cd_marca        NUMERIC(5)  NOT NULL,
        cd_categoria_produto        NUMERIC(5)  NOT NULL,
        cd_cor      NUMERIC(3)  NOT NULL,
        cd_unid_medida      NUMERIC(3)  NOT NULL,
        ds_nome         VARCHAR2(40)    NOT NULL,
        ds_descricao        VARCHAR2(80)    NOT NULL,
        vr_unitario         NUMERIC(7,2)    NOT NULL,
        CONSTRAINT PK_PRODUTO PRIMARY KEY (cd_produto)
    );
    
    CREATE TABLE T_PIP_PEDIDO_PRODUTO
    (
        cd_produto      NUMERIC(10) NOT NULL,
        cd_pedido       NUMERIC(10) NOT NULL,
        qt_vendida      NUMERIC(6)  NOT NULL,
        vr_vend_unitario        NUMERIC(7,2)    NOT NULL,
        CONSTRAINT PK_PEDIDOS_PRODUTO PRIMARY KEY (cd_produto,cd_pedido),
        CONSTRAINT FK_PEDIDO_PRODUTO FOREIGN KEY (cd_pedido)
        REFERENCES T_PIP_PEDIDO (cd_pedido),
        CONSTRAINT FK_PEDIDO_PRODUTO2 FOREIGN KEY (cd_produto)
        REFERENCES T_PIP_PRODUTO (cd_produto)
    );
    
    CREATE TABLE T_PIP_UNIDADE_MEDIDA
    (
        cd_unid_medida      NUMERIC(3) NOT NULL,
        ds_unid_medida      VARCHAR2(50) NOT NULL,
        CONSTRAINT PK_UNIDADE_MEDIDA PRIMARY KEY (cd_unid_medida)
    );
    
    CREATE TABLE T_PIP_CATEGORIA_PRODUTO
    (
        cd_categoria_produto    NUMERIC(5) NOT NULL,
        ds_categoria_produto    VARCHAR2(50) NOT NULL,
        CONSTRAINT PK_CATEGORIA_PRODUTO PRIMARY KEY (cd_categoria_produto)
    );
    
    CREATE TABLE T_PIP_MARCA
    (
        cd_marca    NUMERIC(5),
        ds_marca    VARCHAR2(50),
        CONSTRAINT PK_MARCA PRIMARY KEY (cd_marca)
    );
    
    CREATE TABLE T_PIP_COR
    (
        cd_cor      NUMERIC(3) NOT NULL,
        ds_cor      VARCHAR2(50) NOT NULL,
        CONSTRAINT PK_COR PRIMARY KEY (cd_cor)
    );
    
    CREATE TABLE T_PIP_ESTOQUE
    (
        cd_estoque      NUMERIC(2)  NOT NULL,
        cd_produto      NUMERIC(10) NOT NULL,
        cd_loja     NUMERIC(2)  NOT NULL,
        qt_produto      NUMERIC(10),
        CONSTRAINT PK_ESTOQUE PRIMARY KEY(cd_estoque)
    );
    
    CREATE TABLE T_PIP_LOJA
    (
        cd_loja     NUMERIC(2)  NOT NULL,
        cd_estoque      NUMERIC(2)  NOT NULL,
        dr_endereço_loja    VARCHAR(60) NOT NULL,
        CONSTRAINT PK_LOJA  PRIMARY KEY (cd_loja)
    );
    
    CREATE TABLE T_PIP_FORNECEDOR
    (
        cd_fornecedor       NUMERIC(3)  NOT NULL,
        nm_fornecedor       VARCHAR(60) NOT NULL,
        dr_area_atuante     VARCHAR(60) NOT NULL,
        CONSTRAINT PK_FORNECEDOR PRIMARY KEY (cd_fornecedor)
    );
    
    CREATE TABLE T_PIP_ENTREGADOR
    (
        cd_entregador       NUMERIC(4)  NOT NULL,
        cd_loja     NUMERIC(2)  NOT NULL,
        cd_fornecedor       NUMERIC(2)  NOT NULL,
        nm_entregador       VARCHAR2(60)    NOT NULL,
        dt_entrega      DATE    NOT NULL,
        CONSTRAINT PK_ENTREGADOR PRIMARY KEY(cd_entregador)
    );

--  TABELAS RELACOES FUNCIONARIOS

    CREATE TABLE T_PIP_FUNCIONARIO
    (
        cd_funcionario      NUMERIC(5)  NOT NULL,
        cd_loja     NUMERIC(2)  NOT NULL,
        vr_salario      NUMERIC(7,2)    NOT NULL,
        dt_contratacao      DATE    NOT NULL,
        dt_demissao     DATE,
        ds_endereco     VARCHAR2(60)    NOT NULL,
        nr_cpf      NUMERIC(11) NOT NULL,
        nm_funcionario      VARCHAR2(60)    NOT NULL,
        CONSTRAINT PK_FUNCIONARIO PRIMARY KEY (cd_funcionario),
        CONSTRAINT CK_SALARIO CHECK (vr_salario>=1027)
    );
    
    CREATE TABLE T_PIP_VENDEDOR
    (
        cd_funcionario      NUMERIC(5)  NOT NULL,
        qt_vendas       NUMERIC(10),
        vr_comissao_vendas  NUMERIC(7,2),
        CONSTRAINT PK_PIP_VENDEDOR PRIMARY KEY (cd_funcionario),
        CONSTRAINT FK_PIP_VENDEDOR FOREIGN KEY (cd_funcionario)
        REFERENCES T_PIP_FUNCIONARIO (cd_funcionario)
    );
    
    CREATE TABLE T_PIP_GERENTE
    (
        cd_funcionario      NUMERIC(5)  NOT NULL,
        ds_escolaridade     VARCHAR(60) NOT NULL,
        cd_gerente      NUMERIC(3)  NOT NULL,
        CONSTRAINT UN_GERENTE UNIQUE (cd_gerente),
        CONSTRAINT PK_PIP_GERENTE PRIMARY KEY (cd_funcionario),
        CONSTRAINT FK_PIP_GERENTE FOREIGN KEY (cd_funcionario)
        REFERENCES T_PIP_FUNCIONARIO (cd_funcionario)
    );
    
    CREATE TABLE T_PIP_SUPERVISOR
    (
        cd_funcionario      NUMERIC(5)   NOT NULL,
        cd_supervisor       NUMERIC(3)   NOT NULL,
        tm_hora_extra       NUMERIC(5,2),
        CONSTRAINT UN_SUPERVISOR UNIQUE (cd_supervisor),
        CONSTRAINT PK_PIP_SUPERVISOR PRIMARY KEY (cd_funcionario),
        CONSTRAINT FK_SUPERVISOR FOREIGN KEY (cd_funcionario)
        REFERENCES T_PIP_FUNCIONARIO (cd_funcionario)
    );
    
    -- FOREIGN KEYS PRODUTOS FUNCIONARIO LOJA ESTOQUE PEDIDO
    
    
    ALTER TABLE T_PIP_PEDIDO
    ADD CONSTRAINT FK_CD_CLIENTE FOREIGN KEY (cd_cliente)
    REFERENCES T_PIP_CLIENTE (cd_cliente);
    
    ALTER TABLE T_PIP_PEDIDO
    ADD CONSTRAINT FK_CD_NOTA_FISCAL FOREIGN KEY(cd_nota_fiscal)
    REFERENCES T_PIP_NOTA_FISCAL (cd_nota_fiscal);
    
    ALTER TABLE T_PIP_PEDIDO
    ADD CONSTRAINT FK_CD_FUNCIONARIO FOREIGN KEY (cd_funcionario)
    REFERENCES T_PIP_FUNCIONARIO (cd_funcionario);
    
    ALTER TABLE T_PIP_NOTA_FISCAL
    ADD CONSTRAINT FK_CD_TRANSPORTADORA FOREIGN KEY (cd_transportadora)
    REFERENCES T_PIP_TRANSPORTADORA (cd_transportadora);
    
    ALTER TABLE T_PIP_PRODUTO
    ADD CONSTRAINT FK_MARCA FOREIGN KEY (cd_marca)
    REFERENCES T_PIP_MARCA (cd_marca);
    
    ALTER TABLE T_PIP_PRODUTO
    ADD CONSTRAINT FK_CATEGORIA_PRODUTO FOREIGN KEY (cd_categoria_produto)
    REFERENCES T_PIP_CATEGORIA_PRODUTO (cd_categoria_produto);
    
    ALTER TABLE T_PIP_PRODUTO
    ADD CONSTRAINT FK_UNIDADE_MEDIDA FOREIGN KEY (cd_unid_medida)
    REFERENCES T_PIP_UNIDADE_MEDIDA (cd_unid_medida);
    
    ALTER TABLE T_PIP_PRODUTO
    ADD CONSTRAINT FK_COR FOREIGN KEY (cd_cor)
    REFERENCES T_PIP_COR (cd_cor);
    
    ALTER TABLE T_PIP_ESTOQUE
    ADD CONSTRAINT FK_PRODUTO FOREIGN KEY (cd_produto)
    REFERENCES T_PIP_PRODUTO (cd_produto);
    
    ALTER TABLE T_PIP_ESTOQUE
    ADD CONSTRAINT FK_LOJA FOREIGN KEY (cd_loja)
    REFERENCES T_PIP_LOJA (cd_loja);
    
    ALTER TABLE T_PIP_LOJA
    ADD CONSTRAINT FK_ESTOQUE FOREIGN KEY (cd_estoque)
    REFERENCES T_PIP_ESTOQUE (cd_estoque);
    
    ALTER TABLE T_PIP_ENTREGADOR
    ADD CONSTRAINT FK_LOJA_ENTREGADOR FOREIGN KEY (cd_loja)
    REFERENCES T_PIP_LOJA (cd_loja);
    
    ALTER TABLE T_PIP_ENTREGADOR
    ADD CONSTRAINT FK_FORNECEDOR_ENTREGADOR FOREIGN KEY (cd_fornecedor)
    REFERENCES T_PIP_FORNECEDOR (cd_fornecedor);
    
    ALTER TABLE T_PIP_FUNCIONARIO
    ADD CONSTRAINT FK_LOJA_FUNC FOREIGN KEY (cd_loja)
    REFERENCES T_PIP_LOJA (cd_loja);
    
    -- algumas uniques importantes
    
    ALTER TABLE T_PIP_PESSOA_JURIDICA
    ADD CONSTRAINT UN_PESSOA_JURIDICA UNIQUE (nr_cnpj);
    
    ALTER TABLE T_PIP_FUNCIONARIO
    ADD CONSTRAINT UN_CPF_FUNC UNIQUE (nr_cpf);
    
    ALTER TABLE T_PIP_TRANSPORTADORA
    ADD CONSTRAINT UN_CNPJ_TRANSP UNIQUE (nr_cnpj);
    
    -- drop tables relacao cliente
    
    /* 
    DROP TABLE T_PIP_CLIENTE CASCADE;
    DROP TABLE T_PIP_TIPO_CLIENTE CASCADE;
    DROP TABLE T_PIP_PESSOA_FISICA CASCADE;
    DROP TABLE T_PIP_PESSOA_JURIDICA CASCADE;
    DROP TABLE T_PIP_TELEFONE CASCADE;
    DROP TABLE T_PIP_TIPO_TELEFONE CASCADE;
    DROP TABLE T_PIP_CLIENTE_ENDERECO CASCADE;
    DROP TABLE T_PIP_ENDERECO CASCADE;
    DROP TABLE T_PIP_ESTADO CASCADE;
    DROP TABLE T_PIP_CIDADE CASCADE;
    DROP TABLE T_PIP_BAIRRO CASCADE;
    DROP TABLE T_PIP_TIPO_LOGRADOURO CASCADE;
    */
    
    -- drop table relacao pedido
    
    /*
    DROP TABLE T_PIP_PEDIDO CASCADE;
    DROP TABLE T_PIP_NOTA_FISCAL CASCADE;
    DROP TABLE T_PIP_TRANSPORTADORA CASCADE;
    DROP TABLE T_PIP_PRODUTO CASCADE;
    DROP TABLE T_PIP_PEDIDO_PRODUTO CASCADE;
    DROP TABLE T_PIP_MARCA CASCADE;
    DROP TABLE T_PIP_COR CASCADE;
    DROP TABLE T_PIP_CATEGORIA_PRODUTO CASCADE;
    DROP TABLE T_PIP_UNIDADE_MEDIDA CASCADE;
    DROP TABLE T_PIP_ESTOQUE CASCADE;
    DROP TABLE T_PIP_LOJA CASCADE;
    DROP TABLE T_PIP_FORNECEDOR CASCADE;
    DROP TABLE T_PIP_ENTREGADOR CASCADE;
    */
    
    -- drop table relacao funcionario
    
    /*
    DROP TABLE T_PIP_FUNCIONARIO CASCADE;
    DROP TABLE T_PIP_VENDEDOR CASCADE;
    DROP TABLE T_PIP_SUPERVISOR CASCADE;
    DROP TABLE T_PIP_GERENTE CASCADE;
    */
