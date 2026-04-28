CREATE TABLE alunos
(
    id              SERIAL PRIMARY KEY,
    nome            VARCHAR(155)                              NOT NULL,
    data_nascimento DATE                                      NOT NULL,
    genero          VARCHAR(1) CHECK ( genero IN ('M', 'F') ) NOT NULL,
    telefone        VARCHAR(30)                               NOT NULL,
    celular         VARCHAR(30)                               NOT NULL,
    email           VARCHAR(155)                              NOT NULL UNIQUE,
    observacao      TEXT,
    endereco        VARCHAR(150)                              NOT NULL,
    numero          VARCHAR(20)                               NOT NULL,
    complemento     VARCHAR(100),
    bairro          VARCHAR(100)                              NOT NULL,
    cidade          VARCHAR(100)                              NOT NULL,
    estado          VARCHAR(2)                                NOT NULL,
    cep             VARCHAR(20)                               NOT NULL,
    criado_em       TIMESTAMP                                 NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em   TIMESTAMP                                 NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE modalidades
(
    id    SERIAL PRIMARY KEY,
    nome  VARCHAR(100) NOT NULL UNIQUE,
    ativa BOOLEAN      NOT NULL DEFAULT TRUE
);

CREATE TABLE graduacoes
(
    id            BIGSERIAL PRIMARY KEY,
    modalidade_id BIGINT       NOT NULL REFERENCES modalidades (id),
    nome          VARCHAR(100) NOT NULL,
    UNIQUE (modalidade_id, nome)
);

CREATE TABLE planos
(
    id            BIGSERIAL PRIMARY KEY,
    modalidade_id BIGINT         NOT NULL REFERENCES modalidades (id),
    nome          VARCHAR(100)   NOT NULL,
    valor_mensal  NUMERIC(10, 2) NOT NULL CHECK (valor_mensal >= 0),
    ativo         BOOLEAN        NOT NULL DEFAULT TRUE,
    UNIQUE (modalidade_id, nome)
);

CREATE TABLE matriculas
(
    id                BIGSERIAL PRIMARY KEY,
    aluno_id          BIGINT      NOT NULL REFERENCES alunos (id),
    data_matricula    DATE        NOT NULL default CURRENT_DATE,
    dia_vencimento    INTEGER     NOT NULL CHECK (dia_vencimento BETWEEN 1 AND 31),
    data_encerramento DATE,
    status            VARCHAR(20) NOT NULL DEFAULT 'ATIVA',
    CHECK (status IN ('ATIVA', 'ENCERRADA', 'CANCELADA'))
);

CREATE TABLE matriculas_modalidades
(
    id            BIGSERIAL PRIMARY KEY,
    matricula_id  BIGINT NOT NULL REFERENCES matriculas (id),
    modalidade_id BIGINT NOT NULL REFERENCES modalidades (id),
    graduacao_id  BIGINT NOT NULL REFERENCES graduacoes (id),
    plano_id      BIGINT NOT NULL REFERENCES planos (id),
    data_inicio   DATE   NOT NULL DEFAULT CURRENT_DATE,
    data_fim      DATE,
    UNIQUE (matricula_id, modalidade_id)
);

CREATE TABLE faturas_matriculas
(
    id                BIGSERIAL PRIMARY KEY,
    matricula_id      BIGINT         NOT NULL REFERENCES matriculas (id),
    data_vencimento   DATE           NOT NULL,
    valor             NUMERIC(10, 2) NOT NULL CHECK (valor >= 0),
    data_pagamento    TIMESTAMP,
    data_cancelamento DATE,
    status            VARCHAR(20)    NOT NULL DEFAULT 'ABERTA',
    CHECK (status IN ('ABERTA', 'PAGA', 'CANCELADA', 'VENCIDA')),
    UNIQUE (matricula_id, data_vencimento)
);

CREATE TABLE assiduidade
(
    id           BIGSERIAL PRIMARY KEY,
    matricula_id BIGINT    NOT NULL REFERENCES matriculas (id),
    data_entrada TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_saida   TIMESTAMP
);