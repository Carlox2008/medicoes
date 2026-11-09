CREATE DATABASE IF NOT EXISTS monitoramento
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE monitoramento;

CREATE TABLE IF NOT EXISTS medicoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(255) NOT NULL,
  tipo VARCHAR(50) NOT NULL,
  valor_original DOUBLE NOT NULL,
  unidade_original VARCHAR(20) NOT NULL,
  valor_convertido DOUBLE NOT NULL,
  unidade_convertida VARCHAR(20) NOT NULL,
  classificacao VARCHAR(50) NOT NULL
);