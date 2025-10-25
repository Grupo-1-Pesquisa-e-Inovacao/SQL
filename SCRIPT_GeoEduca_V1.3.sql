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
  idUsuario INT NOT NULL,
  idSecretaria INT NOT NULL,
  idEstado INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  cargo VARCHAR(50) NOT NULL,
  email VARCHAR(150) NOT NULL,
  senha VARCHAR(25) NOT NULL,
  data_cadastro DATETIME NOT NULL,
  PRIMARY KEY (idUsuario, idSecretaria),
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