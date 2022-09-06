USE bdLivrariaBrasileira

-- A) O total de livros que come�am com a letra P

SELECT nomeLivro AS 'Nome Livros'  FROM tblivro
WHERE nomeLivro LIKE 'P%'

-- B) O maior n�mero de p�ginas entre todos os livrosSELECT MAX (numPagLivro) AS 'Numero de Paginas' FROM tbLivro-- c)  O menor n�mero de p�ginas entre todos os livrosSELECT MIN (numPagLivro) AS 'Numero de Paginas' FROM tbLivro-- D) A m�dia de p�ginas entre todos os livros
SELECT AVG (numPagLivro) AS 'M�dia de Paginas' FROM tbLivro

-- E) A soma do n�mero de p�ginas dos livros de editora c�digo 01 rever

SELECT SUM (numPagLivro) AS 'Soma Livro edi 01' FROM tbLivro
WHERE codEditora = 1

-- F) A soma dos n�meros de p�ginas dos livros que come�am com a letra A

SELECT SUM (numPagLivro) AS 'Soma Livro edi 01' FROM tbLivro
WHERE nomeLivro LIKE 'A%'

-- G) A m�dia dos n�meros de p�ginas dos livros que sejam do autor c�digo 03

SELECT AVG (numPagLivro) AS 'Media n�meros de p�ginas autor 03' FROM tbLivro
WHERE codAutor = 3

-- H) A quantidade de livros da editora de c�digo 04

SELECT nomeLivro AS 'Quantidade de livros'  FROM tblivro
WHERE codEditora = 4

-- I) A m�dia do n�mero de p�ginas dos livros que tenham a palavra �estrela� em seu nome

SELECT AVG (numPagLivro) AS 'Media Nome Livros'  FROM tblivro
WHERE nomeLivro LIKE '%estrela%'

-- J) A quantidade de livros que tenham a palavra �poema� em seu nome

SELECT nomeLivro AS 'Nome Livros'  FROM tblivro
WHERE nomeLivro LIKE '%poema%'

-- K) A quantidade de livros agrupado pelo nome do g�nero REVER

SELECT nomeGenero AS 'Nome do Gennero', tbLivro FROM tbGenero
INNER JOIN tbLivro ON tbGenero.codLivro = tbLivro.codLivro
GROUP BY nomeGenero 

-- l) A soma das p�ginas agrupada pelo nome do autor 

SELECT SUM(numPagLivro) as 'Soma das P�ginas', nomeAutor FROM tbLivro
INNER JOIN tbAutor on tbAutor.codAutor = tbLivro.codAutor
GROUP BY nomeAutor

-- M) A m�dia de p�ginas agrupada pelo nome do autor em ordem alfab�tica (de A a Z)

SELECT AVG(numPagLivro) AS 'M�dia das P�ginas Ordem Alfab�tica', nomeAutor AS 'Nome Autor' FROM tbLivro
INNER JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
GROUP BY nomeAutor
ORDER BY nomeAutor

-- N) A quantidade de livros agrupada pelo nome da editora em ordem alfab�tica inversa (de Z a A)
SELECT COUNT(numPagLivro) AS 'Quantidade de Livros Ordem Inversa', nomeEditora AS 'Nome Editora' FROM tbLivro
INNER JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora
GROUP BY nomeEditora
ORDER BY nomeEditora DESC

-- O) A soma de p�ginas dos livros agrupados pelo nome do autor que sejam de autores cujo nome comece com a letra �C�
SELECT SUM(numPagLivro) AS 'Soma das P�ginas', nomeAutor AS 'Nome Autor' FROM tbLivro
INNER JOIN tbAutor on tbAutor.codAutor = tbLivro.codAutor
WHERE nomeAutor LIKE 'C%'
GROUP BY nomeAutor

-- P) A quantidade de livros agrupados pelo nome do autor, cujo nome do autor seja �Machado de Assis� ou �Cora Coralina� ou �Graciliano Ramos� ou �Clarice Lispector�
SELECT COUNT(codLivro) AS 'Quantidade de Livros', nomeAutor AS 'Nome Autor' FROM tbLivro
INNER JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
WHERE nomeAutor LIKE 'Machado de Assis' OR  nomeAutor LIKE 'Cora Coralina' OR nomeAutor LIKE 'Graciliano Ramos' OR nomeAutor LIKE 'Clarice Lispector'
GROUP BY nomeAutor

-- Q) A soma das p�ginas dos livros agrupadas pelo nome da editora cujo n�mero de p�ginas esteja entre 200 e 500 (inclusive)SELECT SUM(numPagLivro) AS 'Soma das P�ginas', nomeEditora AS 'Nome Editora' FROM tbLivro
INNER JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora
WHERE numPagLivro BETWEEN '200' AND '500'
GROUP BY nomeEditora-- R) O nome dos livros ao lado do nome das editoras e do nome dos autoresSELECT nomeLivro AS 'Nome Livro' , nomeEditora AS 'Nome Editora' , nomeAutor AS 'Nome Autor' FROM tbLivro
LEFT JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora
LEFT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor-- S) O nome dos livros ao lado do nome do autor somente daqueles cujo nome da editora for �Cia das Letras�SELECT nomeLivro AS 'Nome Livro', nomeAutor AS 'Nome Autor' FROM tbLivroLEFT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutorLEFT JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora
WHERE nomeEditora LIKE 'Cia das Letras'

-- T) O nome dos livros ao lado dos nomes dos autores, somente dos livros que n�o forem do autor ��rico Ver�ssimo�

SELECT nomeLivro AS 'Nome Livro', nomeAutor AS 'Nome Autor' FROM tbLivro
LEFT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
WHERE nomeAutor != '�rico Ver�ssimo'

-- U) Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles que n�o tem livros cadastrados

SELECT nomeAutor AS 'Nome Autor', nomeLivro AS 'Nome Livro' FROM tbLivro
LEFT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor

-- V) Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles que n�o tem autores cadastradosSELECT nomeAutor AS 'Nome Autor' , nomeLivro AS 'Nome Livro'  FROM tbLivro
RIGHT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
-- W) O nome dos autores ao lado dos nomes dos livros, indiferente do autor ter ou n�o livro publicado, e indiferente do livro pertencer a algum autor
 
SELECT nomeAutor AS 'Nome Autor', nomeLivro AS 'Nome Livro'  FROM tbLivro
FULL JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor

-- X) A editora �tica ir� publicar todos os t�tulos dessa livraria. Criar um select que associe os nomes de todos os livros ao lado do nome da editora �tica

SELECT nomeEditora AS 'Nome Editora' , nomeLivro AS 'Nome Livro'  FROM tbEditora
CROSS JOIN tbLivro
WHERE nomeEditora LIKE '�tica'
-- Y) Somente os nomes dos autores que n�o tem livros cadastradosSELECT nomeAutor AS 'Nome Autor'  FROM tbLivro
Full JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
Where nomeLivro IS NULL-- Z) Os nomes dos g�neros que n�o possuem nenhum livro cadastradoSELECT nomeGenero AS 'Nome Genero' FROM tbLivro
Full JOIN tbGenero ON tbGenero.codGenero = tbLivro.codGenero
Where nomeLivro IS NULL




