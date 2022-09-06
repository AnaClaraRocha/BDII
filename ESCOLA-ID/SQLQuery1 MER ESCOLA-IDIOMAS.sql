--MER

CREATE DATABASE bdEscolaIdiomas

USE bdEscolaIdiomas

CREATE TABLE tbAluno(
	codAluno INT PRIMARY KEY IDENTITY(1,1)
	, nomeAluno VARCHAR(60) NOT NULL
	, dataNascimentoAluno DATETIME NOT NULL
	, rgAluno VARCHAR (15) NOT NULL
	, naturaAluno CHAR(2) NOT NULL
)

CREATE TABLE tbCurso(
	codCurso INT PRIMARY KEY IDENTITY(1,1)
	, nomeCurso VARCHAR(10) NOT NULL
	, cargaHoraCurso INT NOT NULL
	, valorCurso MONEY NOT NULL
)

CREATE TABLE tbTurma(
	codTurma INT PRIMARY KEY IDENTITY(1,1)
	, nomeTurma VARCHAR(10) NOT NULL
	, horaTurma TIME NOT NULL
	, codCurso INT FOREIGN KEY REFERENCES tbCurso(codCurso)
)

CREATE TABLE tbMatricula(
	codMatricula INT PRIMARY KEY IDENTITY(1,1)
	, dataMatricula DATETIME NOT NULL
	, codAluno INT FOREIGN KEY REFERENCES tbAluno(codAluno)
	, codTurma INT FOREIGN KEY REFERENCES tbTurma(codTurma)
)