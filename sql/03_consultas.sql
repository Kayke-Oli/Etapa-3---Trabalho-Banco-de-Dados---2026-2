-- =====================================================================
-- INF220 - Etapa 3 - Grupo 5 - CEMIG (distribuição de energia)
-- Script 3: consultas
-- =====================================================================

USE grupo5;

-- C1 (2 tabelas) Clientes pessoa física, com nome, CPF e data de cadastro
SELECT f.nome, f.cpf, c.data_cadastro
FROM CLIENTE c
JOIN FISICA f ON f.id_pessoa = c.id_pessoa
ORDER BY c.data_cadastro;

-- C2 (2 tabelas) Funcionários com cargo, salário e departamento onde trabalham
SELECT f.id_pessoa, f.cargo, f.salario, d.nome AS departamento
FROM FUNCIONARIO f
JOIN DEPARTAMENTO d ON d.id = f.id_departamento
ORDER BY d.nome, f.salario DESC;

-- C3 (2 tabelas) Dependentes com o nome do funcionário responsável
SELECT fis.nome AS funcionario, dep.numero, dep.nome AS dependente, dep.parentesco, dep.data_nascimento
FROM DEPENDENTE dep
JOIN FISICA fis ON fis.id_pessoa = dep.id_funcionario
ORDER BY fis.nome, dep.numero;

-- C4 (3 tabelas) Titular atual de cada unidade consumidora residencial
SELECT u.id AS unidade, u.tipo, f.nome AS titular, p.data_inicio AS titular_desde
FROM UNIDADE_CONSUMIDORA u
JOIN POSSUI p ON p.id_unidade = u.id AND p.data_fim IS NULL
JOIN FISICA f ON f.id_pessoa = p.id_cliente
WHERE u.tipo = 'residencial'
ORDER BY u.id;

-- C5 (3 tabelas) Histórico de titularidade da unidade 2, com o endereço do imóvel
SELECT e.logradouro, e.numero, p.id_cliente, p.data_inicio, p.data_fim
FROM POSSUI p
JOIN UNIDADE_CONSUMIDORA u ON u.id = p.id_unidade
JOIN ENDERECO e ON e.id = u.id_endereco
WHERE u.id = 2
ORDER BY p.data_inicio;

-- C6 (3 tabelas) Valor de cada fatura de 09/2025:
--     consumo = atual - anterior; total = consumo x (tarifa + bandeira)
SELECT l.id_unidade, l.ano, l.mes,
       l.consumo                                      AS consumo_kwh,
       t.nome AS tarifa, b.nome AS bandeira,
       ROUND((l.consumo) * (t.valor_base + b.valor_acrescimo), 2) AS valor_total
FROM LEITURA_MENSAL l
JOIN TARIFA   t ON t.id = l.id_tarifa
JOIN BANDEIRA b ON b.id = l.id_bandeira
WHERE l.ano = 2025 AND l.mes = 9
ORDER BY valor_total DESC;

-- C7 (agregação) Consumo total e médio por tipo de unidade no período
SELECT u.tipo,
       COUNT(*)                                     AS qtd_leituras,
       SUM(l.consumo)        AS consumo_total_kwh,
       ROUND(AVG(l.consumo), 1) AS consumo_medio_kwh
FROM LEITURA_MENSAL l
JOIN UNIDADE_CONSUMIDORA u ON u.id = l.id_unidade
GROUP BY u.tipo
ORDER BY consumo_total_kwh DESC;

-- C8 (agregação) Inadimplência: contas não pagas e vencidas, somadas por titular
--     (o titular é quem possuía a unidade na data da leitura)
SELECT p.id_cliente,
       COUNT(*) AS contas_em_atraso,
       ROUND(SUM((l.consumo) * (t.valor_base + b.valor_acrescimo)), 2) AS valor_devido
FROM LEITURA_MENSAL l
JOIN TARIFA   t ON t.id = l.id_tarifa
JOIN BANDEIRA b ON b.id = l.id_bandeira
JOIN POSSUI   p ON p.id_unidade = l.id_unidade
               AND l.data_leitura >= p.data_inicio
               AND (p.data_fim IS NULL OR l.data_leitura <= p.data_fim)
WHERE l.pago = FALSE
  AND l.data_vencimento < CURRENT_DATE
GROUP BY p.id_cliente
ORDER BY valor_devido DESC;

-- C9 (3 tabelas) Chamados e as equipes que atuaram em cada um
SELECT c.id AS chamado, c.tipo, c.situacao, e.nome AS equipe, a.data_atendimento
FROM CHAMADO c
JOIN ATENDE a ON a.id_chamado = c.id
JOIN EQUIPE e ON e.id = a.id_equipe
ORDER BY c.id, a.data_atendimento;

-- C10 (3 tabelas) Gerente atual de cada departamento
SELECT d.nome AS departamento, f.nome AS gerente, g.data_inicio AS gerente_desde
FROM DEPARTAMENTO d
JOIN GERENCIA g ON g.id_departamento = d.id AND g.data_fim IS NULL
JOIN FISICA   f ON f.id_pessoa = g.id_funcionario
ORDER BY d.nome;

-- C11 (3 tabelas) Histórico de líderes de cada equipe
SELECT e.nome AS equipe, f.nome AS lider, l.data_inicio, l.data_fim
FROM LIDERA l
JOIN EQUIPE e ON e.id = l.id_equipe
JOIN FISICA f ON f.id_pessoa = l.id_funcionario
ORDER BY e.nome, l.data_inicio;

-- C12 (agregação) Quantidade de chamados atendidos por equipe
SELECT e.nome AS equipe, COUNT(a.id_chamado) AS chamados_atendidos
FROM EQUIPE e
LEFT JOIN ATENDE a ON a.id_equipe = e.id
GROUP BY e.id, e.nome
ORDER BY chamados_atendidos DESC;

-- C13 (agregação) Média salarial e número de funcionários por departamento
SELECT d.nome AS departamento, COUNT(f.id_pessoa) AS funcionarios, ROUND(AVG(f.salario), 2) AS media_salarial
FROM DEPARTAMENTO d
LEFT JOIN FUNCIONARIO f ON f.id_departamento = d.id
GROUP BY d.id, d.nome
ORDER BY media_salarial DESC;

-- C14 Chamados ainda não concluídos que nenhuma equipe atendeu
SELECT c.id, c.data_abertura, c.tipo, c.prioridade
FROM CHAMADO c
LEFT JOIN ATENDE a ON a.id_chamado = c.id
WHERE c.situacao <> 'concluido'
  AND a.id_chamado IS NULL;
