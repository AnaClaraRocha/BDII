USE bdLivrariaBrasileira

-- A) O total de livros que começam com a letra P

SELECT nomeLivro AS 'Nome Livros'  FROM tblivro
WHERE nomeLivro LIKE 'P%'

-- B) O maior número de páginas entre todos os livrosSELECT MAX (numPagLivro) AS 'Numero de Paginas' FROM tbLivro-- c)  O menor número de páginas entre todos os livrosSELECT MIN (numPagLivro) AS 'Numero de Paginas' FROM tbLivro-- D) A média de páginas entre todos os livros
SELECT AVG (numPagLivro) AS 'Média de Paginas' FROM tbLivro

-- E) A soma do número de páginas dos livros de editora código 01 rever

SELECT SUM (numPagLivro) AS 'Soma Livro edi 01' FROM tbLivro
WHERE codEditora = 1

-- F) A soma dos números de páginas dos livros que começam com a letra A

SELECT SUM (numPagLivro) AS 'Soma Livro edi 01' FROM tbLivro
WHERE nomeLivro LIKE 'A%'

-- G) A média dos números de páginas dos livros que sejam do autor código 03

SELECT AVG (numPagLivro) AS 'Media números de páginas autor 03' FROM tbLivro
WHERE codAutor = 3

-- H) A quantidade de livros da editora de código 04

SELECT nomeLivro AS 'Quantidade de livros'  FROM tblivro
WHERE codEditora = 4

-- I) A média do número de páginas dos livros que tenham a palavra “estrela” em seu nome

SELECT AVG (numPagLivro) AS 'Media Nome Livros'  FROM tblivro
WHERE nomeLivro LIKE '%estrela%'

-- J) A quantidade de livros que tenham a palavra “poema” em seu nome

SELECT nomeLivro AS 'Nome Livros'  FROM tblivro
WHERE nomeLivro LIKE '%poema%'

-- K) A quantidade de livros agrupado pelo nome do gênero REVER

SELECT nomeGenero AS 'Nome do Gennero', tbLivro FROM tbGenero
INNER JOIN tbLivro ON tbGenero.codLivro = tbLivro.codLivro
GROUP BY nomeGenero 

-- l) A soma das páginas agrupada pelo nome do autor 

SELECT SUM(numPagLivro) as 'Soma das Páginas', nomeAutor FROM tbLivro
INNER JOIN tbAutor on tbAutor.codAutor = tbLivro.codAutor
GROUP BY nomeAutor

-- M) A média de páginas agrupada pelo nome do autor em ordem alfabética (de A a Z)

SELECT AVG(numPagLivro) AS 'Média das Páginas Ordem Alfabética', nomeAutor AS 'Nome Autor' FROM tbLivro
INNER JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
GROUP BY nomeAutor
ORDER BY nomeAutor

-- N) A quantidade de livros agrupada pelo nome da editora em ordem alfabética inversa (de Z a A)
SELECT COUNT(numPagLivro) AS 'Quantidade de Livros Ordem Inversa', nomeEditora AS 'Nome Editora' FROM tbLivro
INNER JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora
GROUP BY nomeEditora
ORDER BY nomeEditora DESC

-- O) A soma de páginas dos livros agrupados pelo nome do autor que sejam de autores cujo nome comece com a letra “C”
SELECT SUM(numPagLivro) AS 'Soma das Páginas', nomeAutor AS 'Nome Autor' FROM tbLivro
INNER JOIN tbAutor on tbAutor.codAutor = tbLivro.codAutor
WHERE nomeAutor LIKE 'C%'
GROUP BY nomeAutor

-- P) A quantidade de livros agrupados pelo nome do autor, cujo nome do autor seja “Machado de Assis” ou “Cora Coralina” ou “Graciliano Ramos” ou “Clarice Lispector”
SELECT COUNT(codLivro) AS 'Quantidade de Livros', nomeAutor AS 'Nome Autor' FROM tbLivro
INNER JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
WHERE nomeAutor LIKE 'Machado de Assis' OR  nomeAutor LIKE 'Cora Coralina' OR nomeAutor LIKE 'Graciliano Ramos' OR nomeAutor LIKE 'Clarice Lispector'
GROUP BY nomeAutor

-- Q) A soma das páginas dos livros agrupadas pelo nome da editora cujo número de páginas esteja entre 200 e 500 (inclusive)SELECT SUM(numPagLivro) AS 'Soma das Páginas', nomeEditora AS 'Nome Editora' FROM tbLivro
INNER JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora
WHERE numPagLivro BETWEEN '200' AND '500'
GROUP BY nomeEditora-- R) O nome dos livros ao lado do nome das editoras e do nome dos autoresSELECT nomeLivro AS 'Nome Livro' , nomeEditora AS 'Nome Editora' , nomeAutor AS 'Nome Autor' FROM tbLivro
LEFT JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora
LEFT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor-- S) O nome dos livros ao lado do nome do autor somente daqueles cujo nome da editora for “Cia das Letras”SELECT nomeLivro AS 'Nome Livro', nomeAutor AS 'Nome Autor' FROM tbLivroLEFT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutorLEFT JOIN tbEditora ON tbEditora.codEditora = tbLivro.codEditora
WHERE nomeEditora LIKE 'Cia das Letras'

-- T) O nome dos livros ao lado dos nomes dos autores, somente dos livros que não forem do autor “Érico Veríssimo”

SELECT nomeLivro AS 'Nome Livro', nomeAutor AS 'Nome Autor' FROM tbLivro
LEFT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
WHERE nomeAutor != 'Érico Veríssimo'

-- U) Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles que não tem livros cadastrados

SELECT nomeAutor AS 'Nome Autor', nomeLivro AS 'Nome Livro' FROM tbLivro
LEFT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor

-- V) Os nomes dos autores ao lado dos nomes dos livros, inclusive daqueles que não tem autores cadastradosSELECT nomeAutor AS 'Nome Autor' , nomeLivro AS 'Nome Livro'  FROM tbLivro
RIGHT JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
-- W) O nome dos autores ao lado dos nomes dos livros, indiferente do autor ter ou não livro publicado, e indiferente do livro pertencer a algum autor
 
SELECT nomeAutor AS 'Nome Autor', nomeLivro AS 'Nome Livro'  FROM tbLivro
FULL JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor

-- X) A editora Ática irá publicar todos os títulos dessa livraria. Criar um select que associe os nomes de todos os livros ao lado do nome da editora Ática

SELECT nomeEditora AS 'Nome Editora' , nomeLivro AS 'Nome Livro'  FROM tbEditora
CROSS JOIN tbLivro
WHERE nomeEditora LIKE 'Àtica'
-- Y) Somente os nomes dos autores que não tem livros cadastradosSELECT nomeAutor AS 'Nome Autor'  FROM tbLivro
Full JOIN tbAutor ON tbAutor.codAutor = tbLivro.codAutor
Where nomeLivro IS NULL-- Z) Os nomes dos gêneros que não possuem nenhum livro cadastradoSELECT nomeGenero AS 'Nome Genero' FROM tbLivro
Full JOIN tbGenero ON tbGenero.codGenero = tbLivro.codGenero
Where nomeLivro IS NULL




