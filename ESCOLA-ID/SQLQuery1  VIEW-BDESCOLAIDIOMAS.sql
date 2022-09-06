-- VIEW

USE bdEscolaIdiomas

-- 1) Crie uma visão “Preço_Baixo” que exiba o código, nome do curso, carga horária e 
-- o valor do curso de todos os cursos que tenha preço inferior a R$300,00

CREATE VIEW vwPreço_Baixo AS
SELECT codCurso, nomeCurso, cargaHoraCurso, valorCurso
FROM tbCurso
WHERE valorCurso < 300

SELECT * FROM vwPreço_Baixo

-- drop View vwPreço_Baixo

-- 2) Usando a visão “Preço_Baixo”, mostre todos os cursos ordenados por carga horária.

SELECT * FROM vwPreço_Baixo
SELECT COUNT (codCurso) AS 'Nome Curso', cargaHoraCurso FROM tbCurso
GROUP BY cargaHoraCurso

-- 3) Crie uma visão “Qtde_Aluno_Curso” que exiba o curso e a quantidade de alunos por turma.

CREATE VIEW VwQtde_Aluno_Curso AS
SELECT COUNT (codAluno) AS 'Quantidade de Alunos por Turmas', nomeTurma, nomeCurso FROM tbMatricula
INNER JOIN tbTurma ON tbMatricula.codTurma = tbTurma.codTurma
INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
GROUP BY nomeTurma, nomeCurso

SELECT * FROM VwQtde_Aluno_Curso

-- 4) Usando a visão “Qtde_Aluno_Curso” exiba a turma com maior número de alunos.

SELECT MAX(nomeTurma) Turma, MAX([Quantidade de Alunos por Turmas]) AS 'Maior Número de Alunos' FROM VwQtde_Aluno_Curso


-- 5) Crie uma visão “Curso_Qtde_Turmas” que exiba o curso e a quantidade de turmas.

CREATE VIEW VwCurso_Qtde_Turmas AS
SELECT COUNT (codTurma) AS 'Quantidade de Turmas', nomeCurso FROM tbTurma
INNER JOIN tbCurso ON tbTurma.codCurso = tbCurso.codCurso
GROUP BY nomeCurso

SELECT * FROM VwCurso_Qtde_Turmas

-- 6) Usando a visão “Curso_Qtde_Turmas” exiba o curso com menor número de turmas.

SELECT MIN(nomeCurso) Curso, MIN([Quantidade de turmas]) AS 'Menor Número de Turmas' FROM VwCurso_Qtde_Turmas

-- drop View vwCurso_Qtde_Turmas

