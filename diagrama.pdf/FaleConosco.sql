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


-- Copiando estrutura do banco de dados para faleconosco
DROP DATABASE IF EXISTS `faleconosco`;
CREATE DATABASE IF NOT EXISTS `faleconosco` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `faleconosco`;

-- Copiando estrutura para tabela faleconosco.faleconosco
DROP TABLE IF EXISTS `faleconosco`;
CREATE TABLE IF NOT EXISTS `faleconosco` (
  `id_contato` int(11) NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Telefone` varchar(50) DEFAULT NULL,
  `Assunto` varchar(100) NOT NULL,
  `Mensagem` text NOT NULL,
  `Data_envio` datetime NOT NULL,
  `Status` varchar(50) NOT NULL,
  PRIMARY KEY (`id_contato`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Copiando dados para a tabela faleconosco.faleconosco: ~2 rows (aproximadamente)
DELETE FROM `faleconosco`;
INSERT INTO `faleconosco` (`id_contato`, `Nome`, `Email`, `Telefone`, `Assunto`, `Mensagem`, `Data_envio`, `Status`) VALUES
	(1, 'Fernanda', 'fernanda@gmail.com', '(18)99999999', 'DEV de teste', 'teste de mensagem', '2025-11-13 17:02:20', 'Aguardando Leitura'),
	(2, 'Isaac Iuri', 'isaac2000@gmail.com', '(18)990892477', 'Erro no sistema', 'Está dando erro ao entrar no site, depois de varias tentativas deu certo', '2025-11-18 09:54:14', 'Aguardando Leitura');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
