
USE bdLoja

-- A) Criar uma Stored Procedure para inserir as 
-- categorias de produto conforme abaixo:

CREATE PROCEDURE spCategProduto
 @nomeCategoriaProduto VARCHAR(20)
AS
	
		INSERT INTO tbCategoriaProduto(nomeCategoriaProduto)
		VALUES
		 (@nomeCategoriaProduto)
		 
		 PRINT ('A categoria '+@nomeCategoriaProduto+' foi cadastrada com sucesso')
	
	EXEC spCategProduto 'Bolo Festa'
	EXEC spCategProduto 'Bolo Simples'
	EXEC spCategProduto 'Torta'
	EXEC spCategProduto 'Salgado'

	SELECT * FROM tbCategoriaProduto

-- B) Criar uma Stored Procedure para inserir os produtos abaixo, sendo que, a procedure
-- dever� antes de inserir verificar se o nome do produto j� existe, evitando assim que 
-- um produto seja duplicado:

CREATE PROCEDURE spInseProduto
  @nomeProduto VARCHAR(60) ,@precoKiloProduto MONEY , @codCategoriaProduto INT
AS
	IF EXISTS (SELECT nomeProduto from tbProduto WHERE nomeProduto LIKE @nomeProduto)
	BEGIN
		PRINT ('N�o foi cadastrado pois o produto '+@nomeProduto+' j� existe')
	END
	ELSE
	BEGIN
		INSERT INTO tbProduto(nomeProduto, precoKiloProduto, codCategoriaProduto)
		VALUES
		 (@nomeProduto, @precoKiloProduto, @codCategoriaProduto)
		 
		 PRINT ('O produto '+@nomeProduto+' foi cadastrado com sucesso')
	END

	EXEC spInseProduto 'Bolo Floresta Negra', '42.00', 1
	EXEC spInseProduto 'Bolo Prestigio', '43.00', 1
	EXEC spInseProduto 'Bolo Nutella', '44.00', 1
	EXEC spInseProduto 'Bolo Formigueiro', '17.00', 2
	EXEC spInseProduto 'Bolo de cenoura', '19.00', 2
	EXEC spInseProduto 'Torta de palmito', '45.00', 3
	EXEC spInseProduto 'Torta de frango e catupiry', '47.00', 3
	EXEC spInseProduto 'Torta de escarola', '44.00', 3
	EXEC spInseProduto 'Coxinha frango', '25.00', 4
	EXEC spInseProduto 'Esfiha carne', '27.00', 4
	EXEC spInseProduto 'Folhado queijo', '31.00', 4
	EXEC spInseProduto 'Risoles misto', '29.00', 4

	SELECT * FROM tbProduto

-- c) Criar uma stored procedure para cadastrar os clientes abaixo relacionados, sendo que dever�o ser feitas duas valida��es:
-- Verificar pelo CPF se o cliente j� existe. Caso j� exista emitir a mensagem: �Cliente cpf XXXXX j� cadastrado�
-- Verificar se o cliente � morador de Itaquera ou Guaianases, pois a confeitaria n�o realiza
-- entregas para clientes que residam fora desses bairros. Caso o cliente n�o seja morador desses
-- bairros enviar a mensagem �N�o foi poss�vel cadastrar o cliente XXXX pois o bairro XXXX n�o �
-- atendido pela confeitaria

CREATE PROCEDURE spCadasCliente
	@nomeCliente VARCHAR(60) ,@dataNascimentoCliente DATETIME , @ruaCliente VARCHAR(30), @numCasaCliente VARCHAR(10), 
	@cepCliente VARCHAR(15), @bairroCliente VARCHAR(15), @cidadeCliente VARCHAR(15), @estadoCliente CHAR(2), 
	@cpfCliente CHAR(14), @sexoCliente VARCHAR(1)
