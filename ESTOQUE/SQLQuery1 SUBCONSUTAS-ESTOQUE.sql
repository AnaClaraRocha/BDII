--SUBCONSULTAS

USE bdEstoque

--1 Criar uma consulta que retorne o c�digo do produto, o nome do produto e o nome do fabricante somente 
-- daqueles produtos que custam igual ao valor mais alto;

SELECT codProduto, descricaoProduto, nomeFabricante, valorProduto FROM tbProduto
INNER JOIN tbFabricante ON tbProduto.codFabricante = tbFabricante.codFabricante
WHERE valorProduto = (SELECT  MAX (valorProduto) FROM tbproduto)

-- 2 - Criar uma consulta que retorne o nome do produto e o nome do fabricante e o valor somente dos produtos que
-- custem acima do valor m�dio dos produtos em estoque

SELECT descricaoProduto AS Produto, nomeFabricante AS Fabricante, valorProduto AS Valor FROM tbProduto
INNER JOIN tbFabricante ON tbProduto.codFabricante = tbFabricante.codFabricante
WHERE valorProduto > (SELECT  AVG (valorProduto) FROM tbproduto)

-- 3 - Criar uma consulta que retorne o nome dos clientes que tiveram vendas
-- com valor acima do valor m�dio das vendas

SELECT nomeCliente AS Cliente, valorTotalVenda AS Valor FROM tbCliente
INNER JOIN tbVenda ON tbCliente.codCliente = tbVenda.codVenda
WHERE valorTotalVenda > (SELECT  AVG (valorTotalVenda) FROM tbVenda)

-- 4 - Criar uma consulta que retorne o nome e o pre�o dos produtos mais caros

SELECT descricaoProduto AS Produto, valorProduto AS Valor FROM tbProduto
WHERE valorProduto IN (SELECT MAX  (valorProduto) FROM tbproduto)

-- 5 - Criar uma consulta que retorne o nome e o pre�o do produto mais barato

SELECT descricaoProduto AS Produto, valorProduto AS Valor FROM tbProduto
WHERE valorProduto IN (SELECT MIN  (valorProduto) FROM tbproduto)







