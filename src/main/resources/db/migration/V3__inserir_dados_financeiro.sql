-- Garantir que existam alunos de exemplo (não duplicar se já existem)
INSERT INTO alunos (nome, data_nascimento, sexo, telefone, celular, email, observacao, endereco, numero, complemento, bairro, cidade, estado, cep)
SELECT 'Aluno Exemplo 2', CURRENT_DATE - INTERVAL '120 days', 'M', '4833334444', '4899998888', 'aluno2@example.com', 'Aluno exemplo para migracao', 'Rua das Flores', '123', 'Apto 1', 'Centro', 'Criciúma', 'SC', '88802410'
WHERE NOT EXISTS (SELECT 1 FROM alunos WHERE email = 'aluno2@example.com');

INSERT INTO alunos (nome, data_nascimento, sexo, telefone, celular, email, observacao, endereco, numero, complemento, bairro, cidade, estado, cep)
SELECT 'Aluno Exemplo 3', CURRENT_DATE - INTERVAL '90 days', 'M', '4833335555', '4899997777', 'aluno3@example.com', 'Aluno exemplo para migracao', 'Rua das Palmeiras', '45', '', 'Bairro', 'Criciúma', 'SC', '88802411'
WHERE NOT EXISTS (SELECT 1 FROM alunos WHERE email = 'aluno3@example.com');

-- Inserir matrículas referenciando os alunos garantidos acima
INSERT INTO matriculas (aluno_id, data_matricula, dia_vencimento, status)
SELECT a.id, CURRENT_DATE - INTERVAL '90 days', 10, 'ATIVA' FROM alunos a WHERE a.email = 'aluno2@example.com';

INSERT INTO matriculas (aluno_id, data_matricula, dia_vencimento, status)
SELECT a.id, CURRENT_DATE - INTERVAL '60 days', 15, 'ATIVA' FROM alunos a WHERE a.email = 'aluno3@example.com';

-- Vincular modalidades e planos às matrículas
INSERT INTO matriculas_modalidades (
    matricula_id,
    modalidade_id,
    plano_id,
    data_inicio
)
SELECT
    m.id,
    mo.id,
    p.id,
    CURRENT_DATE - INTERVAL '90 days'
FROM matriculas m
JOIN modalidades mo ON mo.nome = 'Musculação'
JOIN planos p ON p.modalidade_id = mo.id AND p.nome = 'Mensal'
WHERE m.aluno_id = 2;

INSERT INTO matriculas_modalidades (
    matricula_id,
    modalidade_id,
    plano_id,
    data_inicio
)
SELECT
    m.id,
    mo.id,
    p.id,
    CURRENT_DATE - INTERVAL '60 days'
FROM matriculas m
JOIN modalidades mo ON mo.nome = 'Jiu-Jitsu'
JOIN planos p ON p.modalidade_id = mo.id AND p.nome = 'Mensal'
WHERE m.aluno_id = 3;

-- Faturas: algumas pagas e algumas em aberto
INSERT INTO faturas_matriculas (
    matricula_id,
    data_vencimento,
    valor,
    data_pagamento,
    status
)
SELECT
    m.id,
    CURRENT_DATE - INTERVAL '60 days',
    120.00,
    CURRENT_DATE - INTERVAL '58 days',
    'PAGA'
FROM matriculas m
WHERE m.aluno_id = 2;

INSERT INTO faturas_matriculas (
    matricula_id,
    data_vencimento,
    valor,
    data_pagamento,
    status
)
SELECT
    m.id,
    CURRENT_DATE - INTERVAL '30 days',
    120.00,
    CURRENT_DATE - INTERVAL '29 days',
    'PAGA'
FROM matriculas m
WHERE m.aluno_id = 2;

INSERT INTO faturas_matriculas (
    matricula_id,
    data_vencimento,
    valor,
    status
)
SELECT
    m.id,
    CURRENT_DATE - INTERVAL '10 days',
    120.00,
    'ABERTA'
FROM matriculas m
WHERE m.aluno_id = 2;

INSERT INTO faturas_matriculas (
    matricula_id,
    data_vencimento,
    valor,
    data_pagamento,
    status
)
SELECT
    m.id,
    CURRENT_DATE - INTERVAL '30 days',
    120.00,
    CURRENT_DATE - INTERVAL '28 days',
    'PAGA'
FROM matriculas m
WHERE m.aluno_id = 3;

INSERT INTO faturas_matriculas (
    matricula_id,
    data_vencimento,
    valor,
    status
)
SELECT
    m.id,
    CURRENT_DATE - INTERVAL '15 days',
    120.00,
    'ABERTA'
FROM matriculas m
WHERE m.aluno_id = 3;
