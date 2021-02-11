-- MySQL dump 10.9
--
-- Host: localhost    Database: detour_development
-- ------------------------------------------------------
-- Server version	4.1.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
CREATE TABLE `roles_users` (
  `role_id` int(11) default NULL,
  `user_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles_users`
--


/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
LOCK TABLES `roles_users` WRITE;
INSERT INTO `roles_users` VALUES (7,1),(10,4),(11,5),(12,0);
UNLOCK TABLES;
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;

--
-- Table structure for table `controllers_and_actions`
--

DROP TABLE IF EXISTS `controllers_and_actions`;
CREATE TABLE `controllers_and_actions` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `controller` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `controllers_and_actions`
--


/*!40000 ALTER TABLE `controllers_and_actions` DISABLE KEYS */;
LOCK TABLES `controllers_and_actions` WRITE;
INSERT INTO `controllers_and_actions` VALUES (6,'List Controllers','controllers_and_actions','index',NULL,'2008-12-07 19:45:37'),(8,'New Controllers','controllers_and_actions','new',NULL,'2008-12-07 19:45:46'),(9,'Edit Controllers','controllers_and_actions','edit',NULL,'2008-12-07 19:45:57'),(10,'Create Controllers','controllers_and_actions','create',NULL,'2008-12-07 19:46:06'),(11,'Update Controllers','controllers_and_actions','update',NULL,'2008-12-07 19:46:25'),(12,'Delete Controllers','controllers_and_actions','destroy',NULL,'2008-12-07 19:46:16'),(13,'List Detours','detours','index',NULL,'2008-12-06 20:10:10'),(14,'List Inactive Detours','detours','inactive',NULL,'2008-12-06 20:05:40'),(15,'Show Detours','detours','show',NULL,NULL),(16,'Show Inactive Detours','detours','show_inactive',NULL,'2008-12-06 20:10:41'),(17,'New Detours','detours','new',NULL,NULL),(18,'Edit Detours','detours','edit',NULL,NULL),(19,'Create Detours','detours','create',NULL,NULL),(20,'Update Detours','detours','update',NULL,NULL),(21,'Delete Detours','detours','destroy',NULL,'2008-12-06 20:10:59'),(22,'Cancel Detours','detours','cancel_detour',NULL,'2008-12-06 15:28:21'),(24,'List Locations','locations','index',NULL,'2008-12-06 20:11:11'),(26,'New Locations','locations','new',NULL,NULL),(27,'Edit Locations','locations','edit',NULL,NULL),(28,'Create Locations','locations','create',NULL,NULL),(29,'Update Locations','locations','update',NULL,NULL),(30,'Delete Locations','locations','destroy',NULL,'2008-12-06 20:11:37'),(31,'List Notifications','notifications','index',NULL,'2008-12-06 20:16:21'),(32,'Show Notifications','notifications','show',NULL,NULL),(33,'New Notifications','notifications','new',NULL,NULL),(34,'Edit Notifications','notifications','edit',NULL,NULL),(35,'Create Notifications','notifications','create',NULL,NULL),(36,'Update Notifications','notifications','update',NULL,NULL),(37,'Delete Notifications','notifications','destroy',NULL,'2008-12-06 20:16:51'),(38,'List Settings','settings','index',NULL,'2008-12-06 20:17:14'),(39,'New Settings','settings','new',NULL,NULL),(40,'Edit Settings','settings','edit',NULL,NULL),(41,'Create Settings','settings','create',NULL,NULL),(42,'Update Settings','settings','update',NULL,NULL),(43,'Delete Settings','settings','destroy',NULL,'2008-12-06 20:17:27'),(44,'List Users','users','index',NULL,'2008-12-06 20:17:40'),(45,'New Users','users','new',NULL,NULL),(46,'Edit Users','users','edit',NULL,NULL),(47,'Create Users','users','create',NULL,NULL),(48,'Update Users','users','update',NULL,NULL),(49,'Delete Users','users','destroy',NULL,'2008-12-06 20:17:53'),(50,'List Roles','roles','index','2008-12-07 16:42:53','2008-12-07 16:42:53'),(51,'Create Roles','roles','create','2008-12-07 16:43:11','2008-12-07 16:45:16'),(52,'New Roles','roles','new','2008-12-07 16:43:22','2008-12-07 16:45:03'),(53,'Edit Roles','roles','edit','2008-12-07 16:43:59','2008-12-07 16:43:59'),(54,'Update Roles','roles','update','2008-12-07 16:44:10','2008-12-07 16:44:10'),(55,'Delete Roles','roles','destroy','2008-12-07 16:44:47','2008-12-07 16:44:47'),(56,'Show Detour Details','detours','show_detail','2009-10-13 07:18:04','2009-10-13 07:20:11'),(57,'Show Inactive Detour Details','detours','show_inactive_detail','2009-10-13 07:18:31','2009-10-13 07:18:31');
UNLOCK TABLES;
/*!40000 ALTER TABLE `controllers_and_actions` ENABLE KEYS */;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL auto_increment,
  `value` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `parameter` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--


/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
LOCK TABLES `settings` WRITE;
INSERT INTO `settings` VALUES (1,'http://wayland.mcts.org/detour_pdf','2008-11-30 04:02:58','2009-10-12 11:16:27','pdf_url'),(2,'/data/www/html/detour_pdf','2008-11-30 04:06:42','2009-10-13 07:28:58','pdf_path'),(3,'/var/spool/asterisk/outgoing/','2008-12-12 20:51:16','2009-10-12 11:16:08','asterisk_call_path'),(4,'/tmp','2008-12-12 20:51:42','2008-12-12 20:56:56','asterisk_temp_path');
UNLOCK TABLES;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--


/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
LOCK TABLES `roles` WRITE;
INSERT INTO `roles` VALUES (7,'Administrator'),(10,'Dispatcher'),(11,'Lead Dispatcher'),(12,'Not Logged In');
UNLOCK TABLES;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL auto_increment,
  `short_name` varchar(255) default NULL,
  `long_name` varchar(255) default NULL,
  `fax_number` varchar(255) default NULL,
  `fax_default` int(11) default NULL,
  `phone_number` varchar(255) default NULL,
  `phone_default` int(11) default NULL,
  `email_address` varchar(255) default NULL,
  `printer` varchar(255) default NULL,
  `printer_default` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `email_default` int(11) default NULL,
  `printer_is_postscript` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--


/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
LOCK TABLES `locations` WRITE;
INSERT INTO `locations` VALUES (1,'FD','Fond du Lac Station','',0,'5373',1,'fdlclerk@mcts.org','fdltranlas',1,'2008-11-17 00:55:11','2009-10-13 12:30:16',0,0),(2,'FZ','Fiebrantz Station','',0,'6451',1,'fbzclerk@mcts.org','fbztranlas',1,'2008-11-17 00:55:43','2009-10-13 12:29:25',0,0),(3,'KK','Kinnickinnic Station','',0,'7371',1,'kkclerk@mcts.org','kktranlas',1,'2008-11-17 03:20:41','2009-10-13 12:30:53',0,0),(4,'DISP','Dispatch Office','',0,'8862',0,'','dispatchlaserl',1,'2008-11-17 03:21:52','2009-10-13 12:24:38',0,1),(5,'Info','Information','',0,'8867',1,'','infolaser',1,'2008-11-26 03:38:53','2008-11-26 03:38:53',NULL,NULL),(6,'MIS','MIS Department','',0,'3279',1,'dnoll@mcts.org','miscopier',1,'2009-10-12 11:17:17','2009-10-13 12:23:17',0,0);
UNLOCK TABLES;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;

--
-- Table structure for table `rights_roles`
--

DROP TABLE IF EXISTS `rights_roles`;
CREATE TABLE `rights_roles` (
  `right_id` int(11) default NULL,
  `role_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rights_roles`
--


/*!40000 ALTER TABLE `rights_roles` DISABLE KEYS */;
LOCK TABLES `rights_roles` WRITE;
INSERT INTO `rights_roles` VALUES (13,7),(14,7),(15,7),(16,7),(17,7),(18,7),(19,7),(20,7),(21,7),(22,7),(23,7),(24,7),(25,7),(26,7),(27,7),(28,7),(29,7),(30,7),(31,7),(32,7),(33,7),(34,7),(35,7),(36,7),(37,7),(38,7),(39,7),(40,7),(41,7),(42,7),(43,7),(44,7),(45,7),(46,7),(47,7),(48,7),(49,7),(50,7),(51,7),(52,7),(53,7),(54,7),(55,7),(56,7),(57,7),(58,7),(231,10),(232,10),(233,10),(234,10),(235,10),(236,10),(237,10),(238,10),(239,10),(240,10),(241,10),(243,11),(244,11),(245,11),(246,11),(247,11),(248,11),(249,11),(250,11),(251,11),(252,11),(253,11),(254,11),(255,11),(256,11),(257,11),(258,11),(259,11),(260,11),(261,11),(262,11),(263,7),(264,7),(265,7),(266,7),(267,7),(268,7),(269,7),(270,7),(271,7),(272,7),(273,7),(274,7),(275,7),(276,7),(277,7),(278,7),(279,7),(280,7),(281,7),(282,7),(283,12),(284,12),(285,12),(286,12),(13,7),(14,7),(15,7),(16,7),(17,7),(18,7),(19,7),(20,7),(21,7),(22,7),(23,7),(24,7),(25,7),(26,7),(27,7),(28,7),(29,7),(30,7),(31,7),(32,7),(33,7),(34,7),(35,7),(36,7),(37,7),(38,7),(39,7),(40,7),(41,7),(42,7),(43,7),(44,7),(45,7),(46,7),(47,7),(48,7),(49,7),(50,7),(51,7),(52,7),(53,7),(54,7),(55,7),(56,7),(57,7),(58,7),(231,10),(232,10),(233,10),(234,10),(235,10),(236,10),(237,10),(238,10),(239,10),(240,10),(241,10),(243,11),(244,11),(245,11),(246,11),(247,11),(248,11),(249,11),(250,11),(251,11),(252,11),(253,11),(254,11),(255,11),(256,11),(257,11),(258,11),(259,11),(260,11),(261,11),(262,11),(263,7),(264,7),(265,7),(266,7),(267,7),(268,7),(269,7),(270,7),(271,7),(272,7),(273,7),(274,7),(275,7),(276,7),(277,7),(278,7),(279,7),(280,7),(281,7),(282,7),(283,12),(284,12),(285,12),(286,12),(288,7),(289,11),(290,11),(291,7);
UNLOCK TABLES;
/*!40000 ALTER TABLE `rights_roles` ENABLE KEYS */;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
CREATE TABLE `rights` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `controller` varchar(255) default NULL,
  `action` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rights`
--


/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
LOCK TABLES `rights` WRITE;
INSERT INTO `rights` VALUES (13,'New Controllers','controllers_and_actions','new'),(14,'Create Detours','detours','create'),(15,'Edit Locations','locations','edit'),(16,'Update Notifications','notifications','update'),(17,'New Users','users','new'),(18,'Show Controllers','controllers_and_actions','show'),(19,'Destroy Detours','detours','destroy'),(20,'Index Locations','locations','index'),(21,'Create Settings','settings','create'),(22,'Update Users','users','update'),(23,'Update Controllers','controllers_and_actions','update'),(24,'Edit Detours','detours','edit'),(25,'New Locations','locations','new'),(26,'Destroy Settings','settings','destroy'),(27,'Authorize Detours','detours','authorize'),(28,'Inactive Detours','detours','inactive'),(29,'Show Locations','locations','show'),(30,'Edit Settings','settings','edit'),(31,'Index Detours','detours','index'),(32,'Update Locations','locations','update'),(33,'Index Settings','settings','index'),(34,'Login','admin','login'),(35,'New Detours','detours','new'),(36,'Create Notifications','notifications','create'),(37,'New Settings','settings','new'),(38,'Logout','admin','logout'),(39,'Show Detours','detours','show'),(40,'Destroy Notifications','notifications','destroy'),(41,'Update Settings','settings','update'),(42,'Create Users','users','create'),(43,'Create Controllers','controllers_and_actions','create'),(44,'Show Detours','detours','show'),(45,'Edit Notifications','notifications','edit'),(46,'Index Notifications','notifications','index'),(47,'Destroy Users','users','destroy'),(48,'Destroy Controllers','controllers_and_actions','destroy'),(49,'Update Detours','detours','update'),(50,'Create Locations','locations','create'),(51,'New Notifications','notifications','new'),(52,'Edit Users','users','edit'),(53,'Edit Controllers','controllers_and_actions','edit'),(54,'Cancel Detours','detours','cancel_detour'),(55,'Destroy Locations','locations','destroy'),(56,'Show Notifications','notifications','show'),(57,'Index Users','users','index'),(58,'Index Controllers','controllers_and_actions','index'),(201,'Cancel Detours','detours','cancel_detour'),(202,'List Detours','detours','index'),(203,'Create Detours','detours','create'),(204,'New Detours','detours','new'),(205,'Show Detours','detours','show'),(206,'Edit Detours','detours','edit'),(207,'Show Inactive Detours','detours','show_inactive'),(208,'List Notifications','notifications','index'),(209,'Update Detours','detours','update'),(210,'Show Notifications','notifications','show'),(211,'List Locations','locations','index'),(212,'List Inactive Detours','detours','inactive'),(213,'Cancel Detours','detours','cancel_detour'),(214,'List Detours','detours','index'),(215,'Create Detours','detours','create'),(216,'New Detours','detours','new'),(217,'Show Detours','detours','show'),(218,'Edit Detours','detours','edit'),(219,'Show Inactive Detours','detours','show_inactive'),(220,'List Notifications','notifications','index'),(221,'Update Detours','detours','update'),(223,'Show Notifications','notifications','show'),(224,'List Locations','locations','index'),(225,'List Inactive Detours','detours','inactive'),(231,'Cancel Detours','detours','cancel_detour'),(232,'List Detours','detours','index'),(233,'Create Detours','detours','create'),(234,'New Detours','detours','new'),(235,'Show Detours','detours','show'),(236,'Edit Detours','detours','edit'),(237,'Show Inactive Detours','detours','show_inactive'),(238,'List Notifications','notifications','index'),(239,'Update Detours','detours','update'),(240,'List Locations','locations','index'),(241,'List Inactive Detours','detours','inactive'),(243,'Cancel Detours','detours','cancel_detour'),(244,'List Detours','detours','index'),(245,'List Users','users','index'),(246,'Create Detours','detours','create'),(247,'New Detours','detours','new'),(248,'Delete Notifications','notifications','destroy'),(249,'New Users','users','new'),(250,'Delete Detours','detours','destroy'),(251,'Show Detours','detours','show'),(252,'Update Users','users','update'),(253,'Edit Detours','detours','edit'),(254,'Show Inactive Detours','detours','show_inactive'),(255,'List Notifications','notifications','index'),(256,'Update Detours','detours','update'),(257,'Show Notifications','notifications','show'),(258,'Create Users','users','create'),(259,'List Locations','locations','index'),(260,'Delete Users','users','destroy'),(261,'List Inactive Detours','detours','inactive'),(262,'Edit Users','users','edit'),(263,'List Detours','detours','index'),(264,'New Roles','roles','new'),(265,'List Users','users','index'),(266,'Delete Notifications','notifications','destroy'),(267,'Update Roles','roles','update'),(268,'Delete Detours','detours','destroy'),(269,'Show Inactive Detours','detours','show_inactive'),(270,'List Notifications','notifications','index'),(271,'Delete Settings','settings','destroy'),(272,'List Settings','settings','index'),(273,'Delete Controllers','controllers_and_actions','destroy'),(274,'Delete Locations','locations','destroy'),(275,'Create Roles','roles','create'),(276,'Delete Roles','roles','destroy'),(277,'List Controllers','controllers_and_actions','index'),(278,'List Locations','locations','index'),(279,'Edit Roles','roles','edit'),(280,'Delete Users','users','destroy'),(281,'List Inactive Detours','detours','inactive'),(282,'List Roles','roles','index'),(283,'List Detours','detours','index'),(284,'Show Detours','detours','show'),(285,'Show Inactive Detours','detours','show_inactive'),(286,'List Inactive Detours','detours','inactive'),(288,'Show Inactive Detour Details','detours','show_inactive_detail'),(289,'Show Detour Details','detours','show_details'),(290,'Show Inactive Detour Details','detours','show_inactive_detail'),(291,'Show Detour Details','detours','show_detail');
UNLOCK TABLES;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(255) default NULL,
  `hashed_password` varchar(255) default NULL,
  `salt` varchar(255) default NULL,
  `access_level` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `full_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--


/*!40000 ALTER TABLE `users` DISABLE KEYS */;
LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES (1,'dale','f1ac7798de701bda545074cf63c25d48051a73d8','-6147124480.304143676571121',255,'2008-12-03 00:26:42','2008-12-08 18:03:10','Dale Noll'),(2,'notloggedin','70a577cba1959f7bc13c4e030479f594b0e5535d','-6143459780.503038829758928',NULL,'2008-12-16 20:15:49','2008-12-16 20:15:49','Not Logged In'),(4,'tomb','e5af02cbd8120bab30228717b1d97ff56ee7cdae','-6134674280.697685959987477',NULL,'2008-12-07 16:54:05','2008-12-08 18:03:28','Tom Berg'),(5,'ronw','7fd3389d9f0a399ac3cc0fc4df890bda0ec52277','-6139119080.186237473904237',NULL,'2008-12-07 16:54:21','2008-12-08 18:03:19','Ron Wiklin');
UNLOCK TABLES;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

