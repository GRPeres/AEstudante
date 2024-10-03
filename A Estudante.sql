CREATE DATABASE aestudante_db;

USE aestudante_db;

CREATE TABLE tb_usuario(          
	id_usuario INT AUTO_INCREMENT PRIMARY KEY,
	nome_usuario VARCHAR(50) NOT NULL,
	email_usuario VARCHAR(50) NOT NULL,
	senha_usuario VARCHAR(50) NOT NULL,
	endereço_usuario VARCHAR(50),
	cep_usuario INT
	);

CREATE TABLE tb_produtos(          
	id_produtos INT AUTO_INCREMENT PRIMARY KEY,
	nome_produtos VARCHAR(50) NOT NULL,
	preco_produtos DOUBLE NOT NULL,
	descricao_produtos VARCHAR(250) NOT NULL,
	quantidade_produtos INT NOT NULL
);
