USE bdLivrariaBrasileira
 

INSERT tbAutor (nomeAutor)
VALUES ('Chico Buarque ')
       ,('Jorge Amado')
	   ,('J.K	Rowling')
	   ,('Wiliam Shakespeare')
	   ,('Monteiro Lobato')
	   ,('Cora Coralina')
	   ,('Clarice Lispector')

SELECT * FROM tbAutor

------------------

INSERT tbEditora(nomeEditora)
VALUES ('Melhoramentos')
      ,('Globo')
	  ,('Ática')
	  ,('Companhia das Letras')
	  ,('Abril')

SELECT * FROM tbEditora

----------

INSERT tbGenero(nomeGenero)
VALUES  ('Ficção')
        ,('Romance')
		,('Tragédia')

SELECT * FROM tbGenero

-----------------

INSERT tbLivro(nomeLivro,numPagLivro,codGenero,codEditora,codAutor)
VALUES  ('Budapeste', 176, 2, 4, 1 )
        ,('O bicho-da-seda',454, 2, 5, 3)
		,('Gabriela, Cravo e Canela',214,1 , 2, 2)

		,('Reinações de Narizinho',143, 2, 2, 5)
		,('Romeu e Julieta',421, 1, 3, 4)
		,('O irmão Alemão',478,1,4,1)

		,('Terras do Sem-fim',125, 1, 3, 2)
		,('Animas Fantasticos e onde habitam', 267, 2, 4, 3)
		
SELECT * FROM tbLivro