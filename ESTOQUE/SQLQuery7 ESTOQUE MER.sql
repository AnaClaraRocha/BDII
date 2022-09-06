CREATE DATABASE bdEstoque

USE bdEstoque

CREATE TABLE tbCliente(
	codCliente INT PRIMARY KEY IDENTITY(1,1)
	, nomeCliente VARCHAR(60) NOT NULL
	, cpfCliente CHAR(14) NOT NULL
	, emailCliente VARCHAR(30) NOT NULL
	, sexoCliente CHAR(5) NOT NULL
	, dataNascimentoCliente DATETIME NOT NULL
)

CREATE TABLE tbVenda(
     codVenda INT PRIMARY KEY IDENTITY(1,1)
	 , dataVenda DATETIME NOT NULL​
	 , valorTotalVenda MONEY NOT NULL
	 , codCliente INT FOREIGN KEY REFERENCES tbCliente(codCliente)
)

CREATE TABLE tbFabricante(
      codFabricante INT PRIMARY KEY IDENTITY(1,1)
	  , nomeFabricante VARCHAR(30) NOT NULL
)

CREATE TABLE tbFornecedor(
      codFornecedor INT PRIMARY KEY IDENTITY(1,1)
	  , nomeFornecedor VARCHAR(30) NOT NULL
	  , contatoFornecedor VARCHAR(60) NOT NULL
)

CREATE TABLE tbProduto(
     codProduto INT PRIMARY KEY IDENTITY(1,1)
	 , descricaoProduto CHAR(50) NOT NULL
	 , valorProduto MONEY NOT NULL​
	 , quantidadeProduto INT NOT NULL
	 , codFabricante INT FOREIGN KEY REFERENCES tbFabricante(codFabricante)
	 , codFornecedor INT FOREIGN KEY REFERENCES tbFornecedor(codFornecedor)
)

CREATE TABLE tbItensVenda(
      codItensVenda INT PRIMARY KEY IDENTITY(1,1)
	  , codVenda INT FOREIGN KEY REFERENCES tbVenda(codVenda)
	  , codProduto INT FOREIGN KEY REFERENCES tbProduto(codProduto)
	  , quantidadeItensVenda INT NOT NULL
	  , subTotalItensVenda  MONEY NOT NULL
)