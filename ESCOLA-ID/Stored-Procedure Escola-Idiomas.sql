-- STORED PROCEDURE

USE bdEscolaIdiomas

--1. Criar uma stored procedure “Busca_Aluno” que receba o código do aluno e retorne seu nome e
--data de nascimento

   ALTER  PROCEDURE spBuscarAluno
   @codAluno INT
   AS
   SELECT nomeAluno AS Aluno, dataNascimentoAluno AS Nascimento FROM tbAluno
   WHERE codAluno = @codAluno

   EXEC spBuscarAluno 
   @codAluno = 1
   SELECT *FROM tbAluno


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

	EXEC spInsereAluno 'Ana','18/11/1989','13652245-x', 'Sp'
	SELECT * FROM tbAluno

--3. Criar uma stored procedure “Aumenta_Preco” que, dados o nome do
--curso e um percentual, aumente o valor do curso com a porcentagem informada. 

    alter PROCEDURE spAumentaPreco
   	@nomeCurso VARCHAR (10) , @aumentoCurso DECIMAL
    AS 
	UPDATE tbCurso SET valorcurso = valorcurso + (valorcurso/100*@aumentoCurso)	
    begin 
	SELECT nomecurso AS Nome, valorCurso AS Valor FROM tbCurso
	WHERE @nomeCurso = nomeCurso
    END

	EXEC spAumentaPreco 'Espanhol' , 100
	

--4. Criar uma stored procedure “Exibe_Turma” que, dado o nome da turma exiba todas as
-- informações dela.

	CREATE PROCEDURE spExibeTurma
	@nomeTurma VARCHAR(10)
	AS
	SELECT nomeTurma AS Turma, horaTurma AS Horario, codCurso FROM tbTurma
	WHERE nomeTurma = @nomeTurma

	EXEC spExibeTurma '1|C'

-- 5. Criar uma stored procedure “Exibe_AlunosdaTurma” que, dado o nome
--da turma exiba os seus alunos.

	CREATE PROCEDURE spExibeAluTurma
	@nomeTurma VARCHAR(10)
	AS
	SELECT nomeTurma AS Turma, nomeAluno AS Aluno FROM tbTurma
	INNER JOIN tbMatricula ON tbTurma.codTurma = tbMatricula.codTurma
	INNER JOIN tbAluno ON tbMatricula.codAluno = tbAluno.codAluno
	WHERE nomeTurma = @nomeTurma
	
	EXEC spExibeAluTurma '1|A'
   
--6- Criar uma stored procedure para inserir alunos, verificando pelo cpf
--se o aluno existe ou não, e informar essa condição via 

CREATE PROCEDURE spVerificarRg
	@nomeAluno VARCHAR(70), @dataNascAluno SMALLDATETIME, @rgAluno VARCHAR (14), @naturaAlunoAluno VARCHAR(20)	
AS
	IF EXISTS (SELECT rgAluno FROM	tbAluno WHERE rgAluno LIKE @rgAluno)
	BEGIN
		PRINT ('Não foi possivel cadastrar o aluno ' +@nomeAluno+', pois o RG '+@rgAluno+' já existe')
	END
	ELSE
	BEGIN
		INSERT tbAluno(nomeAluno, dataNascimentoAluno, rgAluno, naturaAluno)
			VALUES
				(@nomeAluno, @dataNascAluno, @rgAluno, @naturaAlunoAluno)

			DECLARE @codAluno INT =(SELECT MAX (codAluno) FROM tbAluno)
			PRINT ('Aluno de código ' +CONVERT(VARCHAR(7), @codAluno)+' cadastrado com sucesso!')
	END

		EXEC spInsereAluno 'Vanessa Ferraz','18/11/1989','13652248-x', 'Sp' 
		SELECT * FROM tbAluno

-- 7- Criar uma stored procedure que receba o nome do curso e o nome
-- do aluno e matricule o mesmo no curso pretendido

	CREATE PROCEDURE spMatriCurso
	@nomeCurso VARCHAR(40), @nomeAluno VARCHAR (40)
AS
    IF EXISTS (SELECT nomeAluno FROM tbAluno WHERE nomeAluno LIKE  @nomeAluno)
     BEGIN
          
        DECLARE @codAluno INT = (SELECT codAluno FROM tbAluno WHERE nomeAluno = @nomeAluno)
        DECLARE @codCurso INT = (SELECT codCurso FROM tbCurso WHERE nomeCurso = @nomeCurso)
        DECLARE @codTurma INT = (SELECT MAX(codTurma) FROM tbTurma WHERE codCurso = @codCurso)
         
          INSERT tbMatricula (dataMatricula, codAluno,codTurma)
           VALUES (GETDATE( ),@codAluno, @codTurma)
    
     END

	ELSE
	BEGIN
		PRINT('Não existe nenhum aluno com este nome em nosso banco de dados')
	END

	EXEC spMatriCurso 'Inglês ', 'Ana'
	SELECT * FROM tbMatricula
	