AS
	IF EXISTS (SELECT  cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
	BEGIN
		PRINT ('Cliente cpf '+@cpfCliente+'j� cadastrado')
	END
	Else IF NOT (@bairroCliente LIKE 'Guainases' or @bairroCliente LIKE 'Itaquera')
		PRINT ('N�o foi poss�vel cadastrar o cliente '+@nomeCliente+' pois o bairro '+@bairroCliente+' n�o � atendido pela confeitaria')
	ELSE
	BEGIN
		INSERT INTO tbCliente(nomeCliente, dataNascimentoCliente, ruaCliente, numCasaCliente, cepCliente, bairroCliente, cidadeCliente, estadoCliente, cpfCliente, sexoCliente)
		VALUES
		 (@nomeCliente, @dataNascimentoCliente, @ruaCliente, @numCasaCliente, @cepCliente, @bairroCliente, @cidadeCliente, @estadoCliente, @cpfCliente, @sexoCliente)
		 
		 PRINT ('O cliente '+@nomeCliente+' foi cadastrado com sucesso')

	END
	
	EXEC spCadasCliente 'Samira Fatah', '05/05/1990', 'Rua Aguape�', '1000', '08.090-000','Guainases','SP', 'SP', '945.946.860-87', 'F'
	EXEC spCadasCliente 'Ceila Nogueira', '06/06/1992', 'Rua Andes', '234', '08.456-090','Guainases','SP', 'SP', '871.715.600-90', 'F'
	EXEC spCadasCliente 'Paulo Cesar Siqueira', '04/04/1984', 'Rua Castelo do Piau�', '232', '08.109-000','Itaquera','SP', 'SP', '134.140.310-60', 'M'
	EXEC spCadasCliente 'Rodrigo Favaroni', '09/04/1991', 'Rua Sans�o Castelo Branco', '10', '08.431-090','Guainases','SP', 'SP', '914.371.000-07', 'M'
	EXEC spCadasCliente 'Fl�via Regina Brito', '22/04/1992', 'Rua Mariano Moro', '300', '08.200-123','Itaquera','SP', 'SP', '994.703.350-31', 'F'

	SELECT * FROM tbCliente

--d) Criar via stored procedure as encomendas abaixo relacionadas, fazendo as verifica��es abaixo: 
-- No momento da encomenda o cliente ir� fornecer o seu cpf. Caso ele n�o tenha sido
--cadastrado enviar a mensagem �n�o foi poss�vel efetivar a encomenda pois o cliente xxxx n�o st� cadastrado�
-- Verificar se a data de entrega da encomenda n�o anterior � data atual. Caso seja enviar a
-- mensagem �n�o � poss�vel efetuar uma encomenda numa data anterior � data atual�
-- Caso tudo esteja correto, efetuar a encomenda e emitir a mensagem: �Encomenda XXX para
-- o cliente YYY efetuada com sucesso� sendo que no lugar de XXX dever� aparecer o n�mero da
-- encomenda e no YYY dever� aparecer o nome do cliente;

CREATE PROCEDURE spEncomendas
 @cpf CHAR(14), @valorTotalEncomenda SMALLMONEY, @dataEntregaEncomenda DATE
AS
	IF NOT EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpf)
		BEGIN
	PRINT ('N�o foi poss�vel efetivar a encomenda pois o cliente com o CPF: '+@cpf+' n�o est� cadastrado')
		END
	ELSE IF (@dataEntregaEncomenda > GETDATE())
		BEGIN
			PRINT ('n�o � poss�vel efetuar uma encomenda numa data anterior � data atual')
			END
		
	ELSE
		BEGIN
			DECLARE @codCliente INT, @nomeCliente VARCHAR(50)
			SELECT @codCliente=codCliente, @nomeCliente=nomeCliente FROM tbCliente WHERE cpfCliente LIKE @cpf

			INSERT INTO tbencomenda (dataEncomenda, codCliente, valorTotalEncomenda, dataEntregaEncomenda) 
			VALUES (GETDATE(), @codCliente, @valorTotalEncomenda, @dataEntregaEncomenda)

			DECLARE @codEncomenda INT
			SELECT @codEncomenda = MAX(codEncomenda) FROM tbEncomenda 
			PRINT('Encomenda '+ CONVERT(VARCHAR(6), @codEncomenda) +' para o cliente '+ @nomeCliente +' feita com sucesso')
		END

    EXEC spEncomendas '134.140.310-60', 450, '24/02/2022' -- // COM 
	EXEC spEncomendas '945.946.860-92', 100, '18/05/2022' -- SEM

	SELECT * FROM tbEncomenda
	SELECT * FROM tbCliente

--e) Ao adicionar a encomenda, criar uma Stored procedure, para que sejam inseridos os itens da encomenda conforme tabela a seguir.
-- Itens da encomenda:

ALTER PROCEDURE spAdicEncomenda
	@qtdeKilosItensEncomenda DECIMAL, @subTotalItensEncomenda MONEY, @codEncomenda INT, @codProduto INT
AS
		DECLARE @nomeProduto VARCHAR(60) = (SELECT nomeProduto FROM tbProduto WHERE @codProduto = codProduto)
		INSERT INTO tbItensEncomenda(qtdeKilosItensEncomenda, subTotalItensEncomenda, codEncomenda, codProduto)
		VALUES
		 (@qtdeKilosItensEncomenda, @subTotalItensEncomenda, @codEncomenda, @codProduto)

		 PRINT ('O produto '+@nomeProduto+' da encomenda com numero '+CONVERT (VARCHAR(6), @codEncomenda)+' foi cadastrada com sucesso')

	EXEC spAdicEncomenda '2.5', '105.00', 1, 1
	EXEC spAdicEncomenda'2.6', '70.00', 1, 10
	EXEC spAdicEncomenda '6', '150.00', 1, 9
	EXEC spAdicEncomenda '4.3', '125.00', 1, 12
	EXEC spAdicEncomenda '8', '200.00', 2, 9
	EXEC spAdicEncomenda '3.2', '100.00', 3, 11 --
	EXEC spAdicEncomenda '2', '50.00', 3, 9 --
	EXEC spAdicEncomenda '3.5', '150.00', 4, 2 --
	EXEC spAdicEncomenda '2.2', '100.00', 4, 3 --
	EXEC spAdicEncomenda '3.4', '150.00', 5, 6 --

	SELECT * FROM tbItensEncomenda

