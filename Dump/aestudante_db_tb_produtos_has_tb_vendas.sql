CREATE DATABASE  IF NOT EXISTS `aestudante_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aestudante_db`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: aestudante_db
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_produtos_has_tb_vendas`
--

DROP TABLE IF EXISTS `tb_produtos_has_tb_vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_produtos_has_tb_vendas` (
  `tb_produtos_id_produtos` int NOT NULL,
  `tb_vendas_id_vendas` int NOT NULL,
  `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos` int NOT NULL,
  `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos1` int NOT NULL,
  PRIMARY KEY (`tb_produtos_id_produtos`,`tb_vendas_id_vendas`,`tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos`,`tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos1`),
  KEY `fk_tb_produtos_has_tb_vendas_tb_vendas1_idx` (`tb_vendas_id_vendas`,`tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos`,`tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos1`),
  KEY `fk_tb_produtos_has_tb_vendas_tb_produtos_idx` (`tb_produtos_id_produtos`),
  CONSTRAINT `fk_tb_produtos_has_tb_vendas_tb_produtos` FOREIGN KEY (`tb_produtos_id_produtos`) REFERENCES `tb_produtos` (`id_produtos`),
  CONSTRAINT `fk_tb_produtos_has_tb_vendas_tb_vendas1` FOREIGN KEY (`tb_vendas_id_vendas`, `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos`, `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos1`) REFERENCES `tb_vendas` (`id_vendas`, `tb_produtos_has_tb_produtos_tb_produtos_id_produtos`, `tb_produtos_has_tb_produtos_tb_produtos_id_produtos1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produtos_has_tb_vendas`
--

LOCK TABLES `tb_produtos_has_tb_vendas` WRITE;
/*!40000 ALTER TABLE `tb_produtos_has_tb_vendas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_produtos_has_tb_vendas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-04 11:05:50
