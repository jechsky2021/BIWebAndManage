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
  `id` bigint NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `uId` bigint DEFAULT NULL,
  `likes` bigint DEFAULT NULL,
  `parentId` bigint DEFAULT '0',
  `createTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
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
  `uAvatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uOccupation` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
INSERT INTO `user` VALUES (1,'admin','CinA5MJWDvBTvOJSvluE4g==','13100000000',NULL,NULL,'2026-02-28 08:59:29',NULL),(2,'test','1jdzWuniG6UMtoa3T6uNLA==','13100000000',NULL,NULL,'2026-02-28 09:00:06',NULL),(3,'000','nSSXzuhG4WilyjUHHaeaWg==','13100000000','/fileManageEndPoint/downLoadFromOSS?fileName=WebSiteAvatars/1772239254420_avatar.jpg','00','2026-02-28 09:00:17',NULL);
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-28  9:00:58