-- f) Ap�s todos os cadastros, criar Stored procedures para alterar o que se pede:
-- 1- O pre�o dos produtos da categoria �Bolo festa� sofreram um aumento de 10%
-- 2- O pre�o dos produtos categoria �Bolo simples� est�o em promo��o e ter�o um desconto de 20%;
-- 3- O pre�o dos produtos categoria �Torta� aumentaram 25%
-- 4- O pre�o dos produtos categoria �Salgado�, com exce��o da esfiha de carne, sofreram um
-- aumento de 20%

-- 1

CREATE PROCEDURE spAlteracao
AS
	UPDATE tbProduto
		SET precoKiloProduto = (precoKiloProduto + (0.1 * precoKiloProduto))
		WHERE codCategoriaProduto = 1

		EXEC spAlteracao
		SELECT * FROM tbProduto

-- 2

	UPDATE tbProduto
	Set precoKiloProduto = (precoKiloProduto + (0.2 * precoKiloProduto))
	WHERE codCategoriaProduto = 2

	EXEC spAlteracao
	SELECT * FROM tbProduto

-- 3

    UPDATE tbProduto
	Set precoKiloProduto = (precoKiloProduto + (0.25 * precoKiloProduto))
	WHERE codCategoriaProduto = 3

	EXEC spAlteracao
	SELECT * FROM tbProduto

-- 4

    UPDATE tbProduto
	SET precoKiloProduto = precoKiloProduto * 1.2 
	WHERE codCategoriaProduto = 4 and  NOT codProduto = 10

	EXEC spAlteracao
	SELECT * FROM tbProduto

--g) Criar uma procedure para excluir clientes pelo CPF sendo que:
--1- Caso o cliente possua encomendas emitir a mensagem �Impossivel remover esse cliente pois o
-- cliente XXXXX possui encomendas; onde XXXXX � o nome do cliente.
-- 2- Caso o cliente n�o possua encomendas realizar a remo��o e emitir a mensagem �Cliente XXXX
-- removido com sucesso�, onde XXXX � o nome do cliente;

ALTER PROCEDURE spExcluirCliente
	@cpfCliente CHAR(14)
AS
	DECLARE @codCliente INT 
	DECLARE @nomeCliente VARCHAR(60)

	IF NOT EXISTS (SELECT cpfCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
	BEGIN
		PRINT ('Imposs�vel remover! Cliente '+@cpfCliente+' n�o existe!')
	END
	ELSE
	BEGIN
		SET @codCliente = (SELECT codCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
		SET @nomeCliente = (SELECT nomeCliente FROM tbCliente WHERE cpfCliente LIKE @cpfCliente)
		IF EXISTS (SELECT codCliente FROM tbEncomenda WHERE codCliente = @codCliente)
		BEGIN
			PRINT('Impossivel remover! Cliente com cpf '+@cpfCliente+' e nome '+@nomeCliente+' possui encomendas!')
		END
		ELSE
		BEGIN
			DELETE tbCliente
				WHERE codCliente =  @codCliente
			PRINT ('Cliente com cpf '+@cpfCliente+' e nome '+@nomeCliente+' removido com sucesso!')
		END
	END

	EXEC spExcluirCliente '914.371.000-07'

	SELECT * FROM tbCliente
	SELECT * FROM tbEncomenda

-- h) Criar uma procedure que permita excluir qualquer item de uma encomenda cuja data de
-- entrega seja menor que a data atual. Para tal o cliente dever� fornecer o c�digo da encomenda
-- e o c�digo do produto que ser� exclu�do da encomenda. A procedure dever� remover o item e
-- atualizar o valor total da encomenda, do qual dever� ser subtra�do o valor do item a ser
-- removido. A procedure poder� remover apenas um item da encomenda de cada vez.

ALTER PROCEDURE spExcluiItem
@codEncomenda INT, @codProduto INT
AS
	DECLARE @nomeProduto VARCHAR(60) = (SELECT nomeProduto FROM tbProduto WHERE @codProduto = codProduto)

	DECLARE @precoProduto SMALLMONEY = (SELECT subTotalItensEncomenda FROM tbItensEncomenda WHERE codProduto = @codProduto)
	DECLARE @dataEntregaEncomenda SMALLDATETIME = (SELECT dataEntregaEncomenda FROM tbEncomenda WHERE codEncomenda = @codEncomenda)
	IF (@dataEntregaEncomenda < GETDATE())
		BEGIN
			DELETE FROM tbItensEncomenda
			WHERE codEncomenda = @codEncomenda AND codProduto = @codProduto
			PRINT ('produto '+@nomeProduto+' foi removido com sucesso')

			UPDATE tbEncomenda
			SET valortotalEncomenda = valortotalEncomenda - @precoProduto
			WHERE codEncomenda LIKE @codEncomenda 
		END

		EXEC spExcluiItem '4', '9'

		SELECT * FROM tbItensEncomenda
