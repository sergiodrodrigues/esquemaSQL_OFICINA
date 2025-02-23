USE oficina;



-- 1. Recuperações simples com SELECT Statement:

-- Listar todos os clientes:

SELECT * FROM Cliente;

-- Listar nomes e modelos de todos os veículos:

SELECT modeloVeiculo, placaVeiculo FROM Veiculo;

-- Listar todos os nomes e especialidades dos mecânicos:

SELECT nomeMecanico, especialidadeMecanico FROM Mecanico;




-- 2. Filtros com WHERE Statement:

-- Listar clientes que moram na Rua A:

SELECT * FROM Cliente WHERE enderecoCliente LIKE '%Rua A%';

-- Listar veículos do cliente com id 2:

SELECT * FROM Veiculo WHERE idCliente = 2;

-- Listar serviços com valor de mão de obra superior a R$ 50:

SELECT * FROM Serviço WHERE valor_Mao_Obra > 50.00;




-- 3. Crie expressões para gerar atributos derivados:

-- Calcular o valor total de cada ordem de serviço (soma de serviços e peças):

SELECT os.idOrdem_Serviço, os.valor_Ordem_Serviço,
       (os.valor_Ordem_Serviço + COALESCE(SUM(p.valorPeça), 0) + COALESCE(SUM(s.valor_Mao_Obra), 0)) AS valor_total
FROM Ordem_Serviço os
LEFT JOIN Ordem_Serviço_Peça osp ON os.idOrdem_Serviço = osp.idOrdem_Serviço
LEFT JOIN Peça p ON osp.idPeça = p.idPeça
LEFT JOIN Ordem_Serviço_Serviço oss ON os.idOrdem_Serviço = oss.idOrdem_Serviço
LEFT JOIN Serviço s ON oss.idServiço = s.idServiço
GROUP BY os.idOrdem_Serviço;

-- Calcular o valor total de peças por ordem de serviço:
 
SELECT os.idOrdem_Serviço, COALESCE(SUM(p.valorPeça), 0) AS valor_total_pecas
FROM Ordem_Serviço os
LEFT JOIN Ordem_Serviço_Peça osp ON os.idOrdem_Serviço = osp.idOrdem_Serviço
LEFT JOIN Peça p ON osp.idPeça = p.idPeça
GROUP BY os.idOrdem_Serviço;

-- Calcular o tempo decorrido desde a emissão da ordem de serviço em dias:

SELECT idOrdem_Serviço, dataEmissao_Ordem_Serviço,
       DATEDIFF(CURDATE(), dataEmissao_Ordem_Serviço) AS dias_decorridos
FROM Ordem_Serviço;




-- 4. Defina ordenações dos dados com ORDER BY:

-- Listar clientes em ordem alfabética:

SELECT * FROM Cliente ORDER BY nomeCliente ASC;

-- Listar veículos em ordem decrescente de modelo:

SELECT * FROM Veiculo ORDER BY modeloVeiculo DESC;

-- Listar serviços em ordem crescente de valor de mão de obra:

SELECT * FROM Serviço ORDER BY valor_Mao_Obra ASC;




-- 5. Condições de filtros aos grupos – HAVING Statement:

-- Listar peças que custam mais de R$ 100 e que aparecem em mais de 1 ordem de serviço:

SELECT p.nomePeça, p.valorPeça, COUNT(osp.idOrdem_Serviço) AS quantidade_ordens
FROM Peça p
LEFT JOIN Ordem_Serviço_Peça osp ON p.idPeça = osp.idPeça
WHERE p.valorPeça > 100
GROUP BY p.nomePeça, p.valorPeça
HAVING COUNT(osp.idOrdem_Serviço) > 1;

-- Listar mecânicos que trabalharam em mais de uma ordem de serviço:

SELECT m.nomeMecanico, COUNT(osm.idOrdem_Serviço) AS quantidade_ordens
FROM Mecanico m
JOIN Ordem_Serviço_Mecanico osm ON m.idMecanico = osm.idMecanico
GROUP BY m.nomeMecanico
HAVING COUNT(osm.idOrdem_Serviço) > 1;

-- Listar serviços que aparecem em mais de uma ordem de serviço:

SELECT s.descricaoServiço, COUNT(oss.idOrdem_Serviço) AS quantidade_ordens
FROM Serviço s
JOIN Ordem_Serviço_Serviço oss ON s.idServiço = oss.idServiço
GROUP BY s.descricaoServiço
HAVING COUNT(oss.idOrdem_Serviço) > 1;




-- 6. Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados:

-- Listar nome do cliente, modelo do veículo e data de emissão da ordem de serviço:

SELECT c.nomeCliente, v.modeloVeiculo, os.dataEmissao_Ordem_Serviço
FROM Cliente c
JOIN Veiculo v ON c.idCliente = v.idCliente
JOIN Ordem_Serviço os ON v.idVeiculo = os.idVeiculo;

-- Listar nome do mecânico e especialidade, e ordem de serviço que realizou:

SELECT m.nomeMecanico, m.especialidadeMecanico, os.idOrdem_Serviço
FROM Mecanico m
JOIN Ordem_Serviço_Mecanico osm ON m.idMecanico = osm.idMecanico
JOIN Ordem_Serviço os ON osm.idOrdem_Serviço = os.idOrdem_Serviço;


-- Obter informações detalhadas sobre as ordens de serviço, incluindo clientes, veículos, mecânicos, serviços e peças

SELECT
    c.nomeCliente,
    v.modeloVeiculo,
    os.idOrdem_Serviço,
    os.dataEmissao_Ordem_Serviço,
    m.nomeMecanico,
    s.descricaoServiço,
    p.nomePeça
FROM
    Cliente c
JOIN
    Veiculo v ON c.idCliente = v.idCliente
JOIN
    Ordem_Serviço os ON v.idVeiculo = os.idVeiculo
LEFT JOIN
    Ordem_Serviço_Mecanico osm ON os.idOrdem_Serviço = osm.idOrdem_Serviço
LEFT JOIN
    Mecanico m ON osm.idMecanico = m.idMecanico
LEFT JOIN
    Ordem_Serviço_Serviço oss ON os.idOrdem_Serviço = oss.idOrdem_Serviço
LEFT JOIN
    Serviço s ON oss.idServiço = s.idServiço
LEFT JOIN
    Ordem_Serviço_Peça osp ON os.idOrdem_Serviço = osp.idOrdem_Serviço
LEFT JOIN
    Peça p ON osp.idPeça = p.idPeça
ORDER BY
    os.idOrdem_Serviço;
