USE bdEstoque

UPDATE tbProduto
SET  valorProduto =  valorProduto - (valorProduto * 0.1)
WHERE codFornecedor = 1

UPDATE tbProduto
SET  valorProduto =  valorProduto - (valorProduto * 0.07)
WHERE codFornecedor = 1

UPDATE tbCliente
SET nomeCliente = 'Adriana Nogueira Silva Campos'
WHERE tbCliente = 3
