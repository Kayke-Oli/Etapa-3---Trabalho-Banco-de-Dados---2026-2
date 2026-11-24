-- =====================================================================
-- INF220 - Etapa 3 - Grupo 5 - CEMIG (distribuição de energia)
-- Script 2: povoamento do banco
-- =====================================================================

USE grupo5;

-- ENDERECO (1-12: pessoas, 13-16: unidades consumidoras comerciais/industriais)
INSERT INTO ENDERECO (id, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1,  'Rua dos Estudantes',      '120', 'Apto 201', 'Centro',          'Viçosa',         'MG', '36570000'),
(2,  'Rua Gomes Barbosa',       '45',  NULL,       'Centro',          'Viçosa',         'MG', '36570001'),
(3,  'Avenida Santa Rita',      '890', 'Casa 2',   'Santa Clara',     'Viçosa',         'MG', '36570002'),
(4,  'Rua Nova Viçosa',         '33',  NULL,       'Nova Viçosa',     'Viçosa',         'MG', '36570003'),
(5,  'Rua Padre Serafim',       '210', 'Apto 102', 'Clélia Bernardes','Viçosa',         'MG', '36570004'),
(6,  'Avenida Afonso Pena',     '1500','Sala 803', 'Centro',          'Belo Horizonte', 'MG', '30130001'),
(7,  'Rua da Bahia',            '780', 'Apto 1201','Lourdes',         'Belo Horizonte', 'MG', '30160011'),
(8,  'Rua Itambé',              '56',  NULL,       'Floresta',        'Belo Horizonte', 'MG', '30150150'),
(9,  'Rua Professor Morais',    '300', 'Apto 504', 'Funcionários',    'Belo Horizonte', 'MG', '30150370'),
(10, 'Avenida P. H. Rolfs',     '1000',NULL,       'Centro',          'Viçosa',         'MG', '36570010'),
(11, 'Rodovia BR-120',          'S/N', 'Km 5',     'Distrito Industrial','Viçosa',      'MG', '36570020'),
(12, 'Rua Arthur Bernardes',    '77',  'Loja 1',   'Centro',          'Viçosa',         'MG', '36570030'),
(13, 'Avenida Bueno Brandão',   '500', 'Loja 3',   'Centro',          'Viçosa',         'MG', '36570040'),
(14, 'Rodovia BR-120',          'S/N', 'Km 7',     'Distrito Industrial','Viçosa',      'MG', '36570050'),
(15, 'Rua Milton Bandeira',     '150', NULL,       'Centro',          'Viçosa',         'MG', '36570060'),
(16, 'Rua José Teotônio Pacheco','12', 'Apto 3',   'Ramos',           'Viçosa',         'MG', '36570070');

-- PESSOA (1-9 físicas, 10-12 jurídicas)
INSERT INTO PESSOA (id, telefone, id_endereco) VALUES
(1,  '31988110001', 1),
(2,  '31988110002', 2),
(3,  '31988110003', 3),
(4,  '31988110004', 4),
(5,  '31988110005', 5),
(6,  '31988110006', 6),
(7,  '31988110007', 7),
(8,  '31988110008', 8),
(9,  '31988110009', 9),
(10, '3138910010',  10),
(11, '3138910011',  11),
(12, '3138910012',  12);

INSERT INTO FISICA (id_pessoa, nome, cpf) VALUES
(1, 'Ana Paula Souza',      '11122233344'),
(2, 'Bruno Henrique Lima',  '22233344455'),
(3, 'Carla Mendes Rocha',   '33344455566'),
(4, 'Diego Alves Pereira',  '44455566677'),
(5, 'Eduarda Castro Silva', '55566677788'),
(6, 'Fernando Ribeiro',     '66677788899'),
(7, 'Gabriela Nunes',       '77788899900'),
(8, 'Henrique Batista',     '88899900011'),
(9, 'Isabela Martins',      '99900011122');

INSERT INTO JURIDICA (id_pessoa, razao_social, nome_fantasia, cnpj) VALUES
(10, 'Padaria Pão de Minas Ltda',        'Pão de Minas',    '12345678000101'),
(11, 'Laticínios Zona da Mata S.A.',     'Leite da Mata',   '23456789000102'),
(12, 'Mercado Bom Preço Viçosa Ltda',    'Bom Preço',       '34567890000103');

