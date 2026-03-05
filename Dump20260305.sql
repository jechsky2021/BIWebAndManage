-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: beautyindustry
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `questionId` bigint DEFAULT NULL,
  `uId` bigint DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `isAccepted` tinyint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES (1,1,1,'sssss',1,NULL,'2026-03-02 13:10:03'),(2,2,1,'fff',1,NULL,'2026-03-02 13:12:23');
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `introduce` varchar(255) DEFAULT NULL,
  `articleType` bigint DEFAULT NULL,
  `content` text,
  `pageViews` bigint DEFAULT '0',
  `statuss` int DEFAULT NULL,
  `isRecommend` tinyint DEFAULT '0',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (2,'2026年美业最新趋势','匿名','探索2026年美业行业的最新发展趋势和创新方向...',1,'<p>dddddddddddddddddd</p>',4,1,1,'2026-01-23 21:02:43',NULL),(3,'2026年美业最新趋势','专家','实用的美业店铺经营管理策略，提高业绩和客户满意度',1,'<p>实用的美业店铺经营管理策略，提高业绩和客户满意度</p>',1,1,1,'2026-01-24 09:18:29',NULL),(4,'夏季流行发色趋势','专家','夏季流行发色趋势',9,'<p>夏季流行发色趋势夏季流行发色趋势</p>',1,0,1,'2026-01-24 16:32:59',NULL),(5,'测试测试','测试测试','测试测试',9,'<p>测试测试测试测试测试测试测试测试</p>',6,1,1,'2026-01-24 16:35:24',NULL),(6,'单支染膏的正确使用方法','专家','详细介绍单支染膏的正确使用方法和操作步骤',1,'<p>详细介绍单支染膏的正确使用方法和操作步骤</p>',1,1,1,'2026-02-08 16:13:33',NULL),(7,'如何选择适合客户的染膏颜色','专家','根据肤色、发质和需求选择最合适的染膏颜色',1,'<p>根据肤色、发质和需求选择最合适的染膏颜色根据肤色、发质和需求选择最合适的染膏颜色</p>',1,1,1,'2026-02-08 16:19:15',NULL),(8,'单支染膏与双氧奶的最佳搭配比例','专家','不同发质和颜色需求下的最佳调配方案',1,'<p>单支染膏与双氧奶的最佳搭配比例不同发质和颜色需求下的最佳调配方案</p>',3,1,1,'2026-02-08 16:20:25',NULL),(9,'染发后如何正确护理头发','专家','专业洗护产品推荐和日常护理技巧',5,'<p>染发后如何正确护理头发专业洗护产品推荐和日常护理技巧</p>',3,1,1,'2026-02-08 16:21:21',NULL),(10,'修复受损发质的专业方案','专家','针对染发后受损发质的修复流程',5,'<p>修复受损发质的专业方案针对染发后受损发质的修复流程</p>',5,1,1,'2026-02-08 16:22:14',NULL),(11,'夏季头发护理的关键点','专家','高温季节如何保持头发健康和发色持久',5,'<p>夏季头发护理的关键点高温季节如何保持头发健康和发色持久</p>',8,1,1,'2026-02-08 16:23:12',NULL),(12,NULL,NULL,NULL,NULL,NULL,1,NULL,0,'2026-02-09 17:03:19',NULL),(13,'烫发杠具的选择与排列技巧','专家','详解各种烫发杠具的特点及适用场景，以及如何通过不同的排列方式创造多样化的烫发效果。',10,'<p>&nbsp;烫发杠具的选择与排列技巧详解各种烫发杠具的特点及适用场景，以及如何通过不同的排列方式创造多样化的烫发效果。</p>',0,1,1,'2026-02-10 13:48:57',NULL),(14,'烫发前的头发预处理技术','专家','介绍烫发前的深层清洁、去角质和营养护理步骤，为烫发做好充分准备。',10,'<p>烫发前的头发预处理技术<span class=\"ql-font-monospace\" style=\"color: rgb(31, 31, 31);\">介绍烫发前的深层清洁、去角质和营养护理步骤，为烫发做好充分准备。</span></p>',1,1,1,'2026-02-10 13:49:33',NULL),(15,'冷烫与热烫的区别及适用发质','专家','详细解析冷烫与热烫的技术原理、效果差异及适合的发质类型，帮助美发师选择正确的烫发方式。',10,'<p>冷烫与热烫的区别及适用发质<span class=\"ql-font-monospace\" style=\"color: rgb(31, 31, 31);\">详细解析冷烫与热烫的技术原理、效果差异及适合的发质类型，帮助美发师选择正确的烫发方式。</span></p>',0,1,1,'2026-02-10 13:50:14',NULL),(16,'渐变染与创意染发技巧','专家','教授渐变染、挑染、片染等多种创意染发技术的操作方法和效果设计。',11,'<p>渐变染与创意染发技巧<span class=\"ql-font-monospace\" style=\"color: rgb(31, 31, 31);\">教授渐变染、挑染、片染等多种创意染发技术的操作方法和效果设计。</span></p>',0,1,1,'2026-02-10 16:09:14',NULL),(17,'染发前的头发评估方法','专家','详细介绍如何评估客户发质状况，选择最适合的染发方案和安全的产品。',11,'<p>染发前的头发评估方法详细介绍如何评估客户发质状况，选择最适合的染发方案和安全的产品。</p>',0,1,1,'2026-02-10 16:09:47',NULL),(18,'洗发后的正确护理步骤','专家','分享洗发后的护发素使用、毛巾擦干、吹干等关键步骤的正确方法，减少头发损伤。',12,'<p>洗发后的正确护理步骤<span class=\"ql-font-monospace\" style=\"color: rgb(31, 31, 31);\">分享洗发后的护发素使用、毛巾擦干、吹干等关键步骤的正确方法，减少头发损伤。</span></p>',0,1,1,'2026-02-10 16:10:19',NULL),(19,'不同发质的洗发产品选择','专家','详解干性、油性、中性、混合性和受损发质的特点，以及如何选择最适合的洗发水和护发素。',12,'<p><span class=\"ql-font-monospace\" style=\"color: rgb(31, 31, 31);\">详解干性、油性、中性、混合性和受损发质的特点，以及如何选择最适合的洗发水和护发素。</span></p>',0,1,0,'2026-02-10 16:10:53',NULL),(20,'烫发','测试','烫发烫发烫发',10,'<p>烫发烫发烫发</p><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\"><img src=\"https://www.hairpa.com/v1.0/pictureServer/fileManageEndPoint/downLoadFromOSS?fileName=article/1772098780445.jpg\" height=\"892.5925925925926\" width=\"500\"></p><p class=\"ql-align-center\"><br></p><p><span class=\"ql-cursor\">﻿</span><img src=\"https://www.hairpa.com/v1.0/pictureServer/fileManageEndPoint/downLoadFromOSS?fileName=article/1772098413266.jpg\" height=\"620.5426356589147\" width=\"500\"></p><p class=\"ql-align-center\"><img src=\"https://www.hairpa.com/v1.0/pictureServer/fileManageEndPoint/downLoadFromOSS?fileName=article/1772097697418.jpg\"></p>',3,1,1,'2026-02-10 18:16:18',NULL),(21,'烫发000000','测试','烫发烫发烫发0000000',10,'<p class=\"ql-align-center\">烫发烫发烫发</p><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\"><img src=\"https://www.hairpa.com/v1.0/pictureServer/fileManageEndPoint/downLoadFromOSS?fileName=article/1772107061628.jpg\" height=\"1081.640625\" width=\"500\" class=\"\" style=\"width: 30%; height: auto; transition: width 0.2s;\"></p><p><br></p><p class=\"ql-align-center\"><img src=\"https://www.hairpa.com/v1.0/pictureServer/fileManageEndPoint/downLoadFromOSS?fileName=article/1772098780445.jpg\" height=\"892.5925925925926\" width=\"500\" class=\"\" style=\"width: 70%; height: auto; transition: width 0.2s;\"></p><p class=\"ql-align-center\"><br></p><p><img src=\"https://www.hairpa.com/v1.0/pictureServer/fileManageEndPoint/downLoadFromOSS?fileName=article/1772098413266.jpg\" height=\"620.5426356589147\" width=\"500\"></p><p><img src=\"https://www.hairpa.com/v1.0/pictureServer/fileManageEndPoint/downLoadFromOSS?fileName=article/1772097697418.jpg\"></p>',5,1,1,'2026-02-26 17:42:40',NULL),(22,'测试','测试','对对对',1,'<p class=\"ql-align-right\"><strong><u> 滴答滴答滴答滴答滴答滴答</u></strong></p><p><br></p><p><br></p><p class=\"ql-align-center\"><img src=\"https://www.hairpa.com/v1.0/pictureServer/fileManageEndPoint/downLoadFromOSS?fileName=article/1772107115219.jpg\" height=\"892.5925925925926\" width=\"500\"></p>',17,1,0,'2026-02-26 19:58:52',NULL);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article_type`
--

DROP TABLE IF EXISTS `article_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `atName` varchar(100) DEFAULT NULL,
  `atSort` bigint DEFAULT '0',
  `parentId` bigint DEFAULT '0',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_type`
--

LOCK TABLES `article_type` WRITE;
/*!40000 ALTER TABLE `article_type` DISABLE KEYS */;
INSERT INTO `article_type` VALUES (1,'单支染膏1',0,0,'2026-01-20 16:32:46',NULL),(2,'双支染膏',0,0,'2026-01-20 16:33:19',NULL),(3,'黑油精油',0,0,'2026-01-20 16:33:58',NULL),(4,'冷烫热烫',0,0,'2026-01-20 16:34:19',NULL),(5,'洗护产品',0,0,'2026-01-20 16:34:32',NULL),(6,'发膜系列',0,0,'2026-01-20 16:34:44',NULL),(7,'彩妆工具',0,0,'2026-01-20 16:35:01',NULL),(8,'美发工具',0,0,'2026-01-20 16:35:14',NULL),(9,'知识库',0,0,'2026-01-23 19:51:54',NULL),(10,'烫发',0,9,'2026-02-10 14:16:33',NULL),(11,'染发',0,9,'2026-02-10 16:08:02',NULL),(12,'洗发',0,9,'2026-02-10 16:08:25',NULL);
/*!40000 ALTER TABLE `article_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `topicId` bigint DEFAULT NULL,
  `uId` bigint DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `parentId` bigint DEFAULT NULL,
  `likes` bigint DEFAULT NULL,
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,1,'测试',0,NULL,'2026-02-28 13:12:43'),(2,1,1,'111',0,NULL,'2026-02-28 13:31:25'),(3,1,1,'3333',1,NULL,'2026-02-28 14:06:03'),(4,1,1,'444',3,NULL,'2026-02-28 14:06:10'),(5,1,1,'55',3,NULL,'2026-02-28 14:10:16'),(6,1,1,'0000000',0,NULL,'2026-02-28 14:49:24'),(7,1,1,'123',6,NULL,'2026-02-28 14:53:08'),(8,2,2,'123',0,NULL,'2026-02-28 18:18:05'),(9,2,2,'234',8,NULL,'2026-02-28 18:18:09');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `mName` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mIcon` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mRoute` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mParentId` bigint DEFAULT '0',
  `mSort` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'权限管理','Key','/users',0,0),(2,'用户管理','User','/users',1,0),(3,'角色权限管理','Key','/roles',1,0),(4,'菜单管理','Document','/menus',1,0),(6,'文章管理','Document','/articles/list',0,1),(7,' 文章列表','List','/articles/list',6,1),(8,'新增文章','Document','/articles/form',6,1),(9,'文章分类管理','FolderOpened','/articleTypes/list',0,1),(10,'分类列表','List','/articleTypes/list',9,1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_tags`
