CREATE DATABASE bdLivrariaBrasileira

USE bdLivrariaBrasileira

CREATE TABLE tbAutor(
   codAutor INT PRIMARY KEY IDENTITY (1,1)
   ,nomeAutor VARCHAR (90) NOT NULL
)

CREATE TABLE tbEditora(
   codEditora INT PRIMARY KEY IDENTITY (1,1)
   ,nomeEditora VARCHAR (90) NOT NULL
)

CREATE TABLE tbGenero(
   codGenero INT PRIMARY KEY IDENTITY (1,1)
   ,nomeGenero VARCHAR (90) NOT NULL
)

CREATE TABLE tbLivro(
   codLivro INT PRIMARY KEY IDENTITY (1,1)
   ,nomeLivro VARCHAR (90) NOT NULL
   ,numPagLivro INT NOT NULL
   ,codGenero INT FOREIGN KEY REFERENCES tbGenero(codGenero)
   ,codAutor INT FOREIGN KEY REFERENCES tbAutor(codAutor)
   ,codEditora INT FOREIGN KEY REFERENCES tbEditora(codEditora)
)