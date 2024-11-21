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
  PRIMARY KEY (`id_produtos`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produtos`
--

LOCK TABLES `tb_produtos` WRITE;
/*!40000 ALTER TABLE `tb_produtos` DISABLE KEYS */;
INSERT INTO `tb_produtos` VALUES (1,'Lápis Leo&Leo',1,'Lápis grefite para escrever e desenhar, cor preto','Lápis',4,'insira URL aqui!'),(2,'Lápis Faber-Castell',1.5,'Lápis grafite para escrever, cor azul','Lápis',4,'insira URL aqui!'),(3,'TekBond',10.9,'Super cola','Cola',4,'insira URL aqui!'),(4,'Caneta CiS Azul',4.9,'Caneta esferográfica da cor azul','Caneta',4,'insira URL aqui!'),(5,'Caneta CiS Vermelha',4.9,'Caneta esferográfica da cor vermelha','Caneta',4,'insira URL aqui!'),(6,'Caneta Pink Vibes',19.9,'Caneta rosa com pompom, cor azul','Caneta',4,'insira URL aqui!'),(7,'Caneta BIC Preta',1,'Caneta esferográfica da cor preta','Caneta',4,'insira URL aqui!'),(8,'Caneta BIC Vermelha',1,'Caneta esferográfica da cor vermelha','Caneta',4,'insira URL aqui!'),(9,'Lapiseira CiS Joy 2,0',5.5,'Lapiseira azul de grafite 2,0','Lapiseira',4,'insira URL aqui!'),(10,'Lapiseira CiS Joy 2,0',5.5,'Lapiseira rosa de grafite 2,0','Lapiseira',4,'insira URL aqui!'),(11,'Lapiseira CiS Joy 2,0',5.5,'Lapiseira amarela de grafite 2,0','Lapiseira',4,'insira URL aqui!'),(12,'Caneta Compactor Preta',1,'Caneta esferográfica da cor preta','Caneta',4,'insira URL aqui!'),(13,'Caneta Compactor Vermelha',1,'Caneta esferográfica da cor vermelha','Caneta',4,'insira URL aqui!'),(14,'Caneta 4 cores Faber-Castell',9.9,'Caneta retrátil de 4 cores, sendo elas azul, vermelho, preto e verde','Caneta',4,'insira URL aqui!'),(15,'Marca texto Faber-Castell Amarelo',3.9,'Marca texto da cor amarelo','Marca Texto',4,'insira URL aqui!'),(16,'Marca texto Faber-Castell Verde',3.9,'Marca texto da cor verde','Marca Texto',4,'insira URL aqui!'),(17,'Marca texto Faber-Castell Rosa',3.9,'Marca texto da cor rosa','Marca Texto',4,'insira URL aqui!'),(18,'Fita dupla face grossa',10.9,'desc','Fita Adesiva',4,'insira URL aqui!'),(19,'Fita dupla face fina',10.9,'desc','Fita Adesiva',4,'insira URL aqui!'),(20,'Durex colorido',10.9,'Fita adesiva, cores disponíveis: azul, vermelho, verde, amarelo','Fita Adesiva',4,'insira URL aqui!'),(21,'Durex largo',10.9,'Fita adesiva transparente','Fita Adesiva',4,'insira URL aqui!'),(22,'Lâminas para plastificar',10.9,'Plástico para plastificação de papais e afins','Fita Adesiva',4,'insira URL aqui!'),(23,'Cola bastão',10.9,'desc','Cola',4,'insira URL aqui!'),(24,'Pistola de cola quente grossa',10.9,'Pistola para usar bastões de cola quente de grossura 10mm','Cola',4,'insira URL aqui!'),(25,'Pistola de cola quente fina',10.9,'Pistola para usar bastões de cola quente de grossura 5mm','Cola',4,'insira URL aqui!'),(26,'Pasta L',10.9,'Pasta de plástico com abertura em L para papéis e afins','Pasta',4,'insira URL aqui!'),(27,'Envelope A4 pardo',10.9,'Envelope de tamanho A4 para papéis e afins','Envelope',4,'insira URL aqui!'),(28,'Plástico para arquivo com furo',10.9,'Caixa plástica para arquivo','Caixa',4,'insira URL aqui!'),(29,'Papel cartão',10.9,'Papel cartão nas cores: amarelo, azul escuro, vermelho, marrom, preto, laranja','Papel',4,'insira URL aqui!'),(30,'Papel dupla face',10.9,'Papel dupla face nas cores: branco, preto, azul, amarelo','Papel',4,'insira URL aqui!'),(31,'Clips médios',10.9,'Clips de tamanho médio para papéis e afins','Clips',4,'insira URL aqui!'),(32,'Pincel para quadro branco',10.9,'Caneta para escrever em quadro branco nas cores: azul, preto, vermelho','Caneta',4,'insira URL aqui!'),(33,'Papel crepom',10.9,'Papel crepom nas cores: branco, preto, marrom, amarelo, rosa, verde (escuro/claro), azul(escuro/claro), roxo','Papel',4,'insira URL aqui!'),(34,'Bola de futebol grande',10.9,'desc','Brinquedo',4,'insira URL aqui!'),(35,'Bola de futebol pequena',10.9,'desc','Brinquedo',4,'insira URL aqui!'),(36,'Bola de totó',10.9,'desc','Brinquedo',4,'insira URL aqui!'),(37,'Borracha',10.9,'desc','Borracha',4,'insira URL aqui!'),(38,'Apontador com repositório',10.9,'desc','Apontador',4,'insira URL aqui!');
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

-- Dump completed on 2024-11-14  9:57:39