--

DROP TABLE IF EXISTS `question_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_tags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_id` bigint DEFAULT NULL,
  `tag_id` bigint DEFAULT NULL,
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_tags`
--

LOCK TABLES `question_tags` WRITE;
/*!40000 ALTER TABLE `question_tags` DISABLE KEYS */;
INSERT INTO `question_tags` VALUES (1,1,1,'2026-03-01 18:19:53'),(2,1,2,'2026-03-01 18:19:53'),(3,2,1,'2026-03-02 12:31:21'),(4,2,3,'2026-03-02 12:31:21'),(5,3,1,'2026-03-02 12:31:36'),(6,4,6,'2026-03-02 13:03:54'),(7,4,4,'2026-03-02 13:03:54'),(8,1,6,'2026-03-02 13:09:46'),(9,1,4,'2026-03-02 13:09:46'),(10,2,7,'2026-03-02 13:12:15'),(11,2,6,'2026-03-02 13:12:15');
/*!40000 ALTER TABLE `question_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `uId` bigint DEFAULT NULL,
  `pageViews` bigint DEFAULT '0',
  `likes` bigint DEFAULT '0',
  `status` tinyint DEFAULT '0' COMMENT '0:待回答,1:已回答,2:已解决',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'sss','ssssssss',1,3,1,2,'2026-03-02 13:09:46',NULL),(2,'dfff','ffffffff',1,2,0,2,'2026-03-02 13:12:15',NULL);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rName` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rRemark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin',NULL,'2026-01-21 15:32:04',NULL),(2,'Normal',NULL,'2026-01-23 16:08:02',NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_menu`
