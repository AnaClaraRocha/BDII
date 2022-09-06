
--1. Criar uma stored procedure “Busca_Aluno” que receba o código do aluno e retorne seu nome e
--data de nascimento

CREATE PROCEDURE spBuscarAluno


--2. Criar uma stored procedure “Insere_Aluno” que insira um registro na tabela de Alunos.

 CREATE PROCEDURE spInsereAluno
	@nomeAluno VARCHAR (70), @dataNascimentoAluno DATETIME, @rgAluno VARCHAR (14), 
	@naturaAluno VARCHAR (2)
AS
	INSERT INTO tbAluno(nomeAluno,dataNascimentoAluno,rgAluno,naturaAluno)
	VALUES
		(@nomeAluno, @dataNascimentoAluno, @rgAluno, @naturaAluno)
	
	DECLARE @codAluno INT =(SELECT MAX(codAluno) FROM tbAluno)
	PRINT('Aluno cadastrado com sucesso com codigo'+CONVERT(VARCHAR(6),@codAluno) )

EXEC spInsereAluno 'Ana Ferraz','18/11/1989','13652245-x', 'Sp'
SELECT * FROM tbAluno

--3. Criar uma stored procedure “Aumenta_Preco” que, dados o nome do
--curso e um percentual, aumente o valor do curso com a porcentagem informada
 CREATE PROCEDURE spAumentaPreco


--6- Criar uma stored procedure para inserir alunos, verificando pelo cpf
--se o aluno existe ou não, e informar essa condição via mensagemCREATE  PROCEDURE spVerificarRg
	@nomeAluno VARCHAR (70), @dataNascimentoAluno DATETIME, @rgAluno VARCHAR (14), 
	@naturaAluno VARCHAR (2)
AS
	IF  EXISTS (SELECT rgAluno FROM tbAluno WHERE  rgAluno LIKE @rgAluno)
	BEGIN
	PRINT ('Impossivel cadastrar aluno'+@nomeAluno+'pois o rg '+@rgAluno+'ja existe')
	END
	ELSE 
	BEGIN
			INSERT INTO tbAluno(nomeAluno,dataNascimentoAluno,rgAluno,naturaAluno)
			VALUES
				(@nomeAluno, @dataNascimentoAluno, @rgAluno, @naturaAluno)
	
			DECLARE @codAluno INT =(SELECT MAX(codAluno) FROM tbAluno)
			PRINT('Aluno cadastrado com sucesso com codigo'+CONVERT(VARCHAR(6),@codAluno) )
	END

		EXEC spInsereAluno 'Vanessa Ferraz','18/11/1989','13652245-x', 'Sp'
		SELECT * FROM tbAluno