-- CLIENTE (a pessoa 5 é cliente e funcionária; 9 é só funcionária)
INSERT INTO CLIENTE (id_pessoa, data_cadastro) VALUES
(1,  '2019-05-10'),
(2,  '2020-02-01'),
(3,  '2024-12-20'),
(4,  '2021-07-15'),
(5,  '2022-04-01'),
(10, '2018-03-01'),
(11, '2015-09-01'),
(12, '2023-01-10');

INSERT INTO DEPARTAMENTO (id, nome, telefone) VALUES
(1, 'Operação e Manutenção', '3138920001'),
(2, 'Atendimento ao Cliente', '3138920002'),
(3, 'Comercial',              '3138920003');

INSERT INTO FUNCIONARIO (id_pessoa, tipo_contrato, cargo, salario, data_admissao, id_departamento) VALUES
(5, 'CLT',        'Engenheira Eletricista', 9800.00, '2018-02-05', 1),
(6, 'CLT',        'Supervisor de Campo',    7200.00, '2012-06-11', 1),
(7, 'CLT',        'Coordenadora de Atendimento', 6500.00, '2016-03-14', 2),
(8, 'CLT',        'Eletricista de Rede',    4300.00, '2019-09-02', 1),
(9, 'Terceirizado','Analista Comercial',    5100.00, '2021-11-22', 3);

-- GERENCIA (histórico: a pessoa 6 gerenciou o dept. 1 até 2023, depois a 5)
INSERT INTO GERENCIA (id_funcionario, id_departamento, data_inicio, data_fim) VALUES
(6, 1, '2020-01-01', '2023-12-31'),
(5, 1, '2024-01-01', NULL),
(7, 2, '2021-03-01', NULL),
(9, 3, '2022-01-01', NULL);

INSERT INTO EQUIPE (id, nome, especializacao, id_departamento) VALUES
(1, 'Manutenção Rede Viçosa', 'Manutenção de rede de média tensão', 1),
(2, 'Ligação Nova',           'Instalação e ligação de unidades',   1),
(3, 'Atendimento Emergencial','Falta de energia e riscos',          2);

INSERT INTO PARTICIPA (id_funcionario, id_equipe) VALUES
(5, 1), (6, 1), (8, 1),
(6, 2), (8, 2),
(7, 3), (8, 3);

-- LIDERA (histórico: a equipe 1 trocou de líder em 2024)
INSERT INTO LIDERA (id_funcionario, id_equipe, data_inicio, data_fim) VALUES
(6, 1, '2022-01-01', '2024-06-30'),
(5, 1, '2024-07-01', NULL),
(8, 2, '2023-01-01', NULL),
(7, 3, '2021-05-01', NULL);

INSERT INTO DEPENDENTE (id_funcionario, numero, nome, sexo, data_nascimento, parentesco) VALUES
(5, 1, 'Lucas Castro Silva',   'M', '2015-08-21', 'Filho'),
(5, 2, 'Marina Castro Silva',  'F', '2019-02-03', 'Filha'),
(6, 1, 'Patrícia Ribeiro',     'F', '1980-11-30', 'Cônjuge'),
(8, 1, 'Rafael Batista',       'M', '2020-06-15', 'Filho');

-- TARIFA (a residencial teve reajuste em 06/2025; a antiga é preservada)
INSERT INTO TARIFA (id, nome, valor_base, data_inicio, data_fim) VALUES
(1, 'B1 Residencial',  0.65000, '2024-01-01', '2025-05-31'),
(2, 'B1 Residencial',  0.69000, '2025-06-01', NULL),
(3, 'B3 Comercial',    0.72000, '2024-01-01', NULL),
(4, 'A4 Industrial',   0.55000, '2024-01-01', NULL);

INSERT INTO BANDEIRA (id, nome, valor_acrescimo, data_inicio, data_fim) VALUES
(1, 'Verde',               0.00000, '2025-01-01', '2025-05-31'),
(2, 'Amarela',             0.01885, '2025-06-01', '2025-07-31'),
(3, 'Vermelha Patamar 1',  0.04463, '2025-08-01', '2025-09-30'),
(4, 'Verde',               0.00000, '2025-10-01', '2025-12-31');

