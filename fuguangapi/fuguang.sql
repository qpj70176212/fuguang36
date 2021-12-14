-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: fuguang
-- ------------------------------------------------------
-- Server version	8.0.27-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `codename` varchar(100) NOT NULL,
  `content_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry','add_logentry',1),(2,'Can change log entry','change_logentry',1),(3,'Can delete log entry','delete_logentry',1),(4,'Can view log entry','view_logentry',1),(5,'Can add permission','add_permission',2),(6,'Can change permission','change_permission',2),(7,'Can delete permission','delete_permission',2),(8,'Can view permission','view_permission',2),(9,'Can add group','add_group',3),(10,'Can change group','change_group',3),(11,'Can delete group','delete_group',3),(12,'Can view group','view_group',3),(13,'Can add content type','add_contenttype',4),(14,'Can change content type','change_contenttype',4),(15,'Can delete content type','delete_contenttype',4),(16,'Can view content type','view_contenttype',4),(17,'Can add session','add_session',5),(18,'Can change session','change_session',5),(19,'Can delete session','delete_session',5),(20,'Can view session','view_session',5),(21,'Can add 轮播广告','add_banner',6),(22,'Can change 轮播广告','change_banner',6),(23,'Can delete 轮播广告','delete_banner',6),(24,'Can view 轮播广告','view_banner',6),(25,'Can add 导航菜单','add_nav',7),(26,'Can change 导航菜单','change_nav',7),(27,'Can delete 导航菜单','delete_nav',7),(28,'Can view 导航菜单','view_nav',7),(29,'Can add 用户信息','add_user',8),(30,'Can change 用户信息','change_user',8),(31,'Can delete 用户信息','delete_user',8),(32,'Can view 用户信息','view_user',8),(33,'Can add 课程信息','add_course',9),(34,'Can change 课程信息','change_course',9),(35,'Can delete 课程信息','delete_course',9),(36,'Can view 课程信息','view_course',9),(37,'Can add 学习方向','add_coursedirection',10),(38,'Can change 学习方向','change_coursedirection',10),(39,'Can delete 学习方向','delete_coursedirection',10),(40,'Can view 学习方向','view_coursedirection',10),(41,'Can add 讲师信息','add_teacher',11),(42,'Can change 讲师信息','change_teacher',11),(43,'Can delete 讲师信息','delete_teacher',11),(44,'Can view 讲师信息','view_teacher',11),(45,'Can add course lesson','add_courselesson',12),(46,'Can change course lesson','change_courselesson',12),(47,'Can delete course lesson','delete_courselesson',12),(48,'Can view course lesson','view_courselesson',12),(49,'Can add 课程分类','add_coursecategory',13),(50,'Can change 课程分类','change_coursecategory',13),(51,'Can delete 课程分类','delete_coursecategory',13),(52,'Can view 课程分类','view_coursecategory',13),(53,'Can add 课程章节','add_coursechapter',14),(54,'Can change 课程章节','change_coursechapter',14),(55,'Can delete 课程章节','delete_coursechapter',14),(56,'Can view 课程章节','view_coursechapter',14),(57,'Can add 课程参与活动的价格表','add_courseactivityprice',15),(58,'Can change 课程参与活动的价格表','change_courseactivityprice',15),(59,'Can delete 课程参与活动的价格表','delete_courseactivityprice',15),(60,'Can view 课程参与活动的价格表','view_courseactivityprice',15),(61,'Can add 优惠活动','add_activity',16),(62,'Can change 优惠活动','change_activity',16),(63,'Can delete 优惠活动','delete_activity',16),(64,'Can view 优惠活动','view_activity',16),(65,'Can add 优惠公式','add_discount',17),(66,'Can change 优惠公式','change_discount',17),(67,'Can delete 优惠公式','delete_discount',17),(68,'Can view 优惠公式','view_discount',17),(69,'Can add 优惠类型','add_discounttype',18),(70,'Can change 优惠类型','change_discounttype',18),(71,'Can delete 优惠类型','delete_discounttype',18),(72,'Can view 优惠类型','view_discounttype',18),(73,'Can add 订单记录','add_order',19),(74,'Can change 订单记录','change_order',19),(75,'Can delete 订单记录','delete_order',19),(76,'Can view 订单记录','view_order',19),(77,'Can add 订单详情','add_orderdetail',20),(78,'Can change 订单详情','change_orderdetail',20),(79,'Can delete 订单详情','delete_orderdetail',20),(80,'Can view 订单详情','view_orderdetail',20),(81,'Can add 优惠券','add_coupon',21),(82,'Can change 优惠券','change_coupon',21),(83,'Can delete 优惠券','delete_coupon',21),(84,'Can view 优惠券','view_coupon',21),(85,'Can add 优惠券发放和使用日志','add_couponlog',22),(86,'Can change 优惠券发放和使用日志','change_couponlog',22),(87,'Can delete 优惠券发放和使用日志','delete_couponlog',22),(88,'Can view 优惠券发放和使用日志','view_couponlog',22),(89,'Can add 优惠券与学习方向','add_coupondirection',23),(90,'Can change 优惠券与学习方向','change_coupondirection',23),(91,'Can delete 优惠券与学习方向','delete_coupondirection',23),(92,'Can view 优惠券与学习方向','view_coupondirection',23),(93,'Can add 优惠券与课程分类','add_couponcoursecat',24),(94,'Can change 优惠券与课程分类','change_couponcoursecat',24),(95,'Can delete 优惠券与课程分类','delete_couponcoursecat',24),(96,'Can view 优惠券与课程分类','view_couponcoursecat',24),(97,'Can add 优惠券与课程信息','add_couponcourse',25),(98,'Can change 优惠券与课程信息','change_couponcourse',25),(99,'Can delete 优惠券与课程信息','delete_couponcourse',25),(100,'Can view 优惠券与课程信息','view_couponcourse',25),(101,'Can add 积分流水','add_credit',26),(102,'Can change 积分流水','change_credit',26),(103,'Can delete 积分流水','delete_credit',26),(104,'Can view 积分流水','view_credit',26),(105,'Can add 用户课程购买记录','add_usercourse',27),(106,'Can change 用户课程购买记录','change_usercourse',27),(107,'Can delete 用户课程购买记录','delete_usercourse',27),(108,'Can view 用户课程购买记录','view_usercourse',27),(109,'Can add 问答记录','add_studyqa',28),(110,'Can change 问答记录','change_studyqa',28),(111,'Can delete 问答记录','delete_studyqa',28),(112,'Can view 问答记录','view_studyqa',28),(113,'Can add 课时进度记录','add_studyprogress',29),(114,'Can change 课时进度记录','change_studyprogress',29),(115,'Can delete 课时进度记录','delete_studyprogress',29),(116,'Can view 课时进度记录','view_studyprogress',29),(117,'Can add 学习笔记','add_studynote',30),(118,'Can change 学习笔记','change_studynote',30),(119,'Can delete 学习笔记','delete_studynote',30),(120,'Can view 学习笔记','view_studynote',30),(121,'Can add 代码记录','add_studycode',31),(122,'Can change 代码记录','change_studycode',31),(123,'Can delete 代码记录','delete_studycode',31),(124,'Can view 代码记录','view_studycode',31);
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_fg_users_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_fg_users_id` FOREIGN KEY (`user_id`) REFERENCES `fg_users` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2021-11-18 09:08:21.670399','3','3天学会Vue基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(2,'2021-11-18 09:09:21.516113','1','7天Typescript从入门到放弃',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(3,'2021-11-18 09:09:41.619994','2','3天Typescript精修',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(4,'2021-11-18 09:09:54.170921','3','3天学会Vue基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(5,'2021-11-18 10:11:48.404729','2','15709282031',2,'[]',8,1),(6,'2021-11-18 10:16:28.379770','5','18791425678',2,'[{\"changed\": {\"fields\": [\"\\u4e2a\\u4eba\\u5934\\u50cf\"]}}]',8,1),(7,'2021-11-18 10:20:26.819089','1','root',2,'[{\"changed\": {\"fields\": [\"\\u4e2a\\u4eba\\u5934\\u50cf\", \"Last login\"]}}]',8,1),(8,'2021-11-18 10:21:40.432035','3','15709282131',3,'',8,1),(9,'2021-11-18 10:23:12.029618','1','root',2,'[{\"changed\": {\"fields\": [\"\\u4e2a\\u4eba\\u5934\\u50cf\"]}}]',8,1),(10,'2021-11-18 10:32:11.564506','4','13312345671',2,'[]',8,1),(11,'2021-11-18 10:32:21.980498','4','13312345671',2,'[]',8,1),(12,'2021-11-18 10:32:34.501637','4','13312345671',2,'[{\"changed\": {\"fields\": [\"\\u4e2a\\u4eba\\u5934\\u50cf\"]}}]',8,1),(13,'2021-11-18 11:24:02.574607','1','7天Typescript从入门到放弃',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(14,'2021-11-18 11:24:22.161523','2','3天Typescript精修',2,'[{\"changed\": {\"fields\": [\"\\u8bfe\\u4ef6\\u8def\\u5f84\"]}}]',9,1),(15,'2021-11-18 11:24:34.868803','3','3天学会Vue基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u89c6\\u9891\"]}}]',9,1),(16,'2021-11-18 11:25:00.892897','2','3天Typescript精修',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(17,'2021-11-18 11:25:18.558788','3','3天学会Vue基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u89c6\\u9891\"]}}]',9,1),(18,'2021-11-18 11:26:03.151692','3','3天学会Vue基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u89c6\\u9891\"]}}]',9,1),(19,'2021-11-18 11:26:51.207523','3','3天学会Vue基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(20,'2021-11-18 11:27:50.701468','1','root',2,'[{\"changed\": {\"fields\": [\"\\u4e2a\\u4eba\\u5934\\u50cf\"]}}]',8,1),(21,'2021-11-18 11:29:04.399197','4','13312345671',2,'[{\"changed\": {\"fields\": [\"\\u4e2a\\u4eba\\u5934\\u50cf\"]}}]',8,1),(22,'2021-11-18 13:42:24.303334','10','Kotlin从入门到精通',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(23,'2021-11-18 13:42:45.400140','9','Android 应用程序构建实战',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(24,'2021-11-18 13:43:07.826063','8','Kubernetes 入门到进阶实战',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(25,'2021-11-18 13:43:36.762618','6','javascript进阶',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(26,'2021-11-18 13:43:45.105839','5','python基础入门',2,'[]',9,1),(27,'2021-11-18 13:43:58.491423','4','算法与数据结构体系课',2,'[]',9,1),(28,'2021-11-18 13:44:16.861676','5','python基础入门',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(29,'2021-11-18 13:44:38.056470','4','算法与数据结构体系课',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(30,'2021-11-18 13:44:54.995230','3','3天学会Vue基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(31,'2021-11-24 06:15:08.377653','3','3天学会Vue基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u89c6\\u9891\"]}}]',9,1),(32,'2021-11-24 06:34:32.617320','1','7天Typescript从入门到放弃',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u89c6\\u9891\"]}}]',9,1),(33,'2021-11-24 06:39:47.378227','4','算法与数据结构体系课',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(34,'2021-11-24 06:48:05.044976','11','深度学习之神经网络',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(35,'2021-11-24 06:48:30.000753','12','OpenCV入门到进阶',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(36,'2021-11-24 06:48:49.209127','20','Redis入门课程',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(37,'2021-11-24 06:49:07.063239','19','MongoDB入门到进阶',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(38,'2021-11-24 06:49:24.682380','18','MySQL事务处理精选',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(39,'2021-11-24 06:49:41.149173','17','高性能MySQL调优',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(40,'2021-11-24 06:49:56.354315','16','ZooKeeper分布式架构搭建',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(41,'2021-11-24 06:50:13.935284','13','Go容器化微服务系统实战',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(42,'2021-11-24 06:50:30.246339','15','TensorFlow基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(43,'2021-11-24 06:50:49.949795','14','RabbitMQ精讲',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(44,'2021-11-24 06:51:18.577404','3','3天学会Vue基础',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(45,'2021-11-24 06:51:37.473867','5','python基础入门',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(46,'2021-11-24 06:51:54.274320','10','Kotlin从入门到精通',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(47,'2021-11-24 06:52:14.738062','9','Android 应用程序构建实战',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(48,'2021-11-24 06:52:33.583705','8','Kubernetes 入门到进阶实战',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(49,'2021-11-24 06:52:57.901671','6','javascript进阶',2,'[{\"changed\": {\"fields\": [\"\\u5c01\\u9762\\u56fe\\u7247\"]}}]',9,1),(50,'2021-11-24 08:30:54.942146','2','7天Typescript从入门到放弃-第2章-Typescript的基本语法-第1课时-Typescript的变量和常量',1,'[{\"added\": {}}]',12,1),(51,'2021-11-24 18:43:19.215433','2','相约双十二·2021',1,'[{\"added\": {}}]',16,1),(52,'2021-11-24 18:45:16.205850','4','活动:相约双十二·2021-课程:深度学习之神经网络-优惠公式:*0.9',1,'[{\"added\": {}}]',15,1),(53,'2021-11-24 18:47:47.208164','1','浮光在线-1周年庆',2,'[{\"changed\": {\"fields\": [\"\\u5f00\\u59cb\\u65f6\\u95f4\", \"\\u7ed3\\u675f\\u65f6\\u95f4\", \"\\u5907\\u6ce8\\u4fe1\\u606f\"]}}]',16,1),(54,'2021-11-24 20:17:07.104562','4','活动:相约双十二·2021-课程:深度学习之神经网络-优惠公式:*0.9',2,'[]',15,1),(55,'2021-11-24 20:23:50.655089','4','活动:相约双十二·2021-课程:深度学习之神经网络-优惠公式:*0.9',2,'[{\"changed\": {\"fields\": [\"\\u663e\\u793a\\u987a\\u5e8f\"]}}]',15,1),(56,'2021-11-24 20:36:23.757746','2','相约双十二·2021',2,'[{\"changed\": {\"fields\": [\"\\u5f00\\u59cb\\u65f6\\u95f4\"]}}]',16,1),(57,'2021-11-29 15:39:27.997758','1','七夕优惠券',1,'[{\"added\": {}}]',21,1),(58,'2021-11-29 15:44:03.334251','2','七夕优惠券',1,'[{\"added\": {}}]',22,1),(59,'2021-11-29 16:00:47.268623','5','5',2,'[{\"changed\": {\"fields\": [\"\\u8ba2\\u5355\"]}}]',22,1),(60,'2021-11-29 16:00:51.859819','8','4',2,'[]',22,1),(61,'2021-11-29 16:00:56.894775','9','3',2,'[{\"changed\": {\"fields\": [\"\\u8ba2\\u5355\"]}}]',22,1),(62,'2021-11-29 16:01:03.443565','10','2',2,'[]',22,1),(63,'2021-11-29 16:01:07.956115','11','1',2,'[]',22,1),(64,'2021-11-29 16:01:13.480667','12','6',2,'[{\"changed\": {\"fields\": [\"\\u8ba2\\u5355\"]}}]',22,1),(65,'2021-11-29 16:02:01.979962','10','2',2,'[]',22,1),(66,'2021-11-30 08:44:19.520722','1','浮光在线-1周年庆',2,'[{\"changed\": {\"fields\": [\"\\u7ed3\\u675f\\u65f6\\u95f4\"]}}]',16,1),(67,'2021-11-30 15:24:58.780901','1','root',2,'[{\"changed\": {\"fields\": [\"\\u79ef\\u5206\"]}}]',8,1),(68,'2021-11-30 15:26:08.595700','1','root',2,'[{\"changed\": {\"fields\": [\"\\u79ef\\u5206\"]}}]',8,1),(69,'2021-11-30 15:36:06.783519','5','python基础入门',2,'[{\"changed\": {\"fields\": [\"\\u79ef\\u5206\"]}}]',9,1),(70,'2021-11-30 20:02:26.564076','5','python基础入门',2,'[]',9,1),(71,'2021-11-30 20:04:11.580113','1','root',2,'[{\"changed\": {\"fields\": [\"\\u79ef\\u5206\"]}}]',8,1),(72,'2021-12-01 19:44:35.563544','6','javascript进阶',2,'[{\"changed\": {\"fields\": [\"\\u79ef\\u5206\"]}}]',9,1),(73,'2021-12-01 19:57:43.297063','51','购买课程,总价: 1498.00,实付: 1248.30',3,'',19,1),(74,'2021-12-01 19:58:00.345826','50','购买课程,总价: 998.00,实付: 998.00',3,'',19,1),(75,'2021-12-01 19:58:19.277840','49','购买课程,总价: 900.00,实付: 897.00',3,'',19,1),(76,'2021-12-01 19:58:19.296976','48','购买课程,总价: 1400.00,实付: 1297.00',3,'',19,1),(77,'2021-12-01 20:05:18.367196','1','',3,'',27,1),(78,'2021-12-01 20:05:18.406109','2','',3,'',27,1),(79,'2021-12-01 20:05:18.414876','3','',3,'',27,1),(80,'2021-12-01 20:05:18.421219','4','',3,'',27,1),(81,'2021-12-02 10:46:47.550168','5','',3,'',27,1),(82,'2021-12-02 10:46:47.845382','6','',3,'',27,1),(83,'2021-12-02 10:48:55.645202','1','root',2,'[{\"changed\": {\"fields\": [\"\\u79ef\\u5206\"]}}]',8,1),(84,'2021-12-03 18:22:53.691995','6','50元通用优惠券',1,'[{\"added\": {}}]',21,1),(85,'2021-12-03 18:27:20.412648','5','活动:浮光在线-1周年庆-课程:javascript进阶-优惠公式:0',1,'[{\"added\": {}}]',15,1),(86,'2021-12-03 20:02:50.362865','1','7天Typescript从入门到放弃-第1章-Typescript基本安装-第1课时-Typescript的基本介绍',2,'[{\"changed\": {\"fields\": [\"\\u8bfe\\u7a0b\\u94fe\\u63a5\"]}}]',12,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(21,'coupon','coupon'),(25,'coupon','couponcourse'),(24,'coupon','couponcoursecat'),(23,'coupon','coupondirection'),(22,'coupon','couponlog'),(16,'courses','activity'),(9,'courses','course'),(15,'courses','courseactivityprice'),(13,'courses','coursecategory'),(14,'courses','coursechapter'),(10,'courses','coursedirection'),(12,'courses','courselesson'),(17,'courses','discount'),(18,'courses','discounttype'),(11,'courses','teacher'),(6,'home','banner'),(7,'home','nav'),(19,'orders','order'),(20,'orders','orderdetail'),(5,'sessions','session'),(26,'users','credit'),(31,'users','studycode'),(30,'users','studynote'),(29,'users','studyprogress'),(28,'users','studyqa'),(8,'users','user'),(27,'users','usercourse');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-11-10 09:17:22.518199'),(2,'contenttypes','0002_remove_content_type_name','2021-11-10 09:17:22.641440'),(3,'auth','0001_initial','2021-11-10 09:17:23.010218'),(4,'users','0001_initial','2021-11-10 09:17:23.424178'),(5,'admin','0001_initial','2021-11-10 09:17:23.608265'),(6,'admin','0002_logentry_user','2021-11-10 09:17:23.749960'),(7,'home','0001_initial','2021-11-10 09:17:23.847154'),(8,'sessions','0001_initial','2021-11-10 09:17:23.912393'),(12,'courses','0001_initial','2021-11-17 10:00:49.063370'),(13,'courses','0002_auto_20211117_1751','2021-11-17 10:00:49.108187'),(14,'courses','0003_auto_20211117_1800','2021-11-17 10:00:49.151163'),(15,'courses','0004_auto_20211124_1521','2021-11-24 07:22:14.076852'),(16,'users','0002_alter_user_avatar','2021-11-24 07:22:14.896188'),(17,'courses','0005_activity_courseactivityprice_discount_discounttype','2021-11-24 09:27:12.286803'),(18,'courses','0006_auto_20211126_1653','2021-11-26 16:54:47.520786'),(19,'orders','0001_initial','2021-11-26 16:54:48.345071'),(20,'courses','0007_auto_20211129_1412','2021-11-29 14:12:35.699205'),(21,'coupon','0001_initial','2021-11-29 14:12:36.886374'),(22,'courses','0008_auto_20211130_1520','2021-11-30 15:20:22.039300'),(23,'orders','0002_order_credit','2021-11-30 15:20:22.206353'),(24,'users','0003_credit','2021-11-30 15:20:22.557524'),(25,'courses','0009_auto_20211201_1604','2021-12-01 16:05:36.474712'),(26,'users','0004_usercourse','2021-12-01 16:05:36.870419'),(27,'orders','0003_alter_order_order_status','2021-12-03 21:34:24.630670'),(28,'users','0005_studycode_studynote_studyprogress_studyqa','2021-12-03 21:34:25.887222');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_activity`
--

DROP TABLE IF EXISTS `fg_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_activity` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `description` longtext,
  `remark` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_activity`
--

LOCK TABLES `fg_activity` WRITE;
/*!40000 ALTER TABLE `fg_activity` DISABLE KEYS */;
INSERT INTO `fg_activity` VALUES (1,'浮光在线-1周年庆',1,1,'2021-07-29 10:42:54.340893','2021-11-30 08:44:19.500095',0,'2021-11-24 00:00:00.000000','2021-12-30 00:00:00.000000','<p><img alt=\"\" src=\"/uploads/ckeditor/2021/07/29/d2c059da6e09b35a.gif\" style=\"height:180px; width:1125px\" /></p>','负责人：\r\n组织：\r\n外勤：'),(2,'相约双十二·2021',0,1,'2021-11-24 18:43:19.206056','2021-11-24 20:36:23.727926',0,'2021-11-24 00:00:00.000000','2021-12-12 23:59:00.000000','<p>双十二，剁手节</p>','运营团队：xxx小组\r\n联系方式：xxxx\r\n联系人：xxx');
/*!40000 ALTER TABLE `fg_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_banner`
--

DROP TABLE IF EXISTS `fg_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_banner` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) NOT NULL,
  `link` varchar(500) NOT NULL,
  `note` varchar(150) NOT NULL,
  `is_http` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_banner`
--

LOCK TABLES `fg_banner` WRITE;
/*!40000 ALTER TABLE `fg_banner` DISABLE KEYS */;
INSERT INTO `fg_banner` VALUES (1,'1',1,1,'2021-07-15 03:39:49.859000','2021-07-15 03:39:51.437000',0,'banner/2021/1.jpg','/project','暂无',0),(2,'2',1,1,'2021-07-15 03:39:49.859000','2021-07-15 03:39:51.437000',0,'banner/2021/2.jpg','/project','暂无',0),(3,'3',1,1,'2021-07-15 03:39:49.859000','2021-07-15 03:39:51.437000',0,'banner/2021/3.jpg','/project','暂无',0),(4,'4',1,1,'2021-07-15 03:39:49.859000','2021-07-15 03:39:51.437000',0,'banner/2021/4.jpg','/project','暂无',0),(5,'5',1,1,'2021-07-15 03:39:49.859000','2021-07-15 03:39:51.437000',0,'banner/2021/5.jpg','/project','暂无',0);
/*!40000 ALTER TABLE `fg_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_coupon`
--

DROP TABLE IF EXISTS `fg_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_coupon` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `discount` smallint NOT NULL,
  `coupon_type` smallint NOT NULL,
  `total` int NOT NULL,
  `has_total` int NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `get_type` smallint NOT NULL,
  `condition` int NOT NULL,
  `per_limit` smallint NOT NULL,
  `sale` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_coupon`
--

LOCK TABLES `fg_coupon` WRITE;
/*!40000 ALTER TABLE `fg_coupon` DISABLE KEYS */;
INSERT INTO `fg_coupon` VALUES (1,'30元通用优惠券',1,1,'2021-08-04 10:35:40.569417','2021-08-04 10:35:40.569451',0,1,0,10000,10000,'2021-08-04 10:35:00.000000','2022-01-02 10:35:00.000000',0,100,1,'-30'),(2,'前端学习通用优惠券',1,1,'2021-08-04 10:36:58.401527','2021-08-04 10:36:58.401556',0,1,1,100,100,'2021-08-04 10:36:00.000000','2022-08-04 10:36:00.000000',0,0,1,'-50'),(3,'Typescript课程专用券',1,1,'2021-08-04 10:38:36.134581','2021-08-04 10:38:36.134624',0,2,3,1000,1000,'2021-08-04 10:38:00.000000','2022-08-04 10:38:00.000000',0,0,1,'*0.88'),(4,'python七夕专用券',1,1,'2021-08-04 10:40:08.022904','2021-08-04 10:40:08.022943',0,1,2,200,200,'2021-08-04 10:39:00.000000','2021-11-15 10:39:00.000000',1,0,1,'-99'),(5,'算法学习优惠券',1,1,'2021-08-05 10:05:07.837008','2021-08-05 10:05:07.837041',0,2,2,1000,1000,'2021-08-05 10:04:00.000000','2021-12-25 10:04:00.000000',0,200,1,'*0.85'),(6,'50元通用优惠券',0,1,'2021-12-03 18:22:53.645417','2021-12-03 18:22:53.645455',0,1,0,100,100,'2021-12-03 18:21:00.000000','2022-12-03 18:22:00.000000',0,400,1,'-50');
/*!40000 ALTER TABLE `fg_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_coupon_course`
--

DROP TABLE IF EXISTS `fg_coupon_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_coupon_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_time` datetime(6) NOT NULL,
  `coupon_id` bigint NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_coupon_course_coupon_id_7dc23ac9` (`coupon_id`),
  KEY `fg_coupon_course_course_id_c4e1e5e2` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_coupon_course`
--

LOCK TABLES `fg_coupon_course` WRITE;
/*!40000 ALTER TABLE `fg_coupon_course` DISABLE KEYS */;
INSERT INTO `fg_coupon_course` VALUES (1,'2021-08-04 10:38:36.140929',3,1),(2,'2021-08-04 10:38:36.143166',3,2);
/*!40000 ALTER TABLE `fg_coupon_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_coupon_course_category`
--

DROP TABLE IF EXISTS `fg_coupon_course_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_coupon_course_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_time` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  `coupon_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_coupon_course_category_category_id_af02f840` (`category_id`),
  KEY `fg_coupon_course_category_coupon_id_6570d53b` (`coupon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_coupon_course_category`
--

LOCK TABLES `fg_coupon_course_category` WRITE;
/*!40000 ALTER TABLE `fg_coupon_course_category` DISABLE KEYS */;
INSERT INTO `fg_coupon_course_category` VALUES (1,'2021-08-04 10:40:08.029505',20,4),(2,'2021-08-04 10:40:08.042891',21,4),(3,'2021-08-05 10:05:07.966221',33,5);
/*!40000 ALTER TABLE `fg_coupon_course_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_coupon_course_direction`
--

DROP TABLE IF EXISTS `fg_coupon_course_direction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_coupon_course_direction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_time` datetime(6) NOT NULL,
  `coupon_id` bigint NOT NULL,
  `direction_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_coupon_course_direction_coupon_id_21165d25` (`coupon_id`),
  KEY `fg_coupon_course_direction_direction_id_a10acfa9` (`direction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_coupon_course_direction`
--

LOCK TABLES `fg_coupon_course_direction` WRITE;
/*!40000 ALTER TABLE `fg_coupon_course_direction` DISABLE KEYS */;
INSERT INTO `fg_coupon_course_direction` VALUES (1,'2021-08-04 10:36:58.414461',2,1);
/*!40000 ALTER TABLE `fg_coupon_course_direction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_coupon_log`
--

DROP TABLE IF EXISTS `fg_coupon_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_coupon_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `use_time` datetime(6) DEFAULT NULL,
  `use_status` smallint DEFAULT NULL,
  `coupon_id` bigint NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_coupon_log_coupon_id_5327188f` (`coupon_id`),
  KEY `fg_coupon_log_order_id_0ca49b98` (`order_id`),
  KEY `fg_coupon_log_user_id_353ae856` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_coupon_log`
--

LOCK TABLES `fg_coupon_log` WRITE;
/*!40000 ALTER TABLE `fg_coupon_log` DISABLE KEYS */;
INSERT INTO `fg_coupon_log` VALUES (5,1,1,'2021-08-04 12:00:25.051976','2021-11-29 21:31:30.693242',0,'5',NULL,0,1,28,1),(8,1,1,'2021-08-04 12:03:24.331024','2021-11-29 16:00:51.842060',0,'4',NULL,0,2,NULL,1),(9,1,1,'2021-08-04 12:03:31.692397','2021-11-29 16:00:56.874294',0,'3',NULL,0,3,NULL,1),(10,1,1,'2021-08-04 12:03:38.225438','2021-11-29 16:02:01.967888',0,'2',NULL,0,4,NULL,1),(11,1,1,'2021-08-04 12:09:25.406437','2021-11-29 16:01:07.942835',0,'1',NULL,0,2,NULL,1);
/*!40000 ALTER TABLE `fg_coupon_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_course_activity_price`
--

DROP TABLE IF EXISTS `fg_course_activity_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_course_activity_price` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `activity_id` bigint NOT NULL,
  `course_id` bigint NOT NULL,
  `discount_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_course_activity_price_activity_id_c25d76b3` (`activity_id`),
  KEY `fg_course_activity_price_course_id_7ab452ca` (`course_id`),
  KEY `fg_course_activity_price_discount_id_a276e3f5` (`discount_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_course_activity_price`
--

LOCK TABLES `fg_course_activity_price` WRITE;
/*!40000 ALTER TABLE `fg_course_activity_price` DISABLE KEYS */;
INSERT INTO `fg_course_activity_price` VALUES (1,'九折-3天Typescript',1,1,'2021-07-29 10:48:12.600755','2021-07-29 10:48:12.600801',0,1,2,2),(2,'免费送课',1,1,'2021-07-29 11:36:34.192896','2021-07-29 11:36:34.192941',0,1,1,1),(3,'减免课程',1,1,'2021-07-29 11:40:49.240245','2021-07-29 11:40:49.240276',0,1,3,3),(4,'深度学习双十二促销',1,1,'2021-11-24 18:45:16.202408','2021-11-24 20:23:50.642959',0,2,11,2),(5,'javascript进价',0,1,'2021-12-03 18:27:20.404067','2021-12-03 18:27:20.404102',0,1,6,1);
/*!40000 ALTER TABLE `fg_course_activity_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_course_category`
--

DROP TABLE IF EXISTS `fg_course_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_course_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `remark` longtext,
  `direction_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `fg_course_category_direction_id_612d2d0e` (`direction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_course_category`
--

LOCK TABLES `fg_course_category` WRITE;
/*!40000 ALTER TABLE `fg_course_category` DISABLE KEYS */;
INSERT INTO `fg_course_category` VALUES (1,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Vue.js','',1),(2,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Typescript','',1),(3,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'React.js','',1),(4,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'HTML','',1),(5,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'JavaScript','',1),(6,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Angular','',1),(7,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Node.js','',1),(8,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'WebApp','',1),(9,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'小程序','',1),(10,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'前端工具','',1),(11,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'HTML/CSS','',1),(12,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Html5','',1),(13,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'CSS3','',1),(14,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Java','',2),(15,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'SpringBoot','',2),(16,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Spring Cloud','',2),(17,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'SSM','',2),(18,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'PHP','',2),(19,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'.net','',2),(20,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Python','',2),(21,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'爬虫','',2),(22,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Django','',2),(23,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Flask','',2),(24,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Go','',2),(25,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'C','',2),(26,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'C++','',2),(27,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'C#','',2),(28,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Flutter','',3),(29,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Android','',3),(30,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'iOS','',3),(31,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'React native','',3),(32,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'计算机网络','',4),(33,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'算法与数据结构','',4),(34,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'数学','',4),(35,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'微服务','',5),(36,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'机器学习','',5),(37,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'深度学习','',5),(38,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'计算机视觉','',5),(39,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'自然语言处理','',5),(40,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'数据分析&挖掘','',5),(41,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'大数据','',6),(42,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Hadoop','',6),(43,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Spark','',6),(44,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Hbase','',6),(45,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Flink','',6),(46,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Storm','',6),(47,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'阿里云','',7),(48,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'容器','',7),(49,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Docker','',7),(50,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Kubernetes','',7),(51,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'运维','',8),(52,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'自动化运维','',8),(53,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'中间件','',8),(54,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Linux','',8),(55,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'测试','',9),(56,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'功能测试','',9),(57,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'性能测试','',9),(58,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'自动化测试','',9),(59,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'接口测试','',9),(60,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'MySQL','',10),(61,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Redis','',10),(62,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'MongoDB','',10),(63,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'设计基础','',11),(64,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'设计工具','',11),(65,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'APPUI设计','',11),(66,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'Unity 3D','',13),(67,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'cocos creator','',13),(68,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'求职面试','',14),(69,1,1,'2021-07-22 08:00:19.366304','2021-07-22 08:00:19.367343',0,'leetcode','',14);
/*!40000 ALTER TABLE `fg_course_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_course_chapter`
--

DROP TABLE IF EXISTS `fg_course_chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_course_chapter` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `orders` smallint NOT NULL,
  `summary` longtext,
  `pub_date` date NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_course_chapter_course_id_62bddd8f` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_course_chapter`
--

LOCK TABLES `fg_course_chapter` WRITE;
/*!40000 ALTER TABLE `fg_course_chapter` DISABLE KEYS */;
INSERT INTO `fg_course_chapter` VALUES (1,'Typescript基本安装',1,'2021-07-22 04:38:09.041729','2021-07-22 04:41:42.161135',0,1,'<p>Typescript基本安装，关于ts工具的使用，还有Typescript和javascript的关系。</p>','2021-07-22',1),(2,'Typescript的基本语法',1,'2021-07-22 04:38:31.263745','2021-07-22 04:41:51.762964',0,2,'<p>Typescript的基本语法</p>','2021-07-22',1),(3,'Typescript的运算符',1,'2021-07-22 04:38:31.263745','2021-07-22 04:41:51.762964',0,2,'<p>Typescript的运算符</p>','2021-07-22',1);
/*!40000 ALTER TABLE `fg_course_chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_course_direction`
--

DROP TABLE IF EXISTS `fg_course_direction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_course_direction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `remark` longtext,
  `recommend_home_hot` tinyint(1) NOT NULL,
  `recommend_home_top` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_course_direction`
--

LOCK TABLES `fg_course_direction` WRITE;
/*!40000 ALTER TABLE `fg_course_direction` DISABLE KEYS */;
INSERT INTO `fg_course_direction` VALUES (1,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'前端开发','',1,1),(2,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'后端开发','',1,1),(3,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'移动开发','',1,1),(4,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'计算机基础','',1,1),(5,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'前沿技术','',1,1),(6,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'云计算','',1,1),(7,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'大数据','',1,1),(8,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'运维','',1,1),(9,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'测试','',1,1),(10,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'数据库','',1,1),(11,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'UI设计','',1,1),(12,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'多媒体','',1,1),(13,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'游戏','',1,1),(14,1,1,'2021-07-22 05:42:01.290060','2021-07-22 05:42:01.290088',0,'求职面试','',1,1);
/*!40000 ALTER TABLE `fg_course_direction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_course_info`
--

DROP TABLE IF EXISTS `fg_course_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_course_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `course_cover` varchar(255) DEFAULT NULL,
  `course_video` varchar(255) DEFAULT NULL,
  `course_type` smallint NOT NULL,
  `level` smallint NOT NULL,
  `description` longtext,
  `pub_date` date NOT NULL,
  `period` int NOT NULL,
  `attachment_path` varchar(1000) DEFAULT NULL,
  `attachment_link` varchar(1000) DEFAULT NULL,
  `status` smallint NOT NULL,
  `students` int NOT NULL,
  `lessons` int NOT NULL,
  `pub_lessons` int NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `recommend_home_hot` tinyint(1) NOT NULL,
  `recommend_home_top` tinyint(1) NOT NULL,
  `category_id` bigint DEFAULT NULL,
  `direction_id` bigint DEFAULT NULL,
  `teacher_id` bigint DEFAULT NULL,
  `credit` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_course_info_teacher_id_cd3286b1_fk_fg_teacher_id` (`teacher_id`),
  KEY `fg_course_info_category_id_7b063318` (`category_id`),
  KEY `fg_course_info_direction_id_f6a1eac2` (`direction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_course_info`
--

LOCK TABLES `fg_course_info` WRITE;
/*!40000 ALTER TABLE `fg_course_info` DISABLE KEYS */;
INSERT INTO `fg_course_info` VALUES (1,'7天Typescript从入门到放弃',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:33:11.589464',0,'course/cover/course-10.png','course/video/1_SQjFjo9.mp4',0,0,'<p>7天Typescript从入门到放弃</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,1100,70,15,800.00,0,0,2,1,1,0),(2,'3天Typescript精修',1,1,'2021-07-22 04:35:05.696823','2021-07-22 04:35:05.696871',0,'course/cover/course-9.png','course/video/1.mp4',0,0,'<p>3天Typescript精修</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,9704,100,100,998.00,1,0,2,1,2,0),(3,'3天学会Vue基础',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:51:17.633423',0,'course/cover/course-8_6Lkjv4X.png','course/video/1.mp4',0,0,'<p>3天学会Vue基础</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,988,130,54,500.00,1,0,1,1,2,0),(4,'算法与数据结构体系课',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:39:46.301213',0,'course/cover/course-7_calnBgC.png','course/video/1.mp4',0,0,'<p>算法与数据结构体系课</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,1303,150,50,998.00,0,1,33,4,4,0),(5,'python基础入门',1,1,'2021-07-22 04:35:05.696823','2021-11-30 20:02:19.040001',0,'course/cover/course-6_ENGgiRe.png','course/video/1.mp4',0,0,'<p>python基础入门</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,4302,140,30,100.00,0,1,20,2,4,30),(6,'javascript进阶',1,1,'2021-07-22 04:35:05.696823','2021-12-01 19:44:29.542777',0,'course/cover/course-5_9qOHCqP.png','course/video/1.mp4',0,0,'<p>javascript进阶</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,1125,180,100,1750.00,1,0,5,1,3,10),(7,'爬虫进阶之逆向工程',1,1,'2021-07-22 04:35:05.696823','2021-07-22 04:35:05.696871',0,'course/cover/course-4.png','course/video/1.mp4',0,0,'<p>爬虫进阶之逆向工程</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,223,145,55,400.00,0,0,21,2,3,0),(8,'Kubernetes 入门到进阶实战',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:52:31.992879',0,'course/cover/course-3_hBxVaxM.png','course/video/1.mp4',0,0,'<p>Kubernetes 入门到进阶实战</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,6074,70,20,500.00,1,0,50,7,3,0),(9,'Android 应用程序构建实战',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:52:12.933429',0,'course/cover/course-2_3V4zDbX.png','course/video/1.mp4',0,0,'<p>Android 应用程序构建实战</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,1059,110,50,550.00,0,0,29,3,1,0),(10,'Kotlin从入门到精通',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:51:53.176736',0,'course/cover/course-1_hQRdjps.png','course/video/1.mp4',0,0,'<p>Kotlin从入门到精通</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,870,120,0,500.00,1,0,29,3,1,0),(11,'深度学习之神经网络',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:48:03.960088',0,'course/cover/course-11_JIfLQUS.png','course/video/1.mp4',0,0,'<p>深度学习之神经网络</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,6002,115,70,80.00,1,0,37,5,1,0),(12,'OpenCV入门到进阶',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:48:28.617369',0,'course/cover/course-12_6SL3iDg.png','course/video/1.mp4',0,0,'<p>OpenCV入门到进阶</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,1029,100,70,390.00,0,1,38,5,2,0),(13,'Go容器化微服务系统实战',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:50:12.499780',0,'course/cover/course-13_E2Ky2cH.png','course/video/1.mp4',0,0,'<p>Go容器化微服务系统实战</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,24202,65,65,399.00,0,0,35,5,1,0),(14,'RabbitMQ精讲',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:50:48.447489',0,'course/cover/course-14_s5LhQQx.png','course/video/1.mp4',0,0,'<p>RabbitMQ精讲</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,980,100,100,710.00,0,0,53,8,4,0),(15,'TensorFlow基础',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:50:29.529479',0,'course/cover/course-15_p29X942.png','course/video/1.mp4',0,0,'<p>RabbitMQ精讲</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,670,220,100,1590.00,0,1,36,5,2,0),(16,'ZooKeeper分布式架构搭建',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:49:55.615346',0,'course/cover/course-16_iebWpvu.png','course/video/1.mp4',0,0,'<p>ZooKeeper分布式架构搭建</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,90,88,35,40.00,1,0,35,5,3,0),(17,'高性能MySQL调优',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:49:39.563224',0,'course/cover/course-17_OOfj80G.png','course/video/1.mp4',0,0,'<p>高性能MySQL调优</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,40,300,60,998.00,1,1,60,10,3,0),(18,'MySQL事务处理精选',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:49:23.765130',0,'course/cover/course-18_CPT8iHm.png','course/video/1.mp4',0,0,'<p>MySQL事务处理精选</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,640,65,30,1000.00,1,0,60,10,1,0),(19,'MongoDB入门到进阶',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:49:06.325898',0,'course/cover/course-19_FkMUEdL.png','',0,0,'<p>MongoDB入门到进阶</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,11205,86,40,1100.00,0,1,62,10,3,0),(20,'Redis入门课程',1,1,'2021-07-22 04:35:05.696823','2021-11-24 06:48:48.238416',0,'course/cover/course-20_zyfEVgq.png','',0,0,'<p>Redis入门课程</p>','2021-07-22',7,'fuguang-celery用法1.zip',NULL,0,120,100,40,1199.00,1,1,61,10,2,0);
/*!40000 ALTER TABLE `fg_course_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_course_lesson`
--

DROP TABLE IF EXISTS `fg_course_lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_course_lesson` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `orders` smallint NOT NULL,
  `lesson_type` smallint NOT NULL,
  `lesson_link` varchar(255) DEFAULT NULL,
  `duration` varchar(32) DEFAULT NULL,
  `pub_date` datetime(6) NOT NULL,
  `free_trail` tinyint(1) NOT NULL,
  `recommend` tinyint(1) NOT NULL,
  `chapter_id` bigint NOT NULL,
  `course_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_courselesson_chapter_id_4dee6218` (`chapter_id`),
  KEY `courses_courselesson_course_id_76619dc9` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_course_lesson`
--

LOCK TABLES `fg_course_lesson` WRITE;
/*!40000 ALTER TABLE `fg_course_lesson` DISABLE KEYS */;
INSERT INTO `fg_course_lesson` VALUES (1,'Typescript的基本介绍',1,'2021-07-22 04:42:13.965045','2021-12-03 20:02:50.355244',0,1,2,'94a61789796d49a018b42e8bc0a22997_9','17:30','2021-07-22 04:42:13.965195',1,0,1,1),(2,'Typescript的变量和常量',1,'2021-11-24 08:30:54.906787','2021-11-24 08:30:54.906832',0,1,2,'94a61789796d49a018b42e8bc0a22997_9','15:00','2021-11-24 08:30:54.906860',0,1,2,1),(3,'Typescript的抽象类',1,'2021-11-24 08:30:54.906787','2021-11-24 08:30:54.906832',0,1,2,'94a617897925c936f4cf1f0cf3d11fb6_9','15:00','2021-11-24 08:30:54.906860',0,1,2,1),(4,'Typescript的装饰器',1,'2021-11-24 08:30:54.906787','2021-11-24 08:30:54.906832',0,1,2,'94a6178979817ee155903e2d607250c8_9','15:00','2021-11-24 08:30:54.906860',0,1,2,1);
/*!40000 ALTER TABLE `fg_course_lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_credit`
--

DROP TABLE IF EXISTS `fg_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_credit` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `operation` smallint NOT NULL,
  `number` int NOT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_credit_user_id_6e68adcc` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_credit`
--

LOCK TABLES `fg_credit` WRITE;
/*!40000 ALTER TABLE `fg_credit` DISABLE KEYS */;
INSERT INTO `fg_credit` VALUES (1,'',0,1,'2021-11-30 15:24:58.732344','2021-11-30 15:24:58.732538',0,2,100,NULL,1),(2,'',0,1,'2021-11-30 15:26:08.528248','2021-11-30 15:26:08.528279',0,2,-50,NULL,1),(3,'',0,1,'2021-11-30 20:04:11.483858','2021-11-30 20:04:11.483919',0,2,500,NULL,1),(4,'',0,1,'2021-12-01 16:53:41.025582','2021-12-01 16:53:41.025634',0,1,30,NULL,1),(5,'',0,1,'2021-12-01 20:10:25.565200','2021-12-01 20:10:25.565280',0,1,30,NULL,1),(6,'',0,1,'2021-12-02 10:48:55.533484','2021-12-02 10:48:55.533534',0,2,500,NULL,1);
/*!40000 ALTER TABLE `fg_credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_discount`
--

DROP TABLE IF EXISTS `fg_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_discount` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `condition` int NOT NULL,
  `sale` longtext NOT NULL,
  `discount_type_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_discount_discount_type_id_7da0560e` (`discount_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_discount`
--

LOCK TABLES `fg_discount` WRITE;
/*!40000 ALTER TABLE `fg_discount` DISABLE KEYS */;
INSERT INTO `fg_discount` VALUES (1,'免费购买',1,1,'2021-07-29 10:45:54.027034','2021-07-29 10:45:54.027079',0,0,'0',4),(2,'九折折扣',1,1,'2021-07-29 10:47:12.855454','2021-07-29 11:32:27.148655',0,1,'*0.9',2),(3,'课程减免100',1,1,'2021-07-29 11:40:44.499026','2021-07-29 11:40:44.499060',0,300,'-100',3);
/*!40000 ALTER TABLE `fg_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_discount_type`
--

DROP TABLE IF EXISTS `fg_discount_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_discount_type` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `remark` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_discount_type`
--

LOCK TABLES `fg_discount_type` WRITE;
/*!40000 ALTER TABLE `fg_discount_type` DISABLE KEYS */;
INSERT INTO `fg_discount_type` VALUES (1,'免费',1,1,'2021-07-29 10:43:38.546870','2021-07-29 10:43:38.546901',0,NULL),(2,'折扣',1,1,'2021-07-29 10:43:49.161997','2021-07-29 11:19:58.799363',0,NULL),(3,'减免',1,1,'2021-07-29 10:44:05.712935','2021-07-29 11:41:16.504340',0,NULL),(4,'限时免费',1,1,'2021-07-29 10:44:23.053845','2021-07-29 10:44:23.053925',0,NULL),(5,'限时折扣',1,1,'2021-07-29 10:44:31.999352','2021-07-29 10:44:31.999382',0,NULL),(6,'限时减免',1,1,'2021-07-29 10:44:39.100270','2021-07-29 10:44:39.100305',0,NULL);
/*!40000 ALTER TABLE `fg_discount_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_nav`
--

DROP TABLE IF EXISTS `fg_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_nav` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `link` varchar(255) NOT NULL,
  `is_http` tinyint(1) NOT NULL,
  `position` smallint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_nav`
--

LOCK TABLES `fg_nav` WRITE;
/*!40000 ALTER TABLE `fg_nav` DISABLE KEYS */;
INSERT INTO `fg_nav` VALUES (1,'免费课',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/free',0,0),(2,'项目课',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/project',0,0),(3,'学位课',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/position',0,0),(4,'习题库',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/exam',0,0),(5,'老男孩教育',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'http://www.oldboyedu.com',1,0),(6,'企业服务',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/free',0,1),(7,'关于我们',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/free',0,1),(8,'联系我们',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/free',0,1),(9,'商务合作',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/free',0,1),(10,'帮助中心',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/free',0,1),(11,'意见反馈',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/free',0,1),(12,'新手指南',1,1,'2021-07-15 01:27:27.350000','2021-07-15 01:27:28.690000',0,'/free',0,1);
/*!40000 ALTER TABLE `fg_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_order`
--

DROP TABLE IF EXISTS `fg_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `real_price` decimal(10,2) NOT NULL,
  `order_number` varchar(64) NOT NULL,
  `order_status` smallint NOT NULL,
  `pay_type` smallint NOT NULL,
  `order_desc` longtext,
  `pay_time` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `credit` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_order_user_id_7573cf51` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_order`
--

LOCK TABLES `fg_order` WRITE;
/*!40000 ALTER TABLE `fg_order` DISABLE KEYS */;
INSERT INTO `fg_order` VALUES (13,'购买课程',0,1,'2021-11-26 19:02:27.644035','2021-12-02 20:10:55.814423',0,3280.00,3180.00,'202111260000000100000013',2,0,NULL,NULL,1,0),(16,'购买课程',0,1,'2021-11-26 23:34:42.071733','2021-12-02 20:10:50.018918',0,3696.00,3496.20,'202111260000000100000016',2,0,NULL,NULL,1,0),(17,'购买课程',0,1,'2021-11-26 23:35:29.000048','2021-12-02 20:10:46.096700',0,998.00,998.00,'202111260000000100000017',2,0,NULL,NULL,1,0),(18,'购买课程',0,1,'2021-11-26 23:35:52.944134','2021-11-26 23:35:52.961005',0,998.00,998.00,'202111260000000100000018',0,0,NULL,NULL,1,0),(19,'购买课程',0,1,'2021-11-26 23:36:09.091298','2021-11-26 23:36:09.123775',0,800.00,800.00,'202111260000000100000019',0,0,NULL,NULL,1,0),(28,'购买课程',0,1,'2021-11-29 21:31:30.440436','2021-11-29 21:31:30.676234',0,3296.00,3096.20,'202111290000000100000028',0,0,NULL,NULL,1,0),(29,'购买课程',0,1,'2021-11-30 08:46:47.669897','2021-11-30 08:46:47.848030',0,1300.00,1200.00,'202111300000000100000029',0,0,NULL,NULL,1,0),(30,'购买课程',0,1,'2021-11-30 17:42:35.907471','2021-11-30 17:42:36.069053',0,2646.00,2546.20,'202111300000000100000030',0,0,NULL,NULL,1,30),(31,'购买课程',0,1,'2021-11-30 19:52:14.760704','2021-11-30 19:52:14.925361',0,2596.00,2396.20,'202111300000000100000031',0,0,NULL,NULL,1,20),(32,'购买课程',0,1,'2021-11-30 20:04:47.124506','2021-11-30 20:04:47.269992',0,1100.00,1000.00,'202111300000000100000032',0,0,NULL,NULL,1,30),(33,'购买课程',0,1,'2021-11-30 20:09:49.010252','2021-11-30 20:09:49.217603',0,2398.00,2198.20,'202111300000000100000033',0,0,NULL,NULL,1,30),(34,'购买课程',0,1,'2021-11-30 21:00:01.103851','2021-11-30 21:00:01.301227',0,1898.00,1895.00,'202111300000000100000034',0,0,NULL,NULL,1,30),(35,'购买课程',0,1,'2021-11-30 21:38:07.197403','2021-11-30 21:38:07.343350',0,2896.00,2793.20,'202111300000000100000035',0,0,NULL,NULL,1,30),(36,'购买课程',0,1,'2021-11-30 22:30:13.017033','2021-11-30 22:30:13.142308',0,2398.00,2295.00,'202111300000000100000036',0,0,NULL,NULL,1,30),(37,'购买课程',0,1,'2021-11-30 23:48:58.891945','2021-11-30 23:48:58.980770',0,1898.00,1795.20,'202111300000000100000037',0,0,NULL,NULL,1,30),(38,'购买课程',0,1,'2021-11-30 23:54:17.642447','2021-11-30 23:54:17.717903',0,1400.00,1297.00,'202111300000000100000038',0,0,NULL,NULL,1,30),(39,'购买课程',0,1,'2021-12-01 00:01:37.986826','2021-12-01 00:01:38.030817',0,900.00,897.00,'202112010000000100000039',0,0,NULL,NULL,1,30),(40,'购买课程',0,1,'2021-12-01 00:04:24.448707','2021-12-01 00:04:24.485648',0,900.00,897.00,'202112010000000100000040',0,0,NULL,NULL,1,30),(41,'购买课程',0,1,'2021-12-01 00:09:50.737441','2021-12-01 00:09:50.776017',0,900.00,897.00,'202112010000000100000041',0,0,NULL,NULL,1,30),(42,'购买课程',0,1,'2021-12-01 00:32:35.600523','2021-12-01 00:32:35.641452',0,800.00,800.00,'202112010000000100000042',0,0,NULL,NULL,1,0),(43,'购买课程',0,1,'2021-12-01 00:40:47.126670','2021-12-01 00:40:47.159325',0,0.00,0.00,'202112010000000100000043',0,0,NULL,NULL,1,0),(44,'购买课程',0,1,'2021-12-01 00:41:28.082437','2021-12-01 00:41:28.126140',0,0.00,0.00,'202112010000000100000044',0,0,NULL,NULL,1,30),(45,'购买课程',0,1,'2021-12-01 15:02:32.818925','2021-12-01 15:02:33.010450',0,1400.00,1297.00,'202112010000000100000045',0,0,NULL,NULL,1,30),(46,'购买课程',0,1,'2021-12-01 16:44:40.461608','2021-12-01 16:44:40.598322',0,1400.00,1297.00,'202112010000000100000046',0,0,NULL,NULL,1,30),(47,'购买课程',0,1,'2021-12-01 16:47:11.597529','2021-12-01 16:47:11.874869',0,1400.00,1297.00,'202112010000000100000048',0,0,NULL,NULL,1,30),(52,'购买课程',0,1,'2021-12-01 20:08:24.410845','2021-12-01 20:10:25.536033',0,900.00,897.00,'202112010000000100000052',1,0,NULL,'2021-12-01 20:10:25.533745',1,30),(53,'购买课程',0,1,'2021-12-02 10:47:36.241192','2021-12-02 10:47:36.330355',0,900.00,898.00,'202112020000000100000053',0,0,NULL,NULL,1,20),(54,'购买课程',0,1,'2021-12-02 11:33:22.995760','2021-12-02 20:13:55.638238',0,900.00,897.00,'202112020000000100000054',2,0,NULL,NULL,1,30),(55,'购买课程',0,1,'2021-12-02 11:34:56.318978','2021-12-02 11:34:56.382979',0,900.00,900.00,'202112020000000100000055',0,0,NULL,NULL,1,0),(56,'购买课程',0,1,'2021-12-02 11:40:05.828978','2021-12-02 11:40:05.914667',0,800.00,800.00,'202112020000000100000056',0,0,NULL,NULL,1,0),(57,'购买课程',0,1,'2021-12-02 11:50:49.443063','2021-12-02 11:50:49.566754',0,900.00,900.00,'202112020000000100000057',0,0,NULL,NULL,1,0),(58,'购买课程',0,1,'2021-12-02 11:51:43.285406','2021-12-02 11:51:43.363637',0,900.00,900.00,'202112020000000100000058',0,0,NULL,NULL,1,0),(59,'购买课程',0,1,'2021-12-02 11:54:36.965281','2021-12-03 19:45:28.529086',0,900.00,900.00,'202112020000000100000059',2,0,NULL,NULL,1,0),(60,'购买课程',0,1,'2021-12-02 12:02:13.994544','2021-12-02 20:15:55.226065',0,900.00,101.00,'202112020000000100000060',2,0,NULL,NULL,1,0),(61,'购买课程',0,1,'2021-12-02 17:14:42.636427','2021-12-03 19:45:30.729025',0,900.00,100.01,'202112020000000100000061',2,0,NULL,NULL,1,0),(62,'购买课程',0,1,'2021-12-02 19:27:38.074512','2021-12-02 19:27:38.172818',0,1798.00,898.21,'202112020000000100000062',0,0,NULL,NULL,1,0),(63,'购买课程',0,1,'2021-12-02 19:30:16.020730','2021-12-02 19:30:16.087440',0,1798.00,1698.20,'202112020000000100000063',0,0,NULL,NULL,1,0),(64,'购买课程',0,1,'2021-12-02 19:33:54.221138','2021-12-02 20:35:02.264744',0,1798.00,898.20,'202112020000000100000064',1,0,NULL,'2021-12-02 20:35:02.264398',1,0),(65,'购买课程',0,1,'2021-12-02 21:25:46.383492','2021-12-03 19:44:37.724833',0,500.00,400.00,'202112020000000100000065',1,0,NULL,'2021-12-03 19:44:37.724231',1,0),(66,'购买课程',0,1,'2021-12-02 22:10:25.034003','2021-12-03 18:42:50.550706',0,998.00,998.00,'202112020000000100000066',2,0,NULL,NULL,1,0),(67,'购买课程',0,1,'2021-12-02 22:31:19.263035','2021-12-02 22:42:25.284878',0,500.00,400.00,'202112020000000100000067',2,0,NULL,NULL,1,0),(68,'购买课程',0,1,'2021-12-02 22:49:09.448772','2021-12-02 22:49:25.334448',0,998.00,998.00,'202112020000000100000068',3,0,NULL,NULL,1,0),(69,'购买课程',0,1,'2021-12-03 18:28:04.562974','2021-12-03 18:28:40.172488',0,1750.00,0.00,'202112030000000100000069',3,0,NULL,NULL,1,0),(70,'购买课程',0,1,'2021-12-03 18:28:39.801863','2021-12-03 18:28:55.441072',0,1750.00,0.00,'202112030000000100000070',3,0,NULL,NULL,1,0),(71,'购买课程',0,1,'2021-12-03 18:40:44.126845','2021-12-03 18:41:00.021391',0,1850.00,-1.00,'202112030000000100000071',3,0,NULL,NULL,1,10),(72,'购买课程',0,1,'2021-12-03 18:43:10.791164','2021-12-03 18:58:11.145895',0,1850.00,0.00,'202112030000000100000072',3,0,NULL,NULL,1,0),(73,'购买课程',0,1,'2021-12-03 18:43:31.885086','2021-12-03 18:58:32.293794',0,1750.00,0.00,'202112030000000100000073',3,0,NULL,NULL,1,0),(74,'购买课程',0,1,'2021-12-03 18:43:52.261622','2021-12-03 18:58:52.325504',0,100.00,100.00,'202112030000000100000074',3,0,NULL,NULL,1,0),(75,'购买课程',0,1,'2021-12-03 18:46:31.995838','2021-12-03 19:01:32.753833',0,2250.00,500.00,'202112030000000100000075',3,0,NULL,NULL,1,0),(76,'购买课程',0,1,'2021-12-03 18:46:55.837148','2021-12-03 19:02:33.933854',0,1750.00,0.00,'202112030000000100000076',3,0,NULL,NULL,1,0),(77,'购买课程',0,1,'2021-12-03 18:47:23.998657','2021-12-03 19:02:33.938454',0,2150.00,400.00,'202112030000000100000077',3,0,NULL,NULL,1,0),(78,'购买课程',0,1,'2021-12-03 19:00:02.491907','2021-12-03 19:15:02.741775',0,2150.00,400.00,'202112030000000100000078',3,0,NULL,NULL,1,0),(79,'购买课程',0,1,'2021-12-03 19:01:09.263522','2021-12-03 19:16:12.480518',0,1750.00,0.00,'202112030000000100000079',3,0,NULL,NULL,1,0),(80,'购买课程',0,1,'2021-12-03 19:11:09.475207','2021-12-03 19:26:10.296271',0,1750.00,0.00,'202112030000000100000080',3,0,NULL,NULL,1,0),(81,'购买课程',0,1,'2021-12-03 19:17:27.429654','2021-12-03 19:32:28.357901',0,1750.00,0.00,'202112030000000100000081',3,0,NULL,NULL,1,0),(82,'购买课程',0,1,'2021-12-03 19:22:04.050559','2021-12-03 19:37:04.567997',0,1750.00,0.00,'202112030000000100000082',3,0,NULL,NULL,1,0),(83,'购买课程',0,1,'2021-12-03 19:23:25.713419','2021-12-03 19:38:55.441891',0,1750.00,0.00,'202112030000000100000083',3,0,NULL,NULL,1,0),(84,'购买课程',0,1,'2021-12-03 19:24:50.085260','2021-12-03 19:39:50.285855',0,1750.00,0.00,'202112030000000100000084',3,0,NULL,NULL,1,0),(85,'购买课程',0,1,'2021-12-03 19:26:16.649757','2021-12-03 19:41:17.929605',0,1750.00,0.00,'202112030000000100000085',3,0,NULL,NULL,1,0),(86,'购买课程',0,1,'2021-12-03 19:27:11.610205','2021-12-03 19:42:12.013717',0,1750.00,0.00,'202112030000000100000086',3,0,NULL,NULL,1,0),(87,'购买课程',0,1,'2021-12-03 19:28:36.504438','2021-12-03 19:43:36.724902',0,1750.00,0.00,'202112030000000100000087',3,0,NULL,NULL,1,0),(88,'购买课程',0,1,'2021-12-03 19:34:37.105806','2021-12-03 19:43:47.989578',0,1750.00,0.00,'202112030000000100000088',2,0,NULL,NULL,1,0),(89,'购买课程',0,1,'2021-12-03 19:38:26.749693','2021-12-03 19:43:46.463864',0,1750.00,0.00,'202112030000000100000089',2,0,NULL,NULL,1,0),(90,'购买课程',0,1,'2021-12-03 19:40:47.719480','2021-12-03 19:43:44.894238',0,1750.00,0.00,'202112030000000100000090',2,0,NULL,NULL,1,0),(91,'购买课程',0,1,'2021-12-03 19:45:45.240941','2021-12-03 19:46:24.871193',0,500.00,500.00,'202112030000000100000091',1,0,NULL,'2021-12-03 19:46:24.870868',1,0),(92,'购买课程',0,1,'2021-12-03 19:46:56.555854','2021-12-03 20:01:57.359665',0,998.00,998.00,'202112030000000100000092',3,0,NULL,NULL,1,0),(93,'购买课程',0,1,'2021-12-03 19:48:03.992488','2021-12-03 19:48:40.631697',0,998.00,998.00,'202112030000000100000093',1,0,NULL,'2021-12-03 19:48:40.631012',1,0),(94,'购买课程',0,1,'2021-12-03 19:49:07.662530','2021-12-03 19:49:52.214684',0,100.00,100.00,'202112030000000100000094',1,0,NULL,'2021-12-03 19:49:52.214266',1,0);
/*!40000 ALTER TABLE `fg_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_order_course`
--

DROP TABLE IF EXISTS `fg_order_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_order_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `real_price` decimal(10,2) NOT NULL,
  `discount_name` varchar(120) NOT NULL,
  `course_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_order_course_course_id_c16cb315` (`course_id`),
  KEY `fg_order_course_order_id_e4bf1bb5` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_order_course`
--

LOCK TABLES `fg_order_course` WRITE;
/*!40000 ALTER TABLE `fg_order_course` DISABLE KEYS */;
INSERT INTO `fg_order_course` VALUES (49,'7天Typescript从入门到放弃',0,1,'2021-11-26 19:02:27.760481','2021-11-26 19:02:27.760510',0,800.00,0.00,'限时免费',1,13),(50,'3天学会Vue基础',0,1,'2021-11-26 19:02:27.760572','2021-11-26 19:02:27.760581',0,500.00,400.00,'减免',3,13),(51,'OpenCV入门到进阶',0,1,'2021-11-26 19:02:27.760610','2021-11-26 19:02:27.760617',0,390.00,0.00,'',12,13),(52,'TensorFlow基础',0,1,'2021-11-26 19:02:27.760642','2021-11-26 19:02:27.760648',0,1590.00,0.00,'',15,13),(63,'7天Typescript从入门到放弃',0,1,'2021-11-26 23:34:42.177753','2021-11-26 23:34:42.177784',0,800.00,0.00,'限时免费',1,16),(64,'3天Typescript精修',0,1,'2021-11-26 23:34:42.177856','2021-11-26 23:34:42.177865',0,998.00,898.20,'折扣',2,16),(65,'3天学会Vue基础',0,1,'2021-11-26 23:34:42.177913','2021-11-26 23:34:42.177921',0,500.00,400.00,'减免',3,16),(66,'算法与数据结构体系课',0,1,'2021-11-26 23:34:42.177947','2021-11-26 23:34:42.177954',0,998.00,0.00,'',4,16),(67,'爬虫进阶之逆向工程',0,1,'2021-11-26 23:34:42.177978','2021-11-26 23:34:42.177984',0,400.00,0.00,'',7,16),(68,'算法与数据结构体系课',0,1,'2021-11-26 23:35:29.023864','2021-11-26 23:35:29.023915',0,998.00,0.00,'',4,17),(69,'算法与数据结构体系课',0,1,'2021-11-26 23:35:52.959293','2021-11-26 23:35:52.959326',0,998.00,0.00,'',4,18),(70,'7天Typescript从入门到放弃',0,1,'2021-11-26 23:36:09.120946','2021-11-26 23:36:09.120997',0,800.00,0.00,'限时免费',1,19),(101,'7天Typescript从入门到放弃',0,1,'2021-11-29 21:31:30.664595','2021-11-29 21:31:30.664658',0,800.00,0.00,'限时免费',1,28),(102,'3天Typescript精修',0,1,'2021-11-29 21:31:30.664878','2021-11-29 21:31:30.664910',0,998.00,898.20,'折扣',2,28),(103,'3天学会Vue基础',0,1,'2021-11-29 21:31:30.664998','2021-11-29 21:31:30.665017',0,500.00,400.00,'减免',3,28),(104,'算法与数据结构体系课',0,1,'2021-11-29 21:31:30.665137','2021-11-29 21:31:30.665161',0,998.00,0.00,'',4,28),(105,'7天Typescript从入门到放弃',0,1,'2021-11-30 08:46:47.817415','2021-11-30 08:46:47.817438',0,800.00,0.00,'限时免费',1,29),(106,'3天学会Vue基础',0,1,'2021-11-30 08:46:47.817492','2021-11-30 08:46:47.817522',0,500.00,400.00,'减免',3,29),(107,'3天Typescript精修',0,1,'2021-11-30 17:42:36.060118','2021-11-30 17:42:36.060147',0,998.00,898.20,'折扣',2,30),(108,'算法与数据结构体系课',0,1,'2021-11-30 17:42:36.060320','2021-11-30 17:42:36.060335',0,998.00,0.00,'',4,30),(109,'python基础入门',0,1,'2021-11-30 17:42:36.060364','2021-11-30 17:42:36.060371',0,100.00,0.00,'',5,30),(110,'Android 应用程序构建实战',0,1,'2021-11-30 17:42:36.060395','2021-11-30 17:42:36.060401',0,550.00,0.00,'',9,30),(111,'3天Typescript精修',0,1,'2021-11-30 19:52:14.917550','2021-11-30 19:52:14.917584',0,998.00,898.20,'折扣',2,31),(112,'3天学会Vue基础',0,1,'2021-11-30 19:52:14.918121','2021-11-30 19:52:14.918151',0,500.00,400.00,'减免',3,31),(113,'算法与数据结构体系课',0,1,'2021-11-30 19:52:14.918312','2021-11-30 19:52:14.918346',0,998.00,0.00,'',4,31),(114,'python基础入门',0,1,'2021-11-30 19:52:14.918558','2021-11-30 19:52:14.918583',0,100.00,0.00,'',5,31),(115,'3天学会Vue基础',0,1,'2021-11-30 20:04:47.263026','2021-11-30 20:04:47.263057',0,500.00,400.00,'减免',3,32),(116,'python基础入门',0,1,'2021-11-30 20:04:47.263542','2021-11-30 20:04:47.263584',0,100.00,0.00,'',5,32),(117,'Kubernetes 入门到进阶实战',0,1,'2021-11-30 20:04:47.263667','2021-11-30 20:04:47.263683',0,500.00,0.00,'',8,32),(118,'7天Typescript从入门到放弃',0,1,'2021-11-30 20:09:49.183488','2021-11-30 20:09:49.183532',0,800.00,0.00,'限时免费',1,33),(119,'3天Typescript精修',0,1,'2021-11-30 20:09:49.183622','2021-11-30 20:09:49.183635',0,998.00,898.20,'折扣',2,33),(120,'3天学会Vue基础',0,1,'2021-11-30 20:09:49.183840','2021-11-30 20:09:49.183869',0,500.00,400.00,'减免',3,33),(121,'python基础入门',0,1,'2021-11-30 20:09:49.183926','2021-11-30 20:09:49.183941',0,100.00,0.00,'',5,33),(122,'7天Typescript从入门到放弃',0,1,'2021-11-30 21:00:01.287912','2021-11-30 21:00:01.287970',0,800.00,0.00,'限时免费',1,34),(123,'算法与数据结构体系课',0,1,'2021-11-30 21:00:01.289394','2021-11-30 21:00:01.289545',0,998.00,0.00,'',4,34),(124,'python基础入门',0,1,'2021-11-30 21:00:01.289695','2021-11-30 21:00:01.289722',0,100.00,0.00,'',5,34),(125,'7天Typescript从入门到放弃',0,1,'2021-11-30 21:38:07.337481','2021-11-30 21:38:07.337530',0,800.00,0.00,'限时免费',1,35),(126,'3天Typescript精修',0,1,'2021-11-30 21:38:07.337680','2021-11-30 21:38:07.337698',0,998.00,898.20,'折扣',2,35),(127,'算法与数据结构体系课',0,1,'2021-11-30 21:38:07.337784','2021-11-30 21:38:07.337802',0,998.00,0.00,'',4,35),(128,'python基础入门',0,1,'2021-11-30 21:38:07.337973','2021-11-30 21:38:07.338006',0,100.00,0.00,'',5,35),(129,'7天Typescript从入门到放弃',0,1,'2021-11-30 22:30:13.132890','2021-11-30 22:30:13.132922',0,800.00,0.00,'限时免费',1,36),(130,'3天学会Vue基础',0,1,'2021-11-30 22:30:13.132989','2021-11-30 22:30:13.133000',0,500.00,400.00,'减免',3,36),(131,'算法与数据结构体系课',0,1,'2021-11-30 22:30:13.133038','2021-11-30 22:30:13.133046',0,998.00,0.00,'',4,36),(132,'python基础入门',0,1,'2021-11-30 22:30:13.133079','2021-11-30 22:30:13.133088',0,100.00,0.00,'',5,36),(133,'7天Typescript从入门到放弃',0,1,'2021-11-30 23:48:58.976513','2021-11-30 23:48:58.976541',0,800.00,0.00,'限时免费',1,37),(134,'3天Typescript精修',0,1,'2021-11-30 23:48:58.976598','2021-11-30 23:48:58.976605',0,998.00,898.20,'折扣',2,37),(135,'python基础入门',0,1,'2021-11-30 23:48:58.976637','2021-11-30 23:48:58.976644',0,100.00,0.00,'',5,37),(136,'7天Typescript从入门到放弃',0,1,'2021-11-30 23:54:17.715672','2021-11-30 23:54:17.715745',0,800.00,0.00,'限时免费',1,38),(137,'3天学会Vue基础',0,1,'2021-11-30 23:54:17.715900','2021-11-30 23:54:17.715925',0,500.00,400.00,'减免',3,38),(138,'python基础入门',0,1,'2021-11-30 23:54:17.716064','2021-11-30 23:54:17.716081',0,100.00,0.00,'',5,38),(139,'7天Typescript从入门到放弃',0,1,'2021-12-01 00:01:38.028921','2021-12-01 00:01:38.028949',0,800.00,0.00,'限时免费',1,39),(140,'python基础入门',0,1,'2021-12-01 00:01:38.029177','2021-12-01 00:01:38.029201',0,100.00,0.00,'',5,39),(141,'7天Typescript从入门到放弃',0,1,'2021-12-01 00:04:24.483556','2021-12-01 00:04:24.483649',0,800.00,0.00,'限时免费',1,40),(142,'python基础入门',0,1,'2021-12-01 00:04:24.483821','2021-12-01 00:04:24.483850',0,100.00,0.00,'',5,40),(143,'7天Typescript从入门到放弃',0,1,'2021-12-01 00:09:50.774488','2021-12-01 00:09:50.774516',0,800.00,0.00,'限时免费',1,41),(144,'python基础入门',0,1,'2021-12-01 00:09:50.774579','2021-12-01 00:09:50.774587',0,100.00,0.00,'',5,41),(145,'7天Typescript从入门到放弃',0,1,'2021-12-01 00:32:35.640082','2021-12-01 00:32:35.640111',0,800.00,0.00,'限时免费',1,42),(146,'7天Typescript从入门到放弃',0,1,'2021-12-01 00:40:47.157154','2021-12-01 00:40:47.157181',0,800.00,0.00,'限时免费',1,43),(147,'7天Typescript从入门到放弃',0,1,'2021-12-01 00:41:28.124499','2021-12-01 00:41:28.124531',0,800.00,0.00,'限时免费',1,44),(148,'python基础入门',0,1,'2021-12-01 00:41:28.124588','2021-12-01 00:41:28.124596',0,100.00,0.00,'',5,44),(149,'7天Typescript从入门到放弃',0,1,'2021-12-01 15:02:32.976266','2021-12-01 15:02:32.976299',0,800.00,0.00,'限时免费',1,45),(150,'3天学会Vue基础',0,1,'2021-12-01 15:02:32.976398','2021-12-01 15:02:32.976418',0,500.00,400.00,'减免',3,45),(151,'python基础入门',0,1,'2021-12-01 15:02:32.976487','2021-12-01 15:02:32.976507',0,100.00,0.00,'',5,45),(152,'7天Typescript从入门到放弃',0,1,'2021-12-01 16:44:40.595481','2021-12-01 16:44:40.595519',0,800.00,0.00,'限时免费',1,46),(153,'3天学会Vue基础',0,1,'2021-12-01 16:44:40.595641','2021-12-01 16:44:40.595665',0,500.00,400.00,'减免',3,46),(154,'python基础入门',0,1,'2021-12-01 16:44:40.595741','2021-12-01 16:44:40.595759',0,100.00,0.00,'',5,46),(158,'7天Typescript从入门到放弃',0,1,'2021-12-01 16:47:11.867590','2021-12-01 16:47:11.867617',0,800.00,0.00,'限时免费',1,47),(159,'3天学会Vue基础',0,1,'2021-12-01 16:47:11.867666','2021-12-01 16:47:11.867673',0,500.00,400.00,'减免',3,47),(160,'python基础入门',0,1,'2021-12-01 16:47:11.867701','2021-12-01 16:47:11.867707',0,100.00,0.00,'',5,47),(166,'7天Typescript从入门到放弃',0,1,'2021-12-01 20:08:24.553576','2021-12-01 20:08:24.553619',0,800.00,0.00,'限时免费',1,52),(167,'python基础入门',0,1,'2021-12-01 20:08:24.553738','2021-12-01 20:08:24.553758',0,100.00,0.00,'',5,52),(168,'7天Typescript从入门到放弃',0,1,'2021-12-02 10:47:36.316719','2021-12-02 10:47:36.316764',0,800.00,0.00,'限时免费',1,53),(169,'python基础入门',0,1,'2021-12-02 10:47:36.316850','2021-12-02 10:47:36.316858',0,100.00,100.00,'',5,53),(170,'7天Typescript从入门到放弃',0,1,'2021-12-02 11:33:23.058799','2021-12-02 11:33:23.058827',0,800.00,0.00,'限时免费',1,54),(171,'python基础入门',0,1,'2021-12-02 11:33:23.059039','2021-12-02 11:33:23.059058',0,100.00,100.00,'',5,54),(172,'7天Typescript从入门到放弃',0,1,'2021-12-02 11:34:56.381085','2021-12-02 11:34:56.381119',0,800.00,0.00,'限时免费',1,55),(173,'python基础入门',0,1,'2021-12-02 11:34:56.381209','2021-12-02 11:34:56.381219',0,100.00,100.00,'',5,55),(174,'7天Typescript从入门到放弃',0,1,'2021-12-02 11:40:05.910440','2021-12-02 11:40:05.910497',0,800.00,0.00,'限时免费',1,56),(175,'7天Typescript从入门到放弃',0,1,'2021-12-02 11:50:49.561875','2021-12-02 11:50:49.561903',0,800.00,0.00,'限时免费',1,57),(176,'python基础入门',0,1,'2021-12-02 11:50:49.561975','2021-12-02 11:50:49.561984',0,100.00,100.00,'',5,57),(177,'7天Typescript从入门到放弃',0,1,'2021-12-02 11:51:43.342057','2021-12-02 11:51:43.342085',0,800.00,0.00,'限时免费',1,58),(178,'python基础入门',0,1,'2021-12-02 11:51:43.342155','2021-12-02 11:51:43.342163',0,100.00,100.00,'',5,58),(179,'7天Typescript从入门到放弃',0,1,'2021-12-02 11:54:37.053210','2021-12-02 11:54:37.053965',0,800.00,0.00,'限时免费',1,59),(180,'python基础入门',0,1,'2021-12-02 11:54:37.054188','2021-12-02 11:54:37.054219',0,100.00,0.00,'',5,59),(181,'7天Typescript从入门到放弃',0,1,'2021-12-02 12:02:14.042493','2021-12-02 12:02:14.042522',0,800.00,1.00,'限时免费',1,60),(182,'python基础入门',0,1,'2021-12-02 12:02:14.042587','2021-12-02 12:02:14.042595',0,100.00,0.00,'',5,60),(183,'7天Typescript从入门到放弃',0,1,'2021-12-02 17:14:42.807721','2021-12-02 17:14:42.807767',0,800.00,0.01,'限时免费',1,61),(184,'python基础入门',0,1,'2021-12-02 17:14:42.809507','2021-12-02 17:14:42.809565',0,100.00,0.00,'',5,61),(185,'7天Typescript从入门到放弃',0,1,'2021-12-02 19:27:38.170174','2021-12-02 19:27:38.170196',0,800.00,0.01,'限时免费',1,62),(186,'3天Typescript精修',0,1,'2021-12-02 19:27:38.170430','2021-12-02 19:27:38.170449',0,998.00,898.20,'折扣',2,62),(187,'7天Typescript从入门到放弃',0,1,'2021-12-02 19:30:16.085406','2021-12-02 19:30:16.085435',0,800.00,0.00,'限时免费',1,63),(188,'3天Typescript精修',0,1,'2021-12-02 19:30:16.085502','2021-12-02 19:30:16.085512',0,998.00,898.20,'折扣',2,63),(189,'7天Typescript从入门到放弃',0,1,'2021-12-02 19:33:54.274718','2021-12-02 19:33:54.274746',0,800.00,0.00,'限时免费',1,64),(190,'3天Typescript精修',0,1,'2021-12-02 19:33:54.274824','2021-12-02 19:33:54.274834',0,998.00,898.20,'折扣',2,64),(191,'3天学会Vue基础',0,1,'2021-12-02 21:25:46.460958','2021-12-02 21:25:46.461005',0,500.00,400.00,'减免',3,65),(192,'算法与数据结构体系课',0,1,'2021-12-02 22:10:25.062533','2021-12-02 22:10:25.062564',0,998.00,0.00,'',4,66),(193,'3天学会Vue基础',0,1,'2021-12-02 22:31:19.302363','2021-12-02 22:31:19.302386',0,500.00,400.00,'减免',3,67),(194,'算法与数据结构体系课',0,1,'2021-12-02 22:49:09.477587','2021-12-02 22:49:09.477617',0,998.00,0.00,'',4,68),(195,'javascript进阶',0,1,'2021-12-03 18:28:04.598503','2021-12-03 18:28:04.598532',0,1750.00,0.00,'限时免费',6,69),(196,'javascript进阶',0,1,'2021-12-03 18:28:39.833761','2021-12-03 18:28:39.833803',0,1750.00,0.00,'限时免费',6,70),(197,'python基础入门',0,1,'2021-12-03 18:40:44.188860','2021-12-03 18:40:44.188893',0,100.00,0.00,'',5,71),(198,'javascript进阶',0,1,'2021-12-03 18:40:44.189011','2021-12-03 18:40:44.189031',0,1750.00,0.00,'限时免费',6,71),(199,'python基础入门',0,1,'2021-12-03 18:43:10.832776','2021-12-03 18:43:10.832827',0,100.00,0.00,'',5,72),(200,'javascript进阶',0,1,'2021-12-03 18:43:10.832913','2021-12-03 18:43:10.832928',0,1750.00,0.00,'限时免费',6,72),(201,'javascript进阶',0,1,'2021-12-03 18:43:31.929463','2021-12-03 18:43:31.929492',0,1750.00,0.00,'限时免费',6,73),(202,'python基础入门',0,1,'2021-12-03 18:43:52.279396','2021-12-03 18:43:52.279430',0,100.00,0.00,'',5,74),(203,'javascript进阶',0,1,'2021-12-03 18:46:32.037717','2021-12-03 18:46:32.037746',0,1750.00,0.00,'限时免费',6,75),(204,'Kotlin从入门到精通',0,1,'2021-12-03 18:46:32.037803','2021-12-03 18:46:32.037810',0,500.00,0.00,'',10,75),(205,'javascript进阶',0,1,'2021-12-03 18:46:55.873597','2021-12-03 18:46:55.873623',0,1750.00,0.00,'限时免费',6,76),(206,'javascript进阶',0,1,'2021-12-03 18:47:24.030076','2021-12-03 18:47:24.030104',0,1750.00,0.00,'限时免费',6,77),(207,'爬虫进阶之逆向工程',0,1,'2021-12-03 18:47:24.030153','2021-12-03 18:47:24.030160',0,400.00,0.00,'',7,77),(208,'javascript进阶',0,1,'2021-12-03 19:00:02.534432','2021-12-03 19:00:02.534466',0,1750.00,0.00,'限时免费',6,78),(209,'爬虫进阶之逆向工程',0,1,'2021-12-03 19:00:02.534524','2021-12-03 19:00:02.534533',0,400.00,0.00,'',7,78),(210,'javascript进阶',0,1,'2021-12-03 19:01:09.293975','2021-12-03 19:01:09.294059',0,1750.00,0.00,'限时免费',6,79),(211,'javascript进阶',0,1,'2021-12-03 19:11:09.523219','2021-12-03 19:11:09.523249',0,1750.00,0.00,'限时免费',6,80),(212,'javascript进阶',0,1,'2021-12-03 19:17:27.463180','2021-12-03 19:17:27.463211',0,1750.00,0.00,'限时免费',6,81),(213,'javascript进阶',0,1,'2021-12-03 19:22:04.091014','2021-12-03 19:22:04.091042',0,1750.00,0.00,'限时免费',6,82),(214,'javascript进阶',0,1,'2021-12-03 19:23:25.740012','2021-12-03 19:23:25.740036',0,1750.00,0.00,'限时免费',6,83),(215,'javascript进阶',0,1,'2021-12-03 19:24:50.115126','2021-12-03 19:24:50.115158',0,1750.00,0.00,'限时免费',6,84),(216,'javascript进阶',0,1,'2021-12-03 19:26:16.680844','2021-12-03 19:26:16.680872',0,1750.00,0.00,'限时免费',6,85),(217,'javascript进阶',0,1,'2021-12-03 19:27:11.636489','2021-12-03 19:27:11.636518',0,1750.00,0.00,'限时免费',6,86),(218,'javascript进阶',0,1,'2021-12-03 19:28:36.545555','2021-12-03 19:28:36.545596',0,1750.00,0.00,'限时免费',6,87),(219,'javascript进阶',0,1,'2021-12-03 19:34:37.139998','2021-12-03 19:34:37.140023',0,1750.00,0.00,'限时免费',6,88),(220,'javascript进阶',0,1,'2021-12-03 19:38:26.777731','2021-12-03 19:38:26.777760',0,1750.00,0.00,'限时免费',6,89),(221,'javascript进阶',0,1,'2021-12-03 19:40:47.751171','2021-12-03 19:40:47.751199',0,1750.00,0.00,'限时免费',6,90),(222,'Kubernetes 入门到进阶实战',0,1,'2021-12-03 19:45:45.254479','2021-12-03 19:45:45.254510',0,500.00,0.00,'',8,91),(223,'算法与数据结构体系课',0,1,'2021-12-03 19:46:56.572842','2021-12-03 19:46:56.572871',0,998.00,0.00,'',4,92),(224,'算法与数据结构体系课',0,1,'2021-12-03 19:48:04.011273','2021-12-03 19:48:04.011308',0,998.00,0.00,'',4,93),(225,'python基础入门',0,1,'2021-12-03 19:49:07.679501','2021-12-03 19:49:07.679536',0,100.00,0.00,'',5,94);
/*!40000 ALTER TABLE `fg_order_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_study_code`
--

DROP TABLE IF EXISTS `fg_study_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_study_code` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` longtext NOT NULL,
  `chapter_id` bigint DEFAULT NULL,
  `course_id` bigint NOT NULL,
  `lesson_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_study_code_chapter_id_63fd7f82` (`chapter_id`),
  KEY `fg_study_code_course_id_0d0fba5e` (`course_id`),
  KEY `fg_study_code_lesson_id_ce4b5d65` (`lesson_id`),
  KEY `fg_study_code_user_id_26fa32d0` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_study_code`
--

LOCK TABLES `fg_study_code` WRITE;
/*!40000 ALTER TABLE `fg_study_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `fg_study_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_study_note`
--

DROP TABLE IF EXISTS `fg_study_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_study_note` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `content` longtext NOT NULL,
  `chapter_id` bigint DEFAULT NULL,
  `course_id` bigint NOT NULL,
  `lesson_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_study_note_chapter_id_c9dd4cb7` (`chapter_id`),
  KEY `fg_study_note_course_id_c9da28b3` (`course_id`),
  KEY `fg_study_note_lesson_id_920b810c` (`lesson_id`),
  KEY `fg_study_note_user_id_632f7bda` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_study_note`
--

LOCK TABLES `fg_study_note` WRITE;
/*!40000 ALTER TABLE `fg_study_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `fg_study_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_study_progress`
--

DROP TABLE IF EXISTS `fg_study_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_study_progress` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `study_time` int NOT NULL,
  `lesson_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_study_progress_lesson_id_1c439c2d` (`lesson_id`),
  KEY `fg_study_progress_user_id_e707812e` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_study_progress`
--

LOCK TABLES `fg_study_progress` WRITE;
/*!40000 ALTER TABLE `fg_study_progress` DISABLE KEYS */;
INSERT INTO `fg_study_progress` VALUES (1,10,1,1),(2,20,2,1),(3,10,3,1),(4,40,4,1);
/*!40000 ALTER TABLE `fg_study_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_study_qa`
--

DROP TABLE IF EXISTS `fg_study_qa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_study_qa` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question` longtext NOT NULL,
  `answer` longtext NOT NULL,
  `chapter_id` bigint DEFAULT NULL,
  `course_id` bigint NOT NULL,
  `lesson_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_study_qa_chapter_id_175f5e8b` (`chapter_id`),
  KEY `fg_study_qa_course_id_deecf40a` (`course_id`),
  KEY `fg_study_qa_lesson_id_d4cceffb` (`lesson_id`),
  KEY `fg_study_qa_user_id_2efee66c` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_study_qa`
--

LOCK TABLES `fg_study_qa` WRITE;
/*!40000 ALTER TABLE `fg_study_qa` DISABLE KEYS */;
/*!40000 ALTER TABLE `fg_study_qa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_teacher`
--

DROP TABLE IF EXISTS `fg_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_teacher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `role` smallint NOT NULL,
  `title` varchar(64) NOT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `brief` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_teacher`
--

LOCK TABLES `fg_teacher` WRITE;
/*!40000 ALTER TABLE `fg_teacher` DISABLE KEYS */;
INSERT INTO `fg_teacher` VALUES (1,'张老师',1,1,'2021-07-22 04:31:27.741562','2021-07-22 04:31:27.741708',0,0,'BAT中某某技术总监','xxxxxxxx','teacher/avatar.jpg','<p>2009入行，在IT行业深耕13年，删库无数，行内同行送称号：删库小王子。</p>'),(2,'李老师',1,1,'2021-07-22 04:31:27.741562','2021-07-22 04:31:27.741708',0,0,'BAT中某某技术顾问','xxxxxxxx','teacher/avatar.jpg','<p>百变小王子，各种框架信手拈来。</p>'),(3,'王老师',1,1,'2021-07-22 04:31:27.741562','2021-07-22 04:31:27.741708',0,0,'BAT中某某技术主管','xxxxxxxx','teacher/avatar.jpg','<p>草根站长，专注运维20年。</p>'),(4,'红老师',1,1,'2021-07-22 04:31:27.741562','2021-07-22 04:31:27.741708',0,0,'BAT中某某项目经理','xxxxxxxx','teacher/avatar.jpg','<p>美女讲师，说话好听。</p>'),(5,'赵小明',0,1,'2021-11-18 01:46:15.280399','2021-11-18 01:46:15.280498',0,1,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数'),(6,'蔡秀英',0,1,'2021-11-18 07:48:10.357377','2021-11-18 07:48:10.357488',0,0,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 13970034056, 邮箱地址: awei@jielin.cn'),(7,'杨玲',0,1,'2021-11-18 07:48:10.396653','2021-11-18 07:48:10.396690',0,1,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 15580293985, 邮箱地址: shaotao@gangjuan.cn'),(8,'彭丽丽',0,1,'2021-11-18 07:48:10.400640','2021-11-18 07:48:10.400676',0,2,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 14562075269, 邮箱地址: igong@wushao.cn'),(9,'高玉兰',0,1,'2021-11-18 07:48:10.404844','2021-11-18 07:48:10.404879',0,2,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 13209880156, 邮箱地址: tianyan@leiping.cn'),(10,'邹峰',0,1,'2021-11-18 07:48:10.409451','2021-11-18 07:48:10.409505',0,0,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 15355363593, 邮箱地址: junxiao@rk.cn'),(11,'李伟',0,1,'2021-11-18 07:48:10.415667','2021-11-18 07:48:10.415727',0,1,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 18930465643, 邮箱地址: junwan@gangjin.cn'),(12,'宋琳',0,1,'2021-11-18 07:48:10.420932','2021-11-18 07:48:10.420967',0,0,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 13588739362, 邮箱地址: hwang@fuma.cn'),(13,'张霞',0,1,'2021-11-18 07:48:10.427760','2021-11-18 07:48:10.428144',0,1,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 18653666465, 邮箱地址: she@xiangdu.cn'),(14,'崔帅',0,1,'2021-11-18 07:48:10.431704','2021-11-18 07:48:10.431740',0,1,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 15656461761, 邮箱地址: fengna@jb.cn'),(15,'王秀梅',0,1,'2021-11-18 07:48:10.436430','2021-11-18 07:48:10.436468',0,0,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 15881313476, 邮箱地址: cuixiuying@leijie.cn'),(16,'张秀荣',0,1,'2021-11-18 07:49:19.191507','2021-11-18 07:49:19.191565',0,1,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 15106257299, 邮箱地址: yong40@gk.cn'),(17,'严秀英',0,1,'2021-11-18 07:49:19.196938','2021-11-18 07:49:19.196992',0,2,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 13820426530, 邮箱地址: wanping@minhou.cn'),(18,'高玉英',0,1,'2021-11-18 07:49:19.201088','2021-11-18 07:49:19.201126',0,0,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 15276406344, 邮箱地址: pguo@wei.net'),(19,'曾伟',0,1,'2021-11-18 07:49:19.205831','2021-11-18 07:49:19.205871',0,1,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 18802911620, 邮箱地址: fangcai@jing.cn'),(20,'朱萍',0,1,'2021-11-18 07:49:19.210062','2021-11-18 07:49:19.210114',0,0,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 13732627347, 邮箱地址: yongfu@gangxiulan.cn'),(21,'刘晶',0,1,'2021-11-18 07:49:19.215844','2021-11-18 07:49:19.215902',0,2,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 15925012725, 邮箱地址: dwan@guiyingtian.cn'),(22,'杨建华',0,1,'2021-11-18 07:49:19.219651','2021-11-18 07:49:19.219709',0,2,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 18116707606, 邮箱地址: owei@wei.cn'),(23,'杨颖',0,1,'2021-11-18 07:49:19.224861','2021-11-18 07:49:19.224929',0,1,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 14519476177, 邮箱地址: yan04@shi.cn'),(24,'唐岩',0,1,'2021-11-18 07:49:19.228411','2021-11-18 07:49:19.228448',0,2,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 15710151254, 邮箱地址: junxu@zhu.cn'),(25,'龙阳',0,1,'2021-11-18 07:49:19.233416','2021-11-18 07:49:19.233456',0,2,'老师','从业3年，管理班级无数','teacher/avatar.jpg','从业3年，管理班级无数，联系电话: 15977838233, 邮箱地址: yanli@yong.org');
/*!40000 ALTER TABLE `fg_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_user_course`
--

DROP TABLE IF EXISTS `fg_user_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_user_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `orders` int NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `study_time` int NOT NULL,
  `chapter_id` bigint DEFAULT NULL,
  `course_id` bigint NOT NULL,
  `lesson_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fg_user_course_chapter_id_8da276f6` (`chapter_id`),
  KEY `fg_user_course_course_id_dec94913` (`course_id`),
  KEY `fg_user_course_lesson_id_3e20def4` (`lesson_id`),
  KEY `fg_user_course_user_id_73125b6f` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_user_course`
--

LOCK TABLES `fg_user_course` WRITE;
/*!40000 ALTER TABLE `fg_user_course` DISABLE KEYS */;
INSERT INTO `fg_user_course` VALUES (7,'',0,1,'2021-12-02 20:35:02.281097','2021-12-07 15:18:04.382311',0,3686,2,1,1,1),(8,'',0,1,'2021-12-02 20:35:02.281163','2021-12-02 20:35:02.281170',0,3600,1,2,1,1),(9,'',0,1,'2021-12-03 19:44:37.736724','2021-12-03 19:44:37.736759',0,0,NULL,3,NULL,1),(10,'',0,1,'2021-12-03 19:46:24.881863','2021-12-03 19:46:24.881897',0,0,NULL,8,NULL,1),(11,'',0,1,'2021-12-03 19:48:40.643536','2021-12-03 19:48:40.643603',0,0,NULL,4,NULL,1),(12,'',0,1,'2021-12-03 19:49:52.228922','2021-12-03 19:49:52.228972',0,0,NULL,5,NULL,1);
/*!40000 ALTER TABLE `fg_user_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_users`
--

DROP TABLE IF EXISTS `fg_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `money` decimal(9,2) NOT NULL,
  `credit` int NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_users`
--

LOCK TABLES `fg_users` WRITE;
/*!40000 ALTER TABLE `fg_users` DISABLE KEYS */;
INSERT INTO `fg_users` VALUES (1,'pbkdf2_sha256$260000$gppyuBM6rRkdzfTKZqJpCs$GHpJazV0hf7HSYzuDwQgUJxRQ3HBqIm1s/PSWiaVdKE=','2021-11-17 12:49:00.000000',1,'root','','','',1,1,'2021-11-10 09:35:00.000000','13772923138',0.00,500,'avatar/2021/avatar.thumb_800x800.jpg'),(2,'pbkdf2_sha256$260000$pJgDidvRKhBOGZ3zHHIoFO$SCWAyFx3L4+uioBbQFau7Wve51+ALVCDreIWIlPex88=',NULL,0,'15709282031','','','',0,1,'2021-11-12 09:33:00.000000','15709282031',0.00,0,'avatar/2021/avatar.jpg'),(4,'pbkdf2_sha256$260000$AnTQgpU4dvtW1dAI1SELoi$rlK9iFUkZWUFH+8FnAP6uLYmOHVwoE1+zRSD8CD7Yqs=',NULL,0,'13312345671','','','',0,1,'2021-11-12 09:41:00.000000','13312345671',0.00,0,'avatar/2021/avatar_IDsuAaq_hIo6Moi.jpg'),(5,'pbkdf2_sha256$260000$EW0lMsVmluMemMY71y1y7Y$00y+3VKdaOcaoLFQonVlYGHBAVzZHsvr5bjevCORcCE=',NULL,0,'18791425678','','','',0,1,'2021-11-12 10:40:00.000000','18791425678',0.00,0,'avatar/2021/avatar.thumb_800x800.jpg'),(6,'pbkdf2_sha256$260000$2MHtNpU362yc3yyFewa6OC$7lqrLFQAh7BEicqiZDfcFQVwyj2xaFv63e7IDWdcJKc=',NULL,0,'15809887766','','','',0,1,'2021-11-12 10:44:30.852165','15809887766',0.00,0,'avatar/2021/avatar.jpg'),(7,'pbkdf2_sha256$260000$JNQL6p6p6MjQEYKqwE7f76$G2Yy8O4R6v1kYYSvOcbaPh3/FJF/GxM5/8HEZzc+l8Y=',NULL,0,'13772923158','','','',0,1,'2021-11-12 11:21:51.513993','13772923158',0.00,0,'avatar/2021/avatar.jpg'),(8,'pbkdf2_sha256$260000$YBINBmY92jUnBmCLZUIQgm$/3jGLKUiNU55Gq4q3PVZmxIkpJtOQ+cm0GS4KrvV/T0=',NULL,0,'13772923166','','','',0,1,'2021-11-12 11:27:38.390067','13772923166',0.00,0,'avatar/2021/avatar.jpg'),(9,'pbkdf2_sha256$260000$rwUholrMTrzOZUhG7VcgWb$LqG+LH0i6pC/etSW5+umeAOs9TO0GG2KFb+BKgdE2sE=',NULL,0,'13772925188','','','',0,1,'2021-11-12 11:32:38.339338','13772925188',0.00,0,'avatar/2021/avatar.jpg'),(10,'pbkdf2_sha256$260000$lPow7uZC1wwheI6UMVFg1q$8lZsE2Nlv5xYKqVInvdRw7yQdiwFgmmn5rFhnVfT8MU=',NULL,0,'13772725125','','','',0,1,'2021-11-12 11:48:03.830991','13772725125',0.00,0,'avatar/2021/avatar.jpg'),(11,'pbkdf2_sha256$260000$r5kd6CVwbjNO4uJc2ASz79$hovzpe3Jp/0uYZrB71ZaeJmtYWve8BjoBRcx2SFAVVE=',NULL,0,'14429281355','','','',0,1,'2021-11-12 11:54:22.855220','14429281355',0.00,0,'avatar/2021/avatar.jpg'),(12,'pbkdf2_sha256$260000$dJ5pe2eimmnHeCyALGZO0y$sSbwTGLQJ7PrA2I8yLPm7Pttt9CH3NivDLH1gRBF6bo=',NULL,0,'18891234567','','','',0,1,'2021-11-12 12:01:27.737808','18891234567',0.00,0,'avatar/2021/avatar.jpg'),(16,'pbkdf2_sha256$260000$2jbXPU59Yda701zU3WzLas$57qYM7Qx7x2q8xzeB7te8mQxOb4ofTMMfE3hb0UPEF0=',NULL,0,'17260808698','','','',0,1,'2021-11-15 14:35:13.957774','17260808698',0.00,0,'avatar/2021/avatar.jpg'),(17,'pbkdf2_sha256$260000$PHoyns2jNwJVgSfAEligpt$gzHATgytvCz4muM/1GUzeI1IYQxJVifYwhhmvCB85cY=',NULL,0,'17260808696','','','',0,1,'2021-11-16 07:04:31.829092','17260808696',0.00,0,'avatar/2021/avatar.jpg');
/*!40000 ALTER TABLE `fg_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_users_groups`
--

DROP TABLE IF EXISTS `fg_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_users_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fg_users_groups_user_id_group_id_f5f82c7c_uniq` (`user_id`,`group_id`),
  KEY `fg_users_groups_group_id_c8251a7c_fk_auth_group_id` (`group_id`),
  CONSTRAINT `fg_users_groups_group_id_c8251a7c_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `fg_users_groups_user_id_e88c7807_fk_fg_users_id` FOREIGN KEY (`user_id`) REFERENCES `fg_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_users_groups`
--

LOCK TABLES `fg_users_groups` WRITE;
/*!40000 ALTER TABLE `fg_users_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `fg_users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fg_users_user_permissions`
--

DROP TABLE IF EXISTS `fg_users_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fg_users_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fg_users_user_permissions_user_id_permission_id_fb150cfe_uniq` (`user_id`,`permission_id`),
  KEY `fg_users_user_permis_permission_id_cf3040dd_fk_auth_perm` (`permission_id`),
  CONSTRAINT `fg_users_user_permis_permission_id_cf3040dd_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `fg_users_user_permissions_user_id_d22a3ae0_fk_fg_users_id` FOREIGN KEY (`user_id`) REFERENCES `fg_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fg_users_user_permissions`
--

LOCK TABLES `fg_users_user_permissions` WRITE;
/*!40000 ALTER TABLE `fg_users_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `fg_users_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-13 17:45:26
