-- =====================================================================
-- INF220 - Etapa 3 - Grupo 5 - CEMIG (distribuição de energia)
-- Script 1: criação do banco de dados (MySQL)
-- =====================================================================

USE grupo5;

-- Remove na ordem inversa das dependências, para poder rodar de novo
DROP TABLE IF EXISTS ATENDE;
DROP TABLE IF EXISTS CHAMADO;
DROP TABLE IF EXISTS LEITURA_MENSAL;
DROP TABLE IF EXISTS POSSUI;
DROP TABLE IF EXISTS UNIDADE_CONSUMIDORA;
DROP TABLE IF EXISTS BANDEIRA;
DROP TABLE IF EXISTS TARIFA;
DROP TABLE IF EXISTS DEPENDENTE;
DROP TABLE IF EXISTS LIDERA;
DROP TABLE IF EXISTS PARTICIPA;
DROP TABLE IF EXISTS EQUIPE;
DROP TABLE IF EXISTS GERENCIA;
DROP TABLE IF EXISTS FUNCIONARIO;
DROP TABLE IF EXISTS DEPARTAMENTO;
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS JURIDICA;
DROP TABLE IF EXISTS FISICA;
DROP TABLE IF EXISTS PESSOA;
DROP TABLE IF EXISTS ENDERECO;

CREATE TABLE ENDERECO (
    id           INT          NOT NULL,
    logradouro   VARCHAR(100) NOT NULL,
    numero       VARCHAR(10)  NOT NULL,
    complemento  VARCHAR(50),
    bairro       VARCHAR(60)  NOT NULL,
    cidade       VARCHAR(60)  NOT NULL,
    estado       CHAR(2)      NOT NULL,
    cep          CHAR(8)      NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE PESSOA (
    id           INT         NOT NULL,
    telefone     VARCHAR(15) NOT NULL,
    id_endereco  INT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_endereco) REFERENCES ENDERECO (id)
);

CREATE TABLE FISICA (
    id_pessoa  INT          NOT NULL,
    nome       VARCHAR(100) NOT NULL,
    cpf        CHAR(11)     NOT NULL,
    PRIMARY KEY (id_pessoa),
    UNIQUE (cpf),
    FOREIGN KEY (id_pessoa) REFERENCES PESSOA (id)
);

CREATE TABLE JURIDICA (
    id_pessoa      INT          NOT NULL,
    razao_social   VARCHAR(120) NOT NULL,
    nome_fantasia  VARCHAR(100),
    cnpj           CHAR(14)     NOT NULL,
    PRIMARY KEY (id_pessoa),
    UNIQUE (cnpj),
    FOREIGN KEY (id_pessoa) REFERENCES PESSOA (id)
);

CREATE TABLE CLIENTE (
    id_pessoa      INT  NOT NULL,
    data_cadastro  DATE NOT NULL,
    PRIMARY KEY (id_pessoa),
    FOREIGN KEY (id_pessoa) REFERENCES PESSOA (id)
);

CREATE TABLE DEPARTAMENTO (
    id        INT         NOT NULL,
    nome      VARCHAR(60) NOT NULL,
    telefone  VARCHAR(15),
    PRIMARY KEY (id)
);

CREATE TABLE FUNCIONARIO (
    id_pessoa        INT           NOT NULL,
    tipo_contrato    VARCHAR(20)   NOT NULL,
    cargo            VARCHAR(60)   NOT NULL,
    salario          DECIMAL(10,2) NOT NULL CHECK (salario > 0),
    data_admissao    DATE          NOT NULL,
    id_departamento  INT           NOT NULL,
    PRIMARY KEY (id_pessoa),
    FOREIGN KEY (id_pessoa) REFERENCES FISICA (id_pessoa),
    FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO (id)
);

CREATE TABLE GERENCIA (
    id_funcionario   INT  NOT NULL,
    id_departamento  INT  NOT NULL,
    data_inicio      DATE NOT NULL,
    data_fim         DATE,
    PRIMARY KEY (id_funcionario, id_departamento, data_inicio),
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_pessoa),
    FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO (id),
    CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

CREATE TABLE EQUIPE (
    id               INT         NOT NULL,
    nome             VARCHAR(60) NOT NULL,
    especializacao   VARCHAR(60) NOT NULL,
    id_departamento  INT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO (id)
);

CREATE TABLE PARTICIPA (
    id_funcionario  INT NOT NULL,
    id_equipe       INT NOT NULL,
    PRIMARY KEY (id_funcionario, id_equipe),
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_pessoa),
    FOREIGN KEY (id_equipe) REFERENCES EQUIPE (id)
);

