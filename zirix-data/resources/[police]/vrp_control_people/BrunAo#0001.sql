-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.11-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para vrp
CREATE DATABASE IF NOT EXISTS `vrp` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `vrp`;

-- Copiando estrutura para tabela vrp.policia
CREATE TABLE IF NOT EXISTS `policia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `police_id` int(11) NOT NULL,
  `dkey` varchar(45) COLLATE utf8_bin NOT NULL,
  `dvalue` text COLLATE utf8_bin DEFAULT NULL,
  `img` varchar(150) COLLATE utf8_bin DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `datahora` datetime DEFAULT NULL,
  `id_pai` int(11) DEFAULT 0,
  PRIMARY KEY (`id`,`dkey`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela vrp.policia: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `policia` DISABLE KEYS */;
INSERT INTO `policia` (`id`, `user_id`, `police_id`, `dkey`, `dvalue`, `img`, `valor`, `datahora`, `id_pai`) VALUES
	(282, 1, 1, 'multa', 'Multa', 'https://i.imgur.com/PTVt1un.png', 5000.00, '2019-10-23 18:59:18', 0),
	(283, 1, 1, 'prisao', 'Teste', NULL, 1.00, '2019-10-23 19:01:37', 0),
	(284, 1, 1, 'multa', 'Teste', NULL, 500.00, '2019-10-23 19:01:38', 0),
	(285, 1, 1, 'prisao', 'teste', NULL, 1.00, '2019-12-14 19:29:00', 0),
	(286, 1, 1, 'multa', 'teste', NULL, 123.00, '2019-12-14 19:29:01', 0);
/*!40000 ALTER TABLE `policia` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
