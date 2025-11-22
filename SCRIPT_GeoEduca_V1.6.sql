
DROP DATABASE GeoEduca;
CREATE DATABASE GeoEduca;
USE GeoEduca;

CREATE TABLE secretaria (
  idSecretaria INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(150) NOT NULL,
  tipo VARCHAR(20) NOT NULL,
  data_criacao DATETIME NOT NULL
);

CREATE TABLE estado (
  idUF INT PRIMARY KEY NOT NULL,
  nomeUf VARCHAR(45) NOT NULL,
  posicaoIDHM INT NOT NULL,
  idhm DECIMAL(4,3) NOT NULL,
  posicaoIDHM_educacao INT NOT NULL,
  idhmEducacao DECIMAL(4,3) NOT NULL
);

CREATE TABLE usuario (
  idUsuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  idSecretaria INT,
  idEstado INT NOT NULL,
  administrador BOOLEAN,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  senha VARCHAR(25) NOT NULL,
  data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_usuario_secretaria
    FOREIGN KEY (idSecretaria) REFERENCES secretaria (idSecretaria),
  CONSTRAINT fk_usuario_estado1
    FOREIGN KEY (idEstado) REFERENCES estado (idUF)
);

CREATE TABLE municipio (
  idMunicipio INT NOT NULL,
  idEstado INT NOT NULL,
  nome_municipio VARCHAR(100) NOT NULL,
  posicaoIDHM INT NOT NULL,
  IDHM DECIMAL(4,3) NOT NULL,
  posicaoIDHM_educacao INT NOT NULL,
  idhmEducacao DECIMAL(4,3) NOT NULL,
  PRIMARY KEY (idMunicipio, idEstado),
  CONSTRAINT fk_municipio_estado1
    FOREIGN KEY (idEstado) REFERENCES estado (idUF)
);

CREATE TABLE media_aluno_enem (
  idMediaAluno INT PRIMARY KEY NOT NULL,
  idEstado INT NOT NULL,
  idMunicipio INT NOT NULL,
  inscricao_enem VARCHAR(100) NOT NULL,
  nota_candidato DECIMAL(6,2) NOT NULL,
  CONSTRAINT fk_media_aluno_enem_estado1
    FOREIGN KEY (idEstado) REFERENCES estado (idUF),
  CONSTRAINT fk_media_aluno_enem_municipio1
    FOREIGN KEY (idMunicipio) REFERENCES municipio (idMunicipio)
);

CREATE TABLE auditoria (
  id INT PRIMARY KEY AUTO_INCREMENT,
  msg_erro VARCHAR(255),
  tipo_acao ENUM('Select', 'Insert', 'Delete', 'Update') NOT NULL,
  data_acao DATETIME NOT NULL,
  status_acao ENUM('Sucesso', 'Erro') NOT NULL,
  classe_acao VARCHAR(100) NOT NULL,
  linha_excel BIGINT NOT NULL
);

CREATE TABLE processamento_planilha (
idProcessamento INT PRIMARY KEY AUTO_INCREMENT,
nome_arquivo VARCHAR(255) NOT NULL,
data_processamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
linhas_processadas BIGINT NOT NULL,
status VARCHAR(20) NOT NULL -- 'SUCESSO', 'ERRO', 'EM_ANDAMENTO'
);

INSERT INTO secretaria (nome, tipo, data_criacao)
VALUES ('Secretaria Estadual de Educação', 'Estadual', NOW());

INSERT INTO estado (idUF, nomeUf, posicaoIDHM, idhm, posicaoIDHM_educacao, idhmEducacao) VALUES
(1, 'Acre', 27, 0.663, 27, 0.580),
(2, 'Alagoas', 26, 0.683, 26, 0.590),
(3, 'Amapá', 14, 0.708, 14, 0.640),
(4, 'Amazonas', 21, 0.674, 21, 0.610),
(5, 'Bahia', 23, 0.685, 23, 0.600),
(6, 'Ceará', 17, 0.700, 17, 0.630),
(7, 'Distrito Federal', 1, 0.824, 1, 0.750),
(8, 'Espírito Santo', 7, 0.740, 7, 0.680),
(9, 'Goiás', 9, 0.735, 9, 0.670),
(10, 'Maranhão', 25, 0.660, 25, 0.580),
(11, 'Mato Grosso', 10, 0.725, 10, 0.660),
(12, 'Mato Grosso do Sul', 8, 0.738, 8, 0.675),
(13, 'Minas Gerais', 6, 0.741, 6, 0.685),
(14, 'Pará', 24, 0.665, 24, 0.590),
(15, 'Paraíba', 20, 0.690, 20, 0.620),
(16, 'Paraná', 4, 0.749, 4, 0.700),
(17, 'Pernambuco', 19, 0.694, 19, 0.625),
(18, 'Piauí', 22, 0.675, 22, 0.610),
(19, 'Rio de Janeiro', 3, 0.755, 3, 0.710),
(20, 'Rio Grande do Norte', 18, 0.698, 18, 0.628),
(21, 'Rio Grande do Sul', 5, 0.747, 5, 0.695),
(22, 'Rondônia', 13, 0.710, 13, 0.645),
(23, 'Roraima', 15, 0.705, 15, 0.638),
(24, 'Santa Catarina', 2, 0.760, 2, 0.720),
(25, 'São Paulo', 11, 0.720, 11, 0.660),
(26, 'Sergipe', 16, 0.702, 16, 0.635),
(27, 'Tocantins', 12, 0.715, 12, 0.650);

INSERT INTO usuario (idSecretaria, idEstado, administrador, nome, email, senha)
VALUES (1, 1, true, 'Admin 01', 'admin@gmail.com', '123');

INSERT INTO usuario (idSecretaria, idEstado, administrador, nome, email, senha)
VALUES (NULL, 2, false, 'Adalberto Freitas', 'adalberto@gmail.com', '123@3434');

SELECT * FROM secretaria;
SELECT * FROM usuario;
SELECT * FROM estado;

SELECT u.idUsuario, u.nome, u.email, u.administrador, e.nomeUf AS estado
    FROM usuario u
    JOIN estado e ON u.idEstado = e.idUF
    WHERE u.email = 'admin@gmail.com' AND u.senha = '123';
 
