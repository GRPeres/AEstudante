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
  `categoria_produto` varchar(50) NOT NULL,
  `quantidade_produtos` int NOT NULL,
  `imagem_produto` varchar(250) NOT NULL,
  PRIMARY KEY (`id_produtos`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produtos`
--

LOCK TABLES `tb_produtos` WRITE;
/*!40000 ALTER TABLE `tb_produtos` DISABLE KEYS */;
INSERT INTO `tb_produtos` VALUES (1,'Lápis Leo&Leo',1,'Lápis grefite para escrever e desenhar, cor preto','Lápis',4,'insira URL aqui!'),(2,'Lápis Faber-Castell',1.5,'Lápis grafite para escrever, cor azul','Lápis',4,'insira URL aqui!'),(3,'TekBond',10.9,'Super cola','Cola',4,'insira URL aqui!'),(4,'Caneta CiS Azul',4.9,'Caneta esferográfica da cor azul','Caneta',4,'insira URL aqui!'),(5,'Caneta CiS Vermelha',4.9,'Caneta esferográfica da cor vermelha','Caneta',4,'insira URL aqui!'),(6,'Caneta Pink Vibes',19.9,'Caneta rosa com pompom, cor azul','Caneta',4,'insira URL aqui!'),(7,'Caneta BIC Preta',1,'Caneta esferográfica da cor preta','Caneta',4,'insira URL aqui!'),(8,'Caneta BIC Vermelha',1,'Caneta esferográfica da cor vermelha','Caneta',4,'insira URL aqui!'),(9,'Lapiseira CiS Joy 2,0',5.5,'Lapiseira azul de grafite 2,0','Lapiseira',4,'insira URL aqui!'),(10,'Lapiseira CiS Joy 2,0',5.5,'Lapiseira rosa de grafite 2,0','Lapiseira',4,'insira URL aqui!'),(11,'Lapiseira CiS Joy 2,0',5.5,'Lapiseira amarela de grafite 2,0','Lapiseira',4,'insira URL aqui!'),(12,'Caneta Compactor Preta',1,'Caneta esferográfica da cor preta','Caneta',4,'insira URL aqui!'),(13,'Caneta Compactor Vermelha',1,'Caneta esferográfica da cor vermelha','Caneta',4,'insira URL aqui!'),(14,'Caneta 4 cores Faber-Castell',9.9,'Caneta retrátil de 4 cores, sendo elas azul, vermelho, preto e verde','Caneta',4,'insira URL aqui!'),(15,'Marca texto Faber-Castell Amarelo',3.9,'Marca texto da cor amarelo','Marca texto',4,'insira URL aqui!'),(16,'Marca texto Faber-Castell Verde',3.9,'Marca texto da cor verde','Marca texto',4,'insira URL aqui!'),(17,'Marca texto Faber-Castell Rosa',3.9,'Marca texto da cor rosa','Marca texto',4,'insira URL aqui!');
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

-- Dump completed on 2024-10-23 11:32:54
