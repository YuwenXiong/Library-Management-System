-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: libdata
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Admin` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `real_name` varchar(30) DEFAULT NULL,
  `contact_info` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES (1,'root','-5995064038896156292',NULL,NULL);
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Book`
--

DROP TABLE IF EXISTS `Book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Book` (
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `book_num` varchar(30) NOT NULL,
  `type` varchar(30) DEFAULT NULL,
  `title` varchar(30) NOT NULL,
  `press` varchar(30) DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `author` varchar(30) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  PRIMARY KEY (`bid`),
  UNIQUE KEY `book_num` (`book_num`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Book`
--

LOCK TABLES `Book` WRITE;
/*!40000 ALTER TABLE `Book` DISABLE KEYS */;
INSERT INTO `Book` VALUES (1,'bno7','TAOCP','CS','GG',1999,'Knuth',10000.00,1,1),(3,'bno6','TAOCP','CS','GG',1999,'Knuth',10000.00,1,1),(4,'bno10','SQL Server 2008','计算机','清华出版社',2001,'郭郑州',79.80,5,3),(13,'bno1','计算机','SQL Server 2008完全学习手册','清华出版社',2001,'郭郑州',79.80,6,3),(14,'bno2','计算机','程序员的自我修养','电子工业出版社',2013,'俞甲子',65.00,5,3),(15,'bno3','教育','做新教育的行者','福建教育出版社',2002,'高云鹏',25.00,3,3),(16,'bno4','教育','做孩子眼中有本领的父母','电子工业出版社',2013,'高云鹏',23.00,5,4),(17,'bno5','英语','实用英文写作','高等教育出版社',2008,'庞继贤',33.00,3,2),(21,'bno111','CS','CSAPP','MIT',2015,'CMU',100.00,15,15);
/*!40000 ALTER TABLE `Book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Card`
--

DROP TABLE IF EXISTS `Card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Card` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `card_num` varchar(30) NOT NULL,
  `card_name` varchar(30) NOT NULL,
  `unit` varchar(30) DEFAULT NULL,
  `TYPE` char(1) NOT NULL,
  PRIMARY KEY (`cid`),
  UNIQUE KEY `card_num` (`card_num`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Card`
--

LOCK TABLES `Card` WRITE;
/*!40000 ALTER TABLE `Card` DISABLE KEYS */;
INSERT INTO `Card` VALUES (3,'123','sss','CS','S');
/*!40000 ALTER TABLE `Card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Record`
--

DROP TABLE IF EXISTS `Record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Record` (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `bid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `borrow_date` datetime NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`rid`),
  KEY `bid` (`bid`),
  KEY `cid` (`cid`),
  KEY `uid` (`uid`),
  CONSTRAINT `Record_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `Book` (`bid`),
  CONSTRAINT `Record_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `Card` (`cid`),
  CONSTRAINT `Record_ibfk_3` FOREIGN KEY (`uid`) REFERENCES `Admin` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Record`
--

LOCK TABLES `Record` WRITE;
/*!40000 ALTER TABLE `Record` DISABLE KEYS */;
INSERT INTO `Record` VALUES (1,13,3,'2015-04-06 00:00:00','2015-04-06 21:19:28',1),(2,14,3,'2015-04-06 20:46:31','2015-04-07 22:03:21',1),(3,13,3,'2015-04-06 21:10:42','2015-04-06 21:19:34',1),(4,13,3,'2015-04-07 20:34:16','2015-04-07 22:49:29',1),(5,13,3,'2015-04-07 21:08:26','2015-04-07 23:00:37',1),(6,13,3,'2015-04-07 22:01:31','2015-04-07 23:06:34',1),(7,13,3,'2015-04-07 22:49:59','2015-04-08 14:52:52',1),(8,14,3,'2015-04-07 22:55:00','2015-04-07 22:55:42',1),(9,15,3,'2015-04-07 22:56:03','2015-04-07 23:03:42',1),(10,14,3,'2015-04-07 23:07:14',NULL,1),(11,15,3,'2015-04-07 23:08:36','2015-04-08 14:53:13',1),(12,16,3,'2015-04-07 23:08:57',NULL,1),(13,17,3,'2015-04-07 23:09:02',NULL,1),(14,3,3,'2015-04-07 23:09:08','2015-04-08 14:53:05',1),(16,13,3,'2015-04-08 14:50:50',NULL,1);
/*!40000 ALTER TABLE `Record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `session_id` char(128) NOT NULL,
  `atime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data` text,
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('55758ca039dcb2dbc48e751bca65d3c30a11039b','2015-04-08 10:02:12','KGRwMQpTJ2lwJwpwMgpWMTgzLjE1Ny4xNjAuNTcKcDMKc1MnbG9naW4nCnA0CkkxCnNTJ3VpZCcK\ncDUKTDFMCnNTJ3Nlc3Npb25faWQnCnA2ClMnNTU3NThjYTAzOWRjYjJkYmM0OGU3NTFiY2E2NWQz\nYzMwYTExMDM5YicKcDcKc1MnY2lkJwpwOApJLTEKcy4=\n'),('588a222f13817e5f412d7fa134a6ddc83a23d0d8','2015-04-07 13:42:19','KGRwMQpTJ2lwJwpwMgpWMTI3LjAuMC4xCnAzCnNTJ2xvZ2luJwpwNApJMQpzUyd1aWQnCnA1Ckwx\nTApzUydzZXNzaW9uX2lkJwpwNgpTJzU4OGEyMjJmMTM4MTdlNWY0MTJkN2ZhMTM0YTZkZGM4M2Ey\nM2QwZDgnCnA3CnNTJ2NpZCcKcDgKTDNMCnMu\n'),('5effc3ff551efdb2d6f42c6f7c0bc846d72b0bdf','2015-04-07 13:32:26','KGRwMQpTJ2lwJwpwMgpWMTI3LjAuMC4xCnAzCnNTJ2xvZ2luJwpwNApJMQpzUyd1aWQnCnA1Ckwx\nTApzUydzZXNzaW9uX2lkJwpwNgpTJzVlZmZjM2ZmNTUxZWZkYjJkNmY0MmM2ZjdjMGJjODQ2ZDcy\nYjBiZGYnCnA3CnNTJ2NpZCcKcDgKTDNMCnMu\n'),('813e4be46963439ee48c53e068d4a33e5d4b1891','2015-04-08 09:50:51','KGRwMQpTJ2lwJwpwMgpWMTI3LjAuMC4xCnAzCnNTJ2xvZ2luJwpwNApJMQpzUyd1aWQnCnA1Ckwx\nTApzUydzZXNzaW9uX2lkJwpwNgpTJzgxM2U0YmU0Njk2MzQzOWVlNDhjNTNlMDY4ZDRhMzNlNWQ0\nYjE4OTEnCnA3CnNTJ2NpZCcKcDgKTDIyTApzLg==\n'),('d398780a278ddba295e251d097e82c8ea69ec18a','2015-04-07 13:24:16','KGRwMQpTJ2lwJwpwMgpWMTI3LjAuMC4xCnAzCnNTJ2xvZ2luJwpwNApJMQpzUyd1aWQnCnA1Ckwx\nTApzUydzZXNzaW9uX2lkJwpwNgpTJ2QzOTg3ODBhMjc4ZGRiYTI5NWUyNTFkMDk3ZTgyYzhlYTY5\nZWMxOGEnCnA3CnNTJ2NpZCcKcDgKTDNMCnMu\n'),('d75c2007006d362eb6e3b4e07002b76ea3f913d3','2015-04-07 13:35:32','KGRwMQpTJ2lwJwpwMgpWMTI3LjAuMC4xCnAzCnNTJ2xvZ2luJwpwNApJMQpzUyd1aWQnCnA1Ckwx\nTApzUydzZXNzaW9uX2lkJwpwNgpTJ2Q3NWMyMDA3MDA2ZDM2MmViNmUzYjRlMDcwMDJiNzZlYTNm\nOTEzZDMnCnA3CnNTJ2NpZCcKcDgKTDNMCnMu\n'),('fa1da99382b1f701fc18524380a9550d3f00bb71','2015-04-07 13:42:02','KGRwMQpTJ2lwJwpwMgpWMTI3LjAuMC4xCnAzCnNTJ2xvZ2luJwpwNApJMApzUyd1aWQnCnA1Ckkt\nMQpzUydzZXNzaW9uX2lkJwpwNgpTJ2ZhMWRhOTkzODJiMWY3MDFmYzE4NTI0MzgwYTk1NTBkM2Yw\nMGJiNzEnCnA3CnNTJ2NpZCcKcDgKSS0xCnMu\n'),('fc7edde69acc025eb45a6480fc333fce2d3c5c6d','2015-04-07 13:31:20','KGRwMQpTJ2lwJwpwMgpWMTI3LjAuMC4xCnAzCnNTJ2xvZ2luJwpwNApJMQpzUyd1aWQnCnA1Ckwx\nTApzUydzZXNzaW9uX2lkJwpwNgpTJ2ZjN2VkZGU2OWFjYzAyNWViNDVhNjQ4MGZjMzMzZmNlMmQz\nYzVjNmQnCnA3CnNTJ2NpZCcKcDgKTDNMCnMu\n');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-08  6:04:59