INSERT INTO UNIDADE_CONSUMIDORA (id, tipo, id_endereco, id_tarifa) VALUES
(1, 'residencial', 1,  2),
(2, 'residencial', 2,  2),
(3, 'residencial', 3,  2),
(4, 'comercial',   13, 3),
(5, 'industrial',  14, 4),
(6, 'residencial', 4,  2),
(7, 'comercial',   15, 3),
(8, 'residencial', 16, 2);

-- POSSUI (a unidade 2 trocou de titular: Bruno até 2024, Carla desde 2025)
INSERT INTO POSSUI (id_cliente, id_unidade, data_inicio, data_fim) VALUES
(1,  1, '2019-05-10', NULL),
(2,  2, '2020-02-01', '2024-12-31'),
(3,  2, '2025-01-01', NULL),
(4,  3, '2021-07-15', NULL),
(10, 4, '2018-03-01', NULL),
(11, 5, '2015-09-01', NULL),
(5,  6, '2022-04-01', NULL),
(12, 7, '2023-01-10', NULL),
(1,  8, '2024-08-01', NULL);

-- LEITURA_MENSAL (competências 05/2025 a 09/2025 para as 8 unidades)
INSERT INTO LEITURA_MENSAL (id, id_unidade, ano, mes, data_leitura, valor_anterior, valor_atual, data_vencimento, pago, id_tarifa, id_bandeira) VALUES
(1, 1, 2025, 5, '2025-05-28', 3500.0, 3719.0, '2025-06-10', TRUE, 1, 1),
(2, 1, 2025, 6, '2025-06-28', 3719.0, 3891.0, '2025-07-10', TRUE, 2, 2),
(3, 1, 2025, 7, '2025-07-28', 3891.0, 4125.0, '2025-08-10', TRUE, 2, 2),
(4, 1, 2025, 8, '2025-08-28', 4125.0, 4310.0, '2025-09-10', TRUE, 2, 3),
(5, 1, 2025, 9, '2025-09-28', 4310.0, 4551.0, '2025-10-10', TRUE, 2, 3),
(6, 2, 2025, 5, '2025-05-28', 8200.0, 8428.0, '2025-06-10', TRUE, 1, 1),
(7, 2, 2025, 6, '2025-06-28', 8428.0, 8688.0, '2025-07-10', TRUE, 2, 2),
(8, 2, 2025, 7, '2025-07-28', 8688.0, 8935.0, '2025-08-10', TRUE, 2, 2),
(9, 2, 2025, 8, '2025-08-28', 8935.0, 9169.0, '2025-09-10', TRUE, 2, 3),
(10, 2, 2025, 9, '2025-09-28', 9169.0, 9392.0, '2025-10-10', FALSE, 2, 3),
(11, 3, 2025, 5, '2025-05-28', 1200.0, 1458.0, '2025-06-10', TRUE, 1, 1),
(12, 3, 2025, 6, '2025-06-28', 1458.0, 1665.0, '2025-07-10', TRUE, 2, 2),
(13, 3, 2025, 7, '2025-07-28', 1665.0, 1808.0, '2025-08-10', TRUE, 2, 2),
(14, 3, 2025, 8, '2025-08-28', 1808.0, 2055.0, '2025-09-10', FALSE, 2, 3),
(15, 3, 2025, 9, '2025-09-28', 2055.0, 2254.0, '2025-10-10', FALSE, 2, 3),
(16, 4, 2025, 5, '2025-05-28', 45000.0, 46155.0, '2025-06-10', TRUE, 3, 1),
(17, 4, 2025, 6, '2025-06-28', 46155.0, 47719.0, '2025-07-10', TRUE, 3, 2),
(18, 4, 2025, 7, '2025-07-28', 47719.0, 48672.0, '2025-08-10', TRUE, 3, 2),
(19, 4, 2025, 8, '2025-08-28', 48672.0, 49732.0, '2025-09-10', TRUE, 3, 3),
(20, 4, 2025, 9, '2025-09-28', 49732.0, 50747.0, '2025-10-10', TRUE, 3, 3),
(21, 5, 2025, 5, '2025-05-28', 310000.0, 331045.0, '2025-06-10', TRUE, 4, 1),
(22, 5, 2025, 6, '2025-06-28', 331045.0, 352887.0, '2025-07-10', TRUE, 4, 2),
(23, 5, 2025, 7, '2025-07-28', 352887.0, 378001.0, '2025-08-10', TRUE, 4, 2),
(24, 5, 2025, 8, '2025-08-28', 378001.0, 398020.0, '2025-09-10', TRUE, 4, 3),
(25, 5, 2025, 9, '2025-09-28', 398020.0, 419139.0, '2025-10-10', TRUE, 4, 3),
(26, 6, 2025, 5, '2025-05-28', 2600.0, 2809.0, '2025-06-10', TRUE, 1, 1),
(27, 6, 2025, 6, '2025-06-28', 2809.0, 2962.0, '2025-07-10', TRUE, 2, 2),
(28, 6, 2025, 7, '2025-07-28', 2962.0, 3175.0, '2025-08-10', TRUE, 2, 2),
(29, 6, 2025, 8, '2025-08-28', 3175.0, 3346.0, '2025-09-10', TRUE, 2, 3),
(30, 6, 2025, 9, '2025-09-28', 3346.0, 3487.0, '2025-10-10', FALSE, 2, 3),
(31, 7, 2025, 5, '2025-05-28', 15800.0, 16921.0, '2025-06-10', TRUE, 3, 1),
(32, 7, 2025, 6, '2025-06-28', 16921.0, 18238.0, '2025-07-10', TRUE, 3, 2),
(33, 7, 2025, 7, '2025-07-28', 18238.0, 19424.0, '2025-08-10', TRUE, 3, 2),
(34, 7, 2025, 8, '2025-08-28', 19424.0, 20510.0, '2025-09-10', TRUE, 3, 3),
(35, 7, 2025, 9, '2025-09-28', 20510.0, 21808.0, '2025-10-10', FALSE, 3, 3),
(36, 8, 2025, 5, '2025-05-28', 900.0, 1060.0, '2025-06-10', TRUE, 1, 1),
(37, 8, 2025, 6, '2025-06-28', 1060.0, 1297.0, '2025-07-10', TRUE, 2, 2),
(38, 8, 2025, 7, '2025-07-28', 1297.0, 1539.0, '2025-08-10', TRUE, 2, 2),
(39, 8, 2025, 8, '2025-08-28', 1539.0, 1688.0, '2025-09-10', TRUE, 2, 3),
(40, 8, 2025, 9, '2025-09-28', 1688.0, 1845.0, '2025-10-10', TRUE, 2, 3);