CREATE TABLE LIDERA (
    id_funcionario  INT  NOT NULL,
    id_equipe       INT  NOT NULL,
    data_inicio     DATE NOT NULL,
    data_fim        DATE,
    PRIMARY KEY (id_funcionario, id_equipe, data_inicio),
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_pessoa),
    FOREIGN KEY (id_equipe) REFERENCES EQUIPE (id),
    CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

CREATE TABLE DEPENDENTE (
    id_funcionario   INT          NOT NULL,
    numero           INT          NOT NULL,
    nome             VARCHAR(100) NOT NULL,
    sexo             CHAR(1)      NOT NULL CHECK (sexo IN ('M', 'F')),
    data_nascimento  DATE         NOT NULL,
    parentesco       VARCHAR(20)  NOT NULL,
    PRIMARY KEY (id_funcionario, numero),
    FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO (id_pessoa)
);

CREATE TABLE TARIFA (
    id           INT           NOT NULL,
    nome         VARCHAR(60)   NOT NULL,
    valor_base   DECIMAL(8,5)  NOT NULL CHECK (valor_base > 0),  -- R$/kWh
    data_inicio  DATE          NOT NULL,
    data_fim     DATE,
    PRIMARY KEY (id),
    CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

CREATE TABLE BANDEIRA (
    id               INT          NOT NULL,
    nome             VARCHAR(30)  NOT NULL,
    valor_acrescimo  DECIMAL(8,5) NOT NULL CHECK (valor_acrescimo >= 0),  -- R$/kWh
    data_inicio      DATE         NOT NULL,
    data_fim         DATE         NOT NULL,
    PRIMARY KEY (id),
    CHECK (data_fim >= data_inicio)
);

CREATE TABLE UNIDADE_CONSUMIDORA (
    id           INT         NOT NULL,
    tipo         VARCHAR(12) NOT NULL CHECK (tipo IN ('residencial', 'comercial', 'industrial')),
    id_endereco  INT         NOT NULL,
    id_tarifa    INT         NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_endereco) REFERENCES ENDERECO (id),
    FOREIGN KEY (id_tarifa) REFERENCES TARIFA (id)
);

CREATE TABLE POSSUI (
    id_cliente   INT  NOT NULL,
    id_unidade   INT  NOT NULL,
    data_inicio  DATE NOT NULL,
    data_fim     DATE,
    PRIMARY KEY (id_cliente, id_unidade, data_inicio),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_pessoa),
    FOREIGN KEY (id_unidade) REFERENCES UNIDADE_CONSUMIDORA (id),
    CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

CREATE TABLE LEITURA_MENSAL (
    id               INT           NOT NULL,
    id_unidade       INT           NOT NULL,
    ano              INT           NOT NULL,
    mes              INT           NOT NULL CHECK (mes BETWEEN 1 AND 12),
    data_leitura     DATE          NOT NULL,
    valor_anterior   DECIMAL(10,1) NOT NULL,
    valor_atual      DECIMAL(10,1) NOT NULL,
    consumo          DECIMAL(10,1) GENERATED ALWAYS AS (valor_atual - valor_anterior) STORED,
    data_vencimento  DATE          NOT NULL,
    pago             BOOLEAN       NOT NULL DEFAULT FALSE,
    id_tarifa        INT           NOT NULL,
    id_bandeira      INT           NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (id_unidade, ano, mes),
    FOREIGN KEY (id_unidade) REFERENCES UNIDADE_CONSUMIDORA (id),
    FOREIGN KEY (id_tarifa) REFERENCES TARIFA (id),
    FOREIGN KEY (id_bandeira) REFERENCES BANDEIRA (id),
    CHECK (valor_atual >= valor_anterior)
);

CREATE TABLE CHAMADO (
    id               INT          NOT NULL,
    data_abertura    DATETIME     NOT NULL,
    descricao        VARCHAR(255) NOT NULL,
    tipo             VARCHAR(30)  NOT NULL,
    prioridade       VARCHAR(10)  NOT NULL CHECK (prioridade IN ('baixa', 'media', 'alta')),
    situacao         VARCHAR(15)  NOT NULL CHECK (situacao IN ('aberto', 'em_andamento', 'concluido')),
    data_fechamento  DATETIME,
    id_cliente       INT          NOT NULL,
    id_unidade       INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_pessoa),
    FOREIGN KEY (id_unidade) REFERENCES UNIDADE_CONSUMIDORA (id),
    CHECK (data_fechamento IS NULL OR data_fechamento >= data_abertura)
);

CREATE TABLE ATENDE (
    id_chamado        INT  NOT NULL,
    id_equipe         INT  NOT NULL,
    data_atendimento  DATE NOT NULL,
    PRIMARY KEY (id_chamado, id_equipe),
    FOREIGN KEY (id_chamado) REFERENCES CHAMADO (id),
    FOREIGN KEY (id_equipe) REFERENCES EQUIPE (id)
);
