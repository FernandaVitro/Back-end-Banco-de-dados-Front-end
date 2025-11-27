-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para projeto_healthia
DROP DATABASE IF EXISTS `projeto_healthia`;
CREATE DATABASE IF NOT EXISTS `projeto_healthia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `projeto_healthia`;

-- Copiando estrutura para tabela projeto_healthia.contato
DROP TABLE IF EXISTS `contato`;
CREATE TABLE IF NOT EXISTS `contato` (
  `id_contato` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Telefone` varchar(50) DEFAULT NULL,
  `Assunto` varchar(100) NOT NULL,
  `Mensagem` text NOT NULL,
  `Data_envio` datetime NOT NULL,
  `Status` varchar(50) NOT NULL,
  PRIMARY KEY (`id_contato`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Copiando dados para a tabela projeto_healthia.contato: ~0 rows (aproximadamente)
DELETE FROM `contato`;
INSERT INTO `contato` (`id_contato`, `Nome`, `Email`, `Telefone`, `Assunto`, `Mensagem`, `Data_envio`, `Status`) VALUES
	(1, 'Fernanda', 'fernanda@gmail.com', '(18)990892477', 'Erro no sistema', 'Estou com problema para entrar', '2025-11-18 13:45:45', 'Aguardando Leitura');

-- Copiando estrutura para tabela projeto_healthia.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome_completo_cadastro` varchar(150) NOT NULL,
  `cpf_cadastro` char(11) NOT NULL,
  `senha_cadastro` varchar(255) NOT NULL,
  `email_cadastro` varchar(150) NOT NULL,
  `data_nascimento_cadastro` date NOT NULL,
  `endereco_cadastro` varchar(255) DEFAULT NULL,
  `telefone_cadastro` varchar(20) DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf_cadastro` (`cpf_cadastro`),
  UNIQUE KEY `email_cadastro` (`email_cadastro`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela projeto_healthia.usuarios: ~1 rows (aproximadamente)
DELETE FROM `usuarios`;
INSERT INTO `usuarios` (`id`, `nome_completo_cadastro`, `cpf_cadastro`, `senha_cadastro`, `email_cadastro`, `data_nascimento_cadastro`, `endereco_cadastro`, `telefone_cadastro`, `criado_em`) VALUES
	(1, 'Fernanda Rafaela ', '40040040040', 'onfDuk0516ScxlB+GBjg1uvD2GIczGPa7FmCmmrlKtk=', 'fernandarafaela@gmail.com', '2000-07-09', 'Domingos ', '(18)991900877', '2025-11-18 19:30:46');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