-- CHAMADO (o 4 não se refere a nenhuma unidade; o 7 ainda não tem equipe)
INSERT INTO CHAMADO (id, data_abertura, descricao, tipo, prioridade, situacao, data_fechamento, id_cliente, id_unidade) VALUES
(1, '2025-06-03 08:15:00', 'Falta de energia na residência',          'Falta de energia',  'alta',  'concluido',    '2025-06-03 13:40:00', 1,  1),
(2, '2025-06-20 10:02:00', 'Poste com fiação solta em frente à loja', 'Risco na rede',     'alta',  'concluido',    '2025-06-21 09:10:00', 10, 4),
(3, '2025-07-11 14:30:00', 'Pedido de ligação nova',                  'Ligação nova',      'media', 'concluido',    '2025-07-18 16:00:00', 1,  8),
(4, '2025-07-25 09:45:00', 'Dúvida sobre bandeira tarifária',         'Informação',        'baixa', 'concluido',    '2025-07-25 10:05:00', 4,  NULL),
(5, '2025-08-14 19:20:00', 'Oscilação de tensão na linha de produção','Qualidade',         'alta',  'em_andamento', NULL,                  11, 5),
(6, '2025-09-02 07:50:00', 'Medidor com display apagado',             'Medidor',           'media', 'concluido',    '2025-09-05 11:30:00', 3,  2),
(7, '2025-09-30 16:10:00', 'Contestação do valor da fatura',          'Fatura',            'baixa', 'aberto',       NULL,                  12, 7),
(8, '2025-10-05 22:05:00', 'Queda de árvore sobre a rede',            'Risco na rede',     'alta',  'em_andamento', NULL,                  5,  6);

-- ATENDE (o chamado 2 foi atendido por duas equipes)
INSERT INTO ATENDE (id_chamado, id_equipe, data_atendimento) VALUES
(1, 3, '2025-06-03'),
(2, 3, '2025-06-20'),
(2, 1, '2025-06-21'),
(3, 2, '2025-07-17'),
(5, 1, '2025-08-15'),
(6, 2, '2025-09-04'),
(8, 3, '2025-10-05'),
(8, 1, '2025-10-06');