--

DROP TABLE IF EXISTS `role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `roleId` bigint DEFAULT NULL,
  `menuId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menu`
--

LOCK TABLES `role_menu` WRITE;
/*!40000 ALTER TABLE `role_menu` DISABLE KEYS */;
INSERT INTO `role_menu` VALUES (21,1,1),(22,1,2),(23,1,3),(24,1,4),(35,2,6),(36,2,7),(37,2,8),(38,2,9),(39,2,10),(40,2,1),(41,2,2);
/*!40000 ALTER TABLE `role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'染发','染发','2026-03-01 09:07:32'),(2,'烫发1','烫发','2026-03-01 10:47:41'),(3,'吹发','','2026-03-01 14:35:45'),(4,'试试','','2026-03-01 14:36:31'),(6,'dd','d','2026-03-02 13:03:41'),(7,'ff','ff','2026-03-02 13:12:03');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `des` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'ddss','ddd'),(2,'aa','a'),(3,'cc','c'),(4,'ee','e'),(5,'方法','发'),(6,'的','是');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `uId` bigint DEFAULT NULL,
  `pageViews` bigint DEFAULT '0',
  `likes` bigint DEFAULT '0',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` VALUES (1,'话题1','话题1话题1',1,58,4,'2026-02-28 11:57:11',NULL),(2,'000','11111',2,4,1,'2026-02-28 18:17:57',NULL);
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uName` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uPasswords` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uPhone` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','CinA5MJWDvBTvOJSvluE4g==','13100000000','2026-02-28 08:59:29',NULL),(2,'test','1jdzWuniG6UMtoa3T6uNLA==','13100000000','2026-02-28 09:00:06',NULL),(3,'000','nSSXzuhG4WilyjUHHaeaWg==','13100000000','2026-02-28 09:00:17',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `userId` bigint DEFAULT NULL,
  `roleId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (7,1,1),(8,1,2),(9,2,2);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_user`
