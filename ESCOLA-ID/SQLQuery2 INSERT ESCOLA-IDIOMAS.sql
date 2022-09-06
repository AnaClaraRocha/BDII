--INSERTS

USE bdEscolaIdiomas

INSERT tbAluno (nomeAluno, dataNascimentoAluno,rgAluno,naturaAluno)
VALUES ('Paulo Santos','10/03/2000','82282122-0','SP')
		,('Maria da Gloria','03/10/1999','45233123-0','SP')
		,('Pedro Nogueira da Silva','04/04/1998','23533211-9','SP')
		,('Gilson Barros Silva','09/09/1995','34221111-X','PE')
		,('Mariana Barbosa Santos','10/10/2001','54222122-9','RJ' )
		,('Alessandro Pereira','11/10/2003','24402454-9','ES')
		,('Aline Melo','08/10/2001','88365012-3','RJ')

SELECT * FROM tbAluno

INSERT tbCurso (nomeCurso,cargaHoraCurso,valorCurso)
VALUES   ('Inglês',2000,356.00)
		,('Alemão',3000,478.00)
		,('Espanhol',4000,500.00)

SELECT * FROM tbCurso

INSERT tbTurma (nomeTurma,codCurso,horaTurma)
VALUES   ('1|A',1,'12:00:00')
		,('1|C',3,'18:00:00')
		,('1|B',1,'18:00:00')
		,('1AA',2,'19:00:00')

SELECT * FROM  tbTurma 

INSERT tbMatricula (dataMatricula,codAluno,codTurma)
VALUES   ('03/10/2015',1,1)
		,('04/05/2014',2,1)
		,('04/05/2014',2,4)
		,('03/05/2012',3,2)
		,('03/03/2016',1,3)
		,('07/05/2015',4,2)
		,('05/07/2015',4,3)

SELECT * FROM tbMatricula