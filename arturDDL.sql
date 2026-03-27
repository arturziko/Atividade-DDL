CREATE DATABASE arz;
USE arz;

CREATE TABLE clientes(
   id_clientes INT PRIMARY KEY,
   nome VARCHAR(100),
   cidade VARCHAR(100),
   UF VARCHAR(2),
   data_cadastro DATE
   
   );
   
    CREATE TABLE categoria(
   id_categoria INT PRIMARY KEY,
   nome VARCHAR(100)
   
   );
   
   CREATE TABLE produtos(
   id_produtos INT PRIMARY KEY,
   descrição VARCHAR(100),
   preço_unitário FLOAT,
   estoque INT,
   id_categoria INT,
   FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
   
   );
   
   CREATE TABLE vendas(
   id_vendas INT PRIMARY KEY,
   id_clientes INT,
   FOREIGN KEY (id_clientes) REFERENCES clientes (id_clientes),
   id_produtos INT,
   FOREIGN KEY (id_produtos) REFERENCES produtos (id_produtos),
   quantidade INT,
   data_venda DATE
   
   );
   
   
   
   
INSERT INTO clientes (id_clientes, nome, cidade, UF, data_cadastro)
VALUES
(10, 'Ana Silva', 'Sao Paulo', 'SP', '2023-01-15');
INSERT INTO clientes (id_clientes, nome, cidade, UF, data_cadastro)
VALUES
(11, 'Bruno Souza', 'Curitiba', 'PR', '2023-05-20'),
(12, 'Carla Dias', 'Sao Paulo', 'SP', '2024-02-10'),
(13, 'Diego Lemos', 'Belo Horizonte', 'MG', '2024-03-01');



INSERT INTO categoria (id_categoria, nome)
VALUES
(01, 'Eletronicos'),
(02, 'Moveis'),
(03, 'Informatica');



INSERT INTO produtos (id_produtos, descrição, preço_unitário, estoque, id_categoria)
VALUES 
(101, 'Smartphone X', 2500.00, 50, 1),
(102, 'Cadeira Gamer', 1200.00, 15, 2),
(103, 'Mouse Sem Fio', 150.00, 100, 3),
(104, 'Monitor 4K', 3200.00, 10, 3),
(105, 'Mesa de Escritório', 850.00, 8, 2);


INSERT INTO vendas (id_vendas, id_clientes, id_produtos, quantidade, data_venda)
VALUES
(1001, 10, 101, 1, '2024-03-10'),
(1002, 11, 102, 2, '2024-03-12'),
(1003, 10, 103, 5, '2024-03-15'),
(1004, 12, 101, 1, '2024-03-20'),
(1005, 13, 105, 1, '2024-03-22'),
(1006, 10, 104, 1, '2024-03-25');


-- valor do produto mais caro da categoria 3
SELECT MAX(preço_unitário) FROM produtos WHERE id_categoria = 3;

-- produto com menor valkor da categoria 2
SELECT MIN(preço_unitário) FROM produtos WHERE id_categoria = 2;

-- variação de produtos cadastrados em cada categoria
SELECT COUNT(id_produtos), id_categoria FROM produtos GROUP BY id_categoria;


-- preço da tabela produtos * quantidade da tabela vendas (inner join para união de tabelas) apelidos das tabelas (c,v,p)
SELECT MAX((preço_unitário * quantidade)) AS 'Venda mais cara'
FROM vendas v
INNER JOIN clientes c ON c.id_clientes = v.id_clientes
INNER JOIN produtos p ON p.id_produtos = v.id_produtos
WHERE c.cidade = 'São Paulo';


-- Qual a quantidade total de itens vendidos para o produto 101?
SELECT SUM(quantidade) FROM vendas WHERE id_produtos = 101;

-- Qual o maior valor de produto vendido no período de 15/03/2024 a 25/03/2024?

SELECT MAX(preço_unitário)
FROM vendas v
INNER JOIN produtos p ON p.id_produtos = v.id_produtos
WHERE data_venda BETWEEN '2024-03-15' and '2024-03-25';