--

DROP TABLE IF EXISTS `web_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uName` varchar(100) DEFAULT NULL,
  `uPasswords` varchar(100) DEFAULT NULL,
  `uPhone` varchar(45) DEFAULT NULL,
  `uAvatar` varchar(255) DEFAULT NULL,
  `uOccupation` varchar(45) DEFAULT NULL,
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_user`
--

LOCK TABLES `web_user` WRITE;
/*!40000 ALTER TABLE `web_user` DISABLE KEYS */;
INSERT INTO `web_user` VALUES (1,'000','nSSXzuhG4WilyjUHHaeaWg==','13100000000','/fileManageEndPoint/downLoadFromOSS?fileName=WebSiteAvatars/1772243449626_avatar.jpg','00','2026-02-28 09:35:16',NULL),(2,'111','i9Pko7W0jiwpL+R5ph3Qmg==','13122222222','','00','2026-02-28 18:17:31',NULL);
/*!40000 ALTER TABLE `web_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webuser_questionlikes`
--

DROP TABLE IF EXISTS `webuser_questionlikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webuser_questionlikes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uId` bigint DEFAULT NULL,
  `qId` bigint DEFAULT NULL,
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webuser_questionlikes`
--

LOCK TABLES `webuser_questionlikes` WRITE;
/*!40000 ALTER TABLE `webuser_questionlikes` DISABLE KEYS */;
INSERT INTO `webuser_questionlikes` VALUES (1,1,1,'2026-03-02 13:09:51');
/*!40000 ALTER TABLE `webuser_questionlikes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webuser_topiclikes`
--

DROP TABLE IF EXISTS `webuser_topiclikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webuser_topiclikes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uId` bigint DEFAULT NULL,
  `tId` bigint DEFAULT NULL,
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webuser_topiclikes`
--

LOCK TABLES `webuser_topiclikes` WRITE;
/*!40000 ALTER TABLE `webuser_topiclikes` DISABLE KEYS */;
INSERT INTO `webuser_topiclikes` VALUES (8,2,2,'2026-02-28 18:18:14'),(11,1,1,'2026-03-02 13:06:09');
/*!40000 ALTER TABLE `webuser_topiclikes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'beautyindustry'
--
/*!50003 DROP PROCEDURE IF EXISTS `proc_cancelLike` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cancelLike`(in tId bigint)
BEGIN

update topics t set t.likes = ifnull(t.likes,0) - 1  where t.id = tId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_cancelQuestionLike` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cancelQuestionLike`(in qId bigint)
BEGIN

update questions q set q.likes = ifnull(q.likes,0) - 1  where q.id = qId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_cancelTopicLike` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_cancelTopicLike`(in tId bigint)
BEGIN

update topics t set t.likes = ifnull(t.likes,0) - 1  where t.id = tId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteAnswerById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteAnswerById`(in id bigint)
BEGIN

delete from answers a where a.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteArticleTypeById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteArticleTypeById`(in id bigint)
BEGIN

delete from article_type art where art.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteCommentById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteCommentById`(in id bigint)
BEGIN

delete from comment c where c.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteMenuById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteMenuById`(in id bigint)
BEGIN

delete from menu m where m.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteQuestionById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteQuestionById`(in id bigint)
BEGIN

delete from questions q where q.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteQuestionTag` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteQuestionTag`(in qId bigint,in tId bigint)
BEGIN

delete from question_tags qt where qt.question_id = qId and qt.tag_id = tId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteRoleById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteRoleById`(in id bigint)
BEGIN

delete from `role` r where r.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteRoleMenu` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteRoleMenu`(in id bigint)
BEGIN

if exists(select 1 from role_menu rm where rm.roleId = id)
then
delete from role_menu rm where rm.roleId = id and rm.id>0;
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteTagById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteTagById`(in id bigint)
BEGIN

delete from tags t where t.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteTopicById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteTopicById`(in id bigint)
BEGIN

delete from topics t where t.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteUidQid` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteUidQid`(in uId bigint,in qId bigint)
BEGIN

delete from webuser_questionlikes wq where wq.uId = uId and wq.qId = qId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteUserRole` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteUserRole`(in id bigint)
BEGIN

if exists(select 1 from user_role ur where ur.userId = id)
then
delete from user_role ur where ur.userId = id and ur.id>0;
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteWebUserQuestionLikes` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteWebUserQuestionLikes`(in uId bigint,in qId bigint)
BEGIN

delete from webuser_questionlikes wq where wq.uId = uId and wq.qId = qId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_deleteWebUserTopicLikes` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_deleteWebUserTopicLikes`(in uId bigint,in tId bigint)
BEGIN

delete from webuser_topiclikes wt where wt.uId = uId and wt.tId = tId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_getMenuByUid` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getMenuByUid`(in id bigint)
BEGIN

select 
distinct m.id,m.mName,m.mIcon,m.mRoute,m.mParentId,m.mSort 
from user u
right join user_role ur on u.id = ur.userId
right join `role` r on r.id = ur.roleId
right join role_menu rm on rm.roleId = r.id
right join menu m on m.id = rm.menuId
where u.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertAnswer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertAnswer`(in questionId BIGINT,in uId BIGINT,in content TEXT
)
BEGIN

insert into answers (questionId,uId,content) 
values (questionId,uId,content);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertArticle` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertArticle`(in title varchar(255),in author varchar(255),in introduce varchar(255),in articleType int,in content text,in statuss int,in isRecommend bool)
BEGIN

insert into article(article.title,article.author,article.introduce,article.articleType,article.content,article.statuss,article.isRecommend,createTime)
values(title,author,introduce,articleType,content,statuss,isRecommend,current_timestamp());

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertArticleType` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertArticleType`(in atName varchar(100),in atSort bigint,in parentId bigint)
BEGIN

insert into article_type(atname,atSort,parentId) values(atName,atSort,parentId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertComment` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertComment`(in topicId BIGINT,in uId BIGINT,in content TEXT
,in parentId BIGINT)
BEGIN

insert into comment (topicId,uId,content,parentId) 
values (topicId,uId,content,parentId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertMenu` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertMenu`(in mName varchar(45),in mIcon varchar(45),in mRoute varchar(45),in mParentId bigint,in mSort bigint)
BEGIN

insert into menu(mName,mIcon,mRoute,mParentId,mSort) values (mName,mIcon,mRoute,mParentId,mSort);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertQuestion` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertQuestion`(in title VARCHAR(255),in content text
,in uId bigint)
BEGIN

insert into questions (title,content,uId)
values (title,content,uId);

select @@identity as id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertQuestionTag` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertQuestionTag`(in question_id bigint,in tag_id bigint)
BEGIN

insert into question_tags(question_id,tag_id)
values (question_id,tag_id);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertRole` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertRole`(in rName varchar(45))
BEGIN

insert into role(rName) values(rName);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertRoleMenu` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertRoleMenu`(in roleId bigint,in menuId bigint)
BEGIN

insert into role_menu(roleId,menuId) values(roleId,menuId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertTag` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertTag`(in `name` VARCHAR(45),in `description` VARCHAR(200))
BEGIN

insert into tags(name,description)
values (`name`  ,`description` );

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertTopics` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertTopics`(in title VARCHAR(255),in content text
,in uId bigint)
BEGIN

insert into topics (title,content,uId)
values (title,content,uId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertUser` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertUser`(in uName varchar(100),in uPasswords varchar(100),in uPhone varchar(45))
BEGIN

insert into user(uName,uPasswords,uPhone) values(uName,uPasswords,uPhone);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertUserRole` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertUserRole`(in userId bigint,in roleId bigint)
BEGIN

insert into user_role(userId,roleId) values (userId,roleId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertWebUser` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertWebUser`(in uName varchar(100),in uPasswords varchar(100),in uPhone varchar(45),in uAvatar varchar(255),in uOccupation varchar(255))
BEGIN

insert into web_user(uName,uPasswords,uPhone,uAvatar,uOccupation) values(uName,uPasswords,uPhone,uAvatar,uOccupation);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertWebUserQuestionLikes` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertWebUserQuestionLikes`(in uId bigint,in qId bigint)
BEGIN

insert into webuser_questionlikes (uId,qId)
values (uId,qId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_insertWebUserTopicLikes` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_insertWebUserTopicLikes`(in uId bigint,in tId bigint)
BEGIN

insert into webuser_topiclikes (uId,tId)
values (uId,tId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_login` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_login`(in uName varchar(100),in uPhone varchar(255), in uPasswords varchar(100))
BEGIN

select 
u.id,u.uName,u.uPhone
from user u
where (u.uName = uName or u.uPhone = uPhone) and u.uPasswords = uPasswords;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_loginWeb` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loginWeb`(in uName varchar(100),in uPhone varchar(255), in uPasswords varchar(100))
BEGIN

select 
u.id,u.uName,u.uPhone,u.uAvatar,u.uOccupation 
from web_user u
where u.uPhone = (uPhone COLLATE utf8mb4_unicode_ci) and u.uPasswords = (uPasswords COLLATE utf8mb4_unicode_ci);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_searchArticle` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_searchArticle`(in keywords varchar(255), in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS ar.id,ar.title,ar.author,ar.introduce,ar.articleType, ar.content,ar.pageViews,ar.statuss,ar.isRecommend,ar.createTime 
from article ar
where ar.content like concat('%',keywords COLLATE utf8mb4_unicode_ci,'%')
order by ar.createTime desc
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_select` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_select`(in nameparams varchar(45))
BEGIN

select * from test t where t.name like CONCAT('%',nameparams,'%') ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectAllTags` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectAllTags`()
BEGIN

select id,name,description,createTime from tags;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectAnswerByPage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectAnswerByPage`(in questionId bigint,in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS a.id,a.questionId,a.uId,a.content,a.isAccepted,a.status,a.createTime
  ,wu.uName,wu.uOccupation,wu.uAvatar
 from answers a
 left join web_user wu on wu.id = a.uId
 where a.questionId = questionId
 limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectArticleById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectArticleById`(in id bigint)
BEGIN

select * from article ar where ar.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectArticleByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectArticleByPage`(in title varchar(255),in statuss int,in articleType bigint,in startTime datetime,in endTime datetime, in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS ar.id,ar.title,ar.author,ar.introduce,ar.articleType,art.atName, ar.content,ar.pageViews,ar.statuss,ar.isRecommend,ar.createTime 
from article ar
left join article_type art on art.id = ar.articleType
where ar.title like concat('%',title COLLATE utf8mb4_unicode_ci,'%')
and (ar.statuss = statuss or statuss = -1 or statuss is null)
and (ar.articleType = articleType or articleType = -1 or articleType is null)
and (ar.createTime >= startTime or startTime is null) 
and (ar.createTime <= endTime or endTime is null)
order by ar.createTime desc
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectArticleType` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectArticleType`()
BEGIN

select id,atName,atSort,parentId,createTime,updateTime from articletype;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectArticleTypeByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectArticleTypeByPage`(in atName varchar(100), in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS art.id,art.atName,art.atSort,art.parentId,art.createTime,art.updateTime 
from article_type art
where art.atName like concat('%',atName COLLATE utf8mb4_unicode_ci ,'%')
order by art.atSort desc
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectCommentByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectCommentByPage`(in topicId bigint,in pageSize int,in pageNumber int)
BEGIN

WITH RECURSIVE comment_tree AS (
  (SELECT 
    c.id, c.topicId, c.uId, c.content, c.parentId, c.createTime,
    wu.uName, wu.uOccupation, wu.uAvatar
  FROM comment c
  LEFT JOIN web_user wu ON wu.id = c.uId
  WHERE c.topicId = topicId AND c.parentId = 0
  ORDER BY c.createTime DESC 
  LIMIT pageNumber,pageSize)
  UNION ALL
 ( SELECT 
    c.id, c.topicId, c.uId, c.content, c.parentId, c.createTime,
    wu.uName, wu.uOccupation, wu.uAvatar
  FROM comment c
  LEFT JOIN web_user wu ON wu.id = c.uId
  INNER JOIN comment_tree ct ON ct.id = c.parentId
  WHERE c.topicId = topicId)
)
SELECT * FROM comment_tree;

SELECT count(1) as total from comment c where c.topicId = topicId AND c.parentId = 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectMenuAll` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectMenuAll`()
BEGIN

select * from menu order by mSort desc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectMenuByRoleId` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectMenuByRoleId`(IN id bigint)
BEGIN

select distinct m.id,m.mName,m.mIcon,m.mRoute,m.mParentId,m.mSort ,
case when rm.roleId IS NOT NULL THEN true else false end as isChecked
from menu m
left join role_menu rm on rm.menuId = m.id and rm.roleId = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectMyLikes` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectMyLikes`(in uId bigint,in pageSize int,in pageNumber int)
BEGIN

select id,uId,tId 
from webuser_topiclikes wt
left join topics t on t.uId = wt.uId
WHERE wt.uId = uId
limit pageNumber,pageSize;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectMyLikesByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectMyLikesByPage`(in uId bigint,in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS t.id,wt.uId,wt.tId,t.title,t.content,t.pageViews,t.likes,t.createTime
 ,wu.uName,wu.uOccupation,wu.uAvatar
from webuser_topiclikes wt
left join topics t on t.uId = wt.uId
left join web_user wu on wu.id = wt.uId 
WHERE wt.uId = uId
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectMyQuestionLikesByPage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectMyQuestionLikesByPage`(in uId bigint,in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS q.id,wq.uId,wq.qId,q.title,q.content,q.pageViews,q.likes,q.status,q.createTime
 ,wu.uName,wu.uOccupation,wu.uAvatar
from webuser_questionlikes wq
left join questions q on q.uId = wq.uId
left join web_user wu on wu.id = wq.uId 
WHERE wq.uId = uId
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectMyQuestionsByPage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectMyQuestionsByPage`(in uId bigint,in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS q.id,q.title,q.content,q.uId,q.likes,q.status,q.createTime 
 ,wu.uName,wu.uOccupation,wu.uAvatar
 
from questions q 
left join web_user wu on wu.id = q.uId
where wu.id = uId
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectMyTopics` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectMyTopics`(in uId bigint,in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS t.id,t.title,t.content,t.uId,t.likes,t.createTime 
 ,wu.uName,wu.uOccupation,wu.uAvatar
,(select count(1) from comment c where c.topicId = t.id and c.parentId = 0) as comments 
from topics t 
left join web_user wu on wu.id = t.uId
where wu.id = uId
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectMyTopicsByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectMyTopicsByPage`(in uId bigint,in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS t.id,t.title,t.content,t.uId,t.likes,t.createTime 
 ,wu.uName,wu.uOccupation,wu.uAvatar
,(select count(1) from comment c where c.topicId = t.id and c.parentId = 0) as comments 
from topics t 
left join web_user wu on wu.id = t.uId
where wu.id = uId
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectPublishArticleById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectPublishArticleById`(in id bigint)
BEGIN

select * from article ar where ar.id = id and ar.statuss = 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectQuestionById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectQuestionById`(in id bigint)
BEGIN

select q.id,q.title,q.content,q.uId,q.pageViews,q.likes,q.createTime 
,wu.uName,wu.uOccupation,wu.uAvatar
,GROUP_CONCAT(t.name ORDER by t.id SEPARATOR ',') as tagNames
from questions q 
left join web_user wu on wu.id = q.uId
left join question_tags qt on qt.question_id = q.id
left join tags t on qt.tag_id = t.id
where q.id = id
GROUP BY q.id,q.title,q.content,q.uId,q.pageViews,q.likes;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectQuestionsByPage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectQuestionsByPage`(in `status` tinyint, in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS q.id,q.title,q.content,q.uId,q.pageViews,q.likes,q.createTime 
,GROUP_CONCAT(t.name ORDER by t.id SEPARATOR ',') as tagNames
,(select count(1) from answers an where an.questionId = q.id) as answers
from questions q
left join question_tags qt on qt.question_id = q.id
left join tags t on qt.tag_id = t.id
where (q.status = `status` or `status` = -1 or `status` is null)
GROUP BY q.id, q.title, q.content, q.uId, q.pageViews, q.likes
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectRoleByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectRoleByPage`(in rName varchar(45),in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS r.id,r.rName,r.rRemark,r.createTime from role r
where r.rName like concat('%',rName,'%')
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectRolesByUid` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectRolesByUid`(in id bigint)
BEGIN

select distinct *, 
case when ur.userId is not null then true else false end as isChecked
from role r
left join user_role ur on ur.roleId = r.id and ur.userId = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectTagById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectTagById`(in id bigint)
BEGIN

select t.id,t.name,t.description,t.createTime from tags t where t.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectTagByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectTagByName`(in `name` VARCHAR(45))
BEGIN

select count(1) as count from tags t where t.name = `name` COLLATE utf8mb4_unicode_ci;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectTagsByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectTagsByPage`(in `name` VARCHAR(45),in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS t.id,t.name,t.description,t.createTime from tags t
where t.name like concat('%',`name` COLLATE utf8mb4_unicode_ci,'%')
order by t.createTime desc
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectTopicById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectTopicById`(in id bigint)
BEGIN

select t.id,t.title,t.content,t.uId,t.pageViews,t.likes,t.createTime 
,wu.uName,wu.uOccupation,wu.uAvatar
,(select count(1) from comment c where c.topicId = t.id and c.parentId = 0) as comments
from topics t 
left join web_user wu on wu.id = t.uId
where t.id = id
GROUP BY t.id,t.title,t.content,t.uId,t.pageViews,t.likes;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectTopicsByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectTopicsByPage`(in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS t.id,t.title,t.content,t.uId,t.likes,t.createTime
 ,wu.uName,wu.uOccupation,wu.uAvatar
 ,(select count(1) from comment c where c.topicId = t.id and c.parentId = 0) as comments
from topics t 
left join web_user wu on wu.id = t.uId
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectUidQid` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectUidQid`(in uId bigint,in qId bigint)
BEGIN

select count(1) as count from
webuser_questionlikes wq where wq.uId = uId and wq.qId = qId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectUidTid` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectUidTid`(in uId bigint,in tId bigint)
BEGIN

select count(1) as count from webuser_topiclikes wt 
where wt.uId = uId and wt.tId = tId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectUserById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectUserById`(in id bigint)
BEGIN

select u.id,u.uName,u.uPasswords,u.uPhone,u.uAvatar,u.uOccupation
from user u where u.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectUsersByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectUsersByPage`(in uName varchar(100),in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS u.id,u.uName,u.uPhone,u.createTime 
 from user u
 where u.uName like concat('%',uName,'%')
 limit pageNumber, pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectWebArticleByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectWebArticleByPage`(in statuss int,in articleType bigint,in isRecommend TINYINT,in parentId bigint,in startTime varchar(255),in endTime varchar(255), in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS ar.id,ar.title,ar.author,ar.introduce,ar.articleType,art.atName, ar.content,ar.pageViews,ar.statuss,ar.isRecommend,ar.createTime 
from article ar
left join article_type art on art.id = ar.articleType
where (ar.statuss = statuss or statuss = -1 or statuss is null)
and (ar.articleType = articleType or articleType = -1 or articleType is null)
and (ar.isRecommend = isRecommend or isRecommend = -1 or isRecommend is null)
and (art.parentId = parentId or parentId = -1 or parentId is null) 
and (ar.createTime >= startTime or startTime is null) 
and (ar.createTime <= endTime or endTime is null)
order by ar.createTime desc
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectWebArticleTypeByPage` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectWebArticleTypeByPage`(in parentId bigint, in pageSize int,in pageNumber int)
BEGIN

select SQL_CALC_FOUND_ROWS art.id,art.atName,art.atSort,art.parentId,art.createTime
from article_type art
where (art.parentId = parentId or parentId = -1 or parentId is null)
order by art.atSort desc
limit pageNumber,pageSize;

select FOUND_ROWS() AS total;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_selectWebUserById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_selectWebUserById`(in id bigint)
BEGIN

select u.id,u.uName,u.uPasswords,u.uPhone,u.uAvatar,u.uOccupation
from web_user u where u.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateAnsweredStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateAnsweredStatus`(in id bigint)
BEGIN

update questions q set q.status = 1
where q.id = id and q.status = 0;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateAnswerIsAccepted` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateAnswerIsAccepted`(in id bigint)
BEGIN

update answers a set a.isAccepted = 1 where a.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateArticle` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateArticle`(in id bigint, in title varchar(255),in author varchar(255),in introduce varchar(255),in articleType int,in content text,in statuss int,in isRecommend bool)
BEGIN

update article att set att.title = title,att.author = author,att.introduce = introduce,att.articleType = articleType,att.content = content,att.statuss=statuss,att.isRecommend=isRecommend
where att.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateArticleType` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateArticleType`(in id bigint, in atName varchar(100),in atSort bigint)
BEGIN

update article_type att set att.atName = atName,att.atSort = atSort where att.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateMenu` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateMenu`(in id bigint,in mName varchar(45),in mIcon varchar(45),in mRoute varchar(45),in mParentId bigint,in mSort bigint)
BEGIN

update menu m set m.mName = mName,m.mIcon = mIcon,m.mRoute = mRoute,m.mParentId = mParentId,m.mSort = mSort where m.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updatePageViews` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updatePageViews`(in id bigint,in pageViews bigint)
BEGIN

update article art set art.pageViews = pageViews where art.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateQuestionLikes` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateQuestionLikes`(in qId bigint)
BEGIN

update questions q set q.likes = ifnull(q.likes,0) + 1  where q.id = qId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateQuestionPageView` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateQuestionPageView`(in id bigint)
BEGIN

update questions q set q.pageViews = ifnull(q.pageViews,0) + 1 where q.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateQuestionStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateQuestionStatus`(in id bigint, in `status` tinyint)
BEGIN

update questions q set q.status = `status`
where q.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateRole` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateRole`(in id bigint,in rName varchar(45))
BEGIN

update role r set r.rName = r.rName where r.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateStatussById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateStatussById`(in id bigint,in statuss int)
BEGIN

update article ar set ar.statuss = statuss where ar.id=id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateTagById` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateTagById`(in id bigint,in `name` varchar(45))
BEGIN

update tags t set t.name = `name` where t.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateTopicLikes` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateTopicLikes`(in tId bigint)
BEGIN

update topics t set t.likes = ifnull(t.likes,0) + 1  where t.id = tId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateTopicPageViews` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateTopicPageViews`(in id bigint)
BEGIN

update topics t set t.pageViews = ifnull(t.pageViews,0) + 1 where t.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateUser` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateUser`(in id bigint,in uName varchar(100),in uPhone varchar(45))
BEGIN

update user u set u.uName = uName,u.uPhone = uPhone
where u.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateUserPWD` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateUserPWD`(in id bigint, in uPasswords varchar(100))
BEGIN

update user u set u.uPasswords = uPasswords where u.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateWebUser` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateWebUser`(in id bigint,in uName varchar(100),in uPhone varchar(45),in uOccupation varchar(45))
BEGIN

update web_user u set u.uName = uName,u.uPhone = uPhone,u.uOccupation = uOccupation 
where u.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateWebUserAvatar` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateWebUserAvatar`(in id bigint, in uAvatar varchar(255))
BEGIN

update web_user u set u.uAvatar = uAvatar 
where u.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!50003 DROP PROCEDURE IF EXISTS `proc_updateWebUserPWD` */;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_updateWebUserPWD`(in id bigint, in uPasswords varchar(100))
BEGIN

update web_user u set u.uPasswords = uPasswords where u.id = id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
ALTER DATABASE `beautyindustry` CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-05 11:42:24
