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
-- Table structure for table `tb_produtos`
--

DROP TABLE IF EXISTS `tb_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_produtos` (
  `id_produtos` int NOT NULL AUTO_INCREMENT,
  `nome_produtos` varchar(50) NOT NULL,
  `preco_produtos` double NOT NULL,
  `descricao_produtos` varchar(250) NOT NULL,
  `categoria_produtos` varchar(50) NOT NULL,
  `quantidade_produtos` int NOT NULL,
  `imagem_produtos` varchar(250) NOT NULL,
  PRIMARY KEY (`id_produtos`),
  UNIQUE KEY `nome_produtos_UNIQUE` (`nome_produtos`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produtos`
--

LOCK TABLES `tb_produtos` WRITE;
/*!40000 ALTER TABLE `tb_produtos` DISABLE KEYS */;
INSERT INTO `tb_produtos` VALUES (1,'Lápis Leo&Leo',1,'Lápis grefite para escrever e desenhar, cor preto','Lápis',4,'https://i.imgur.com/munPRga.jpeg'),(2,'Lápis Faber-Castell',1.5,'Lápis grafite para escrever, cor azul','Lápis',4,'https://i.imgur.com/KUpujCV.jpeg'),(3,'Supercola TekBond',10.9,'Super cola','Cola',4,'https://i.imgur.com/uWqyPYq.jpeg'),(4,'Caneta CiS',4.9,'Caneta esferográfica, nas cores azul e vermelho','Caneta',4,'https://i.imgur.com/DhX3THz.jpeg'),(5,'Caneta Pink Vibes',19.9,'Caneta rosa com pompom, cor azul','Caneta',4,'https://i.imgur.com/m4ukjOL.jpeg'),(6,'Caneta BIC',1,'Caneta esferográfica, nas cores preto e vermelho','Caneta',4,'https://i.imgur.com/jXQqSL9.jpeg'),(7,'Lapiseira CiS Joy 2,0',5.5,'Lapiseira de grafite 2,0, nas cores azul, rosa e amarelo','Lapiseira',4,'https://i.imgur.com/uzeY7Pd.jpeg'),(8,'Caneta Compactor',1,'Caneta esferográfica, nas cores preto e vermelho','Caneta',4,'https://i.imgur.com/jXQqSL9.jpeg'),(9,'Caneta 4 cores Faber-Castell',9.9,'Caneta retrátil de 4 cores, sendo elas azul, vermelho, preto e verde','Caneta',4,'https://i.imgur.com/Q90hPf8.jpeg'),(10,'Marca texto Faber-Castell Amarelo',3.9,'Marca texto, nas cores amarelo, verde e rosa','Marca Texto',4,'https://i.imgur.com/jXQqSL9.jpeg'),(11,'Fita dupla face grossa',10.9,'desc','Fita Adesiva',4,'https://i.imgur.com/jXQqSL9.jpeg'),(12,'Fita dupla face fina',10.9,'desc','Fita Adesiva',4,'https://i.imgur.com/jXQqSL9.jpeg'),(13,'Durex colorido',10.9,'Fita adesiva, cores disponíveis: azul, vermelho, verde, amarelo','Fita Adesiva',4,'https://i.imgur.com/jXQqSL9.jpeg'),(14,'Durex largo',10.9,'Fita adesiva transparente','Fita Adesiva',4,'https://i.imgur.com/jXQqSL9.jpeg'),(15,'Lâminas para plastificar',10.9,'Plástico para plastificação de papais e afins','Fita Adesiva',4,'https://i.imgur.com/jXQqSL9.jpeg'),(16,'Cola bastão',10.9,'desc','Cola',4,'https://i.imgur.com/jXQqSL9.jpeg'),(17,'Tubo de cola quente grossa',10.9,'Bastões de cola quente de grossura 10mm','Cola',4,'https://i.imgur.com/PmoXyoa.jpeg'),(18,'Pistola de cola quente fina',10.9,'Pistola para usar bastões de cola quente de grossura 5mm','Cola',4,'https://i.imgur.com/jXQqSL9.jpeg'),(19,'Pasta L',10.9,'Pasta de plástico com abertura em L para papéis e afins','Pasta',4,'https://i.imgur.com/jXQqSL9.jpeg'),(20,'Envelope A4 pardo',10.9,'Envelope de tamanho A4 para papéis e afins','Envelope',4,'https://i.imgur.com/jXQqSL9.jpeg'),(21,'Plástico para arquivo com furo',10.9,'Caixa plástica para arquivo','Caixa',4,'https://i.imgur.com/jXQqSL9.jpeg'),(22,'Papel cartão',10.9,'Papel cartão nas cores: amarelo, azul escuro, vermelho, marrom, preto, laranja','Papel',4,'https://i.imgur.com/jXQqSL9.jpeg'),(23,'Papel dupla face',10.9,'Papel dupla face nas cores: branco, preto, azul, amarelo','Papel',4,'https://i.imgur.com/jXQqSL9.jpeg'),(24,'Clips médios',10.9,'Clips de tamanho médio para papéis e afins','Clips',4,'https://i.imgur.com/jXQqSL9.jpeg'),(25,'Pincel para quadro branco',10.9,'Caneta para escrever em quadro branco nas cores: azul, preto, vermelho','Caneta',4,'https://i.imgur.com/jXQqSL9.jpeg'),(26,'Papel crepom',10.9,'Papel crepom nas cores: branco, preto, marrom, amarelo, rosa, verde (escuro/claro), azul(escuro/claro), roxo','Papel',4,'https://i.imgur.com/jXQqSL9.jpeg'),(27,'Borracha Mercur',10.9,'desc','Borracha',4,'https://i.imgur.com/kbN3W79.jpeg'),(28,'Apontador com repositório Faber-Castell',10.9,'desc','Apontador',4,'https://i.imgur.com/M4Q0f1R.jpeg'),(29,'Caneca',10.9,'desc','Copo/Garrafa',4,'https://i.imgur.com/lv91yut.jpeg'),(30,'Garrafa',10.9,'desc','Copo/Garrafa',4,'https://i.imgur.com/5hOun51.jpeg'),(31,'Garrafa Stanley',10.9,'desc','Copo/Garrafa',4,'https://i.imgur.com/7Ver0Yr.jpeg'),(32,'Como Stanley',10.9,'desc','Copo/Garrafa',4,'https://i.imgur.com/7DO0tla.jpeg'),(33,'Garrafa Térmica',10.9,'desc','Copo/Garrafa',4,'https://i.imgur.com/R58Zdzn.jpeg'),(34,'Headphone sem fio X-Cell',10.9,'desc','Eletrônico',4,'https://i.imgur.com/nFb4VLL.jpeg!'),(35,'Headphone sem fio Inova',10.9,'desc','Eletrônico',4,'https://i.imgur.com/MxZblPV.jpeg'),(36,'Mochila Tegaote',10.9,'Mochila de costas nas cores azul claro, azul, rosa, preto','Mochila',4,'https://i.imgur.com/llv4HI7.jpeg'),(37,'Kit Mochila UP4YOU',10.9,'Kit com mochila de costas, estojo e merendeira','Mochila',4,'https://i.imgur.com/tMiS8Jo.jpeg'),(38,'Máquina de cortar cabelo',10.9,'desc','Eletrônico',4,'https://i.imgur.com/CVFBNdf.jpeg'),(39,'Mochila Julie Henri',10.9,'Mochila de carrinho nas cores','Mochila',4,'https://i.imgur.com/ohXOldU.jpeg'),(40,'Nome',4.44,'Descrição','Categoria',4,'URL');
/*!40000 ALTER TABLE `tb_produtos` ENABLE KEYS */;
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
