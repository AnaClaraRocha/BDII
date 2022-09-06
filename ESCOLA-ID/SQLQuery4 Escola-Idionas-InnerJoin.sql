--INNER JOIN

USE bdEscolaIdiomas

--1) Apresentar os nomes dos alunos ao lado do nome curso 

SELECT nomeAluno AS 'Nome Aluno' , nomeCurso 'Nome Curso' FROM tbMatricula
	INNER JOIN tbAluno ON tbMatricula.codAluno = tbAluno.codAluno
	INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
	INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso

--2) Apresentar a quantidade de alunos matriculados por nome do curso

SELECT COUNT (nomeAluno) AS 'Quantidade de Alunos', nomeCurso AS 'Nome Curso' From TbMatricula
    INNER JOIN  tbAluno ON tbMatricula.codAluno = tbAluno.codAluno
    INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
    INNER JOIN tbCurso ON tbTurma.codCurso =tbCurso.codCurso
    GROUP BY nomeCurso

--3 Apresentar a quantidade de Alunos matriculados por nome da Turma

SELECT COUNT(codAluno) AS 'Quantidade de Alunos', nomeTurma AS 'Nome Turma' FROM tbMatricula
	INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
	GROUP BY nomeTurma

--4 Apresentar a quantidade de alunos que fizeram a matricula em  maio de 2016

SELECT COUNT(codAluno) AS 'Quantidade de Alunos' FROM tbMatricula
   WHERE MONTH(dataMatricula) = 5 AND YEAR(dataMatricula) = 2016

--5 Apresentar o nome dos alunos em ordem alfabetica do lado das turmas em que estão matriculados

SELECT nomeAluno, nomeTurma FROM tbMatricula
	INNER JOIN tbAluno ON tbMatricula.codAluno = tbAluno.codAluno
	INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
	ORDER BY nomeAluno

--6) Apresentar o nome dos cursos e os horários em que eles são oferecido

SELECT nomeCurso AS 'Nome Curso',  horaTurma AS 'Horario Turma' FROM tbTurma
    INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso

--7) Apresentar a quantidade de alunos nascidos por estado

SELECT COUNT(codAluno) AS 'Quantidade de Alunos', naturaAluno FROM tbAluno
	GROUP BY naturaAluno

--8) Apresentar o nome dos alunos ao lado da data de matrícula no formato dd/mm/aaaa

SELECT nomeAluno, FORMAT(dataMatricula,'dd/MM/yyyy') AS 'Data de Matrícula' FROM tbMatricula
	INNER JOIN tbAluno ON tbMatricula.codAluno = tbAluno.codAluno

--9) Apresentar os alunos cujo nome comece com A e que estejam matriculados no curso de inglês

SELECT nomeAluno FROM tbMatricula
	INNER JOIN tbAluno ON tbMatricula.codAluno = tbAluno.codAluno
	INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
	WHERE nomeAluno LIKE 'A%' AND codCurso = 1

--10) Apresentar a quantidade de matriculas feitas no ano de 2016

SELECT COUNT(codMatricula) AS 'Quantidade de matrículas' FROM tbMatricula
  WHERE YEAR(dataMatricula) = 2016
