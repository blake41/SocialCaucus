-- MySQL dump 10.13  Distrib 5.1.59, for apple-darwin10.3.0 (i386)
--
-- Host: localhost    Database: devel_gillibrand2
-- ------------------------------------------------------
-- Server version	5.1.59

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
-- Table structure for table `politicians`
--

DROP TABLE IF EXISTS `politicians`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `politicians` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `screen_name` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `party` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `base_run_done` int(11) DEFAULT NULL,
  `search_base_run` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_politicians_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `politicians`
--

LOCK TABLES `politicians` WRITE;
/*!40000 ALTER TABLE `politicians` DISABLE KEYS */;
INSERT INTO `politicians` VALUES (1,'MicheleBachmann',18217624,'Michele Bachmann','R','2011-10-15 19:18:27','2012-02-26 05:28:03',1,1),(2,'DrRandPaul',39834947,'Rand Paul','R','2011-10-15 19:47:11','2012-02-26 05:28:03',1,1),(5,'kausmickey',30534986,NULL,'D',NULL,'2012-02-26 05:28:05',1,1),(6,'buckmaster2010',107239368,NULL,'D',NULL,'2012-02-26 05:28:05',1,1),(7,'freilichd',76047821,NULL,'D',NULL,'2012-02-26 05:28:05',1,1),(8,'GoGreene2010',154360513,NULL,'D',NULL,'2012-02-26 05:28:06',1,1),(9,'hoffman4IL',68981785,NULL,'D',NULL,'2012-02-26 05:28:06',1,1),(10,'BrianQuintana',125533074,NULL,'D',NULL,'2012-02-26 05:28:07',1,1),(11,'RandyParraz',135187049,NULL,'D',NULL,'2012-02-26 05:28:07',1,1),(12,'williamgbarnes',108809106,NULL,'D',NULL,'2012-02-26 05:28:08',1,1),(13,'JohnDoughertyUS',139568957,NULL,'D',NULL,'2012-02-26 05:28:08',1,1),(14,'Potter4Senate',193921884,NULL,'D',NULL,'2012-02-26 05:28:09',1,1),(15,'LisaForKansas',92210740,NULL,'D',NULL,'2012-02-26 05:28:09',1,1),(16,'EdenForAZ',153245970,NULL,'D',NULL,'2012-02-26 05:28:10',1,1),(17,'CalforNC',92397793,NULL,'D',NULL,'2012-02-26 05:28:10',1,1),(18,'mauriceferre',78404042,NULL,'D',NULL,'2012-02-26 05:28:11',1,1),(19,'Haley4Senate',160996274,NULL,'D',NULL,'2012-02-26 05:28:11',1,1),(20,'GoodeForSenate',154607591,NULL,'D',NULL,'2012-02-26 05:28:12',1,1),(21,'CheryleJackson',27252776,NULL,'D',NULL,'2012-02-26 05:28:13',1,1),(22,'SamGranato',58896642,NULL,'D',NULL,'2012-02-26 05:28:13',1,1),(23,'sullivan4senate',158155785,NULL,'D',NULL,'2012-02-26 05:28:14',1,1),(24,'Greene4Florida',135984432,NULL,'D',NULL,'2012-02-26 05:28:15',1,1),(25,'Mongiardo2010',50028257,NULL,'D',NULL,'2012-02-26 05:28:15',1,1),(26,'tlfiegen',29542988,NULL,'D',NULL,'2012-02-26 05:28:16',1,1),(27,'KrauseForIowa',45413198,NULL,'D',NULL,'2012-02-26 05:28:23',1,1),(28,'JenniferBrunner',20462779,NULL,'D',NULL,'2012-02-26 05:28:24',1,1),(29,'Elaine4NC',95210491,NULL,'D',NULL,'2012-02-26 05:28:25',1,1),(30,'BillHalter',107106071,NULL,'D',NULL,'2012-02-26 05:28:26',1,1),(31,'RoxanneConlin',85564029,NULL,'D',NULL,'2012-02-26 05:28:26',1,1),(32,'Giannoulias',71360328,NULL,'D',NULL,'2012-02-26 05:28:27',1,1),(33,'RobinCarnahan',55321681,NULL,'D',NULL,'2012-02-26 05:28:28',1,1),(34,'Andrewromanoff',69343589,NULL,'D',NULL,'2012-02-26 05:28:28',1,1),(35,'rodneyglassman',21230289,NULL,'D',NULL,'2012-02-26 05:28:29',1,1),(36,'McAdamsforAK',153934792,NULL,'D',NULL,'2012-02-26 05:28:29',1,1),(37,'FisherForOhio',21110718,NULL,'D',NULL,'2012-02-26 05:28:32',1,1),(38,'DickBlumenthal',102477372,NULL,'D',NULL,'2012-02-26 05:28:33',1,1),(39,'ConwayforKY',30150211,NULL,'D',NULL,'2012-02-26 05:28:34',1,1),(40,'chuckdevore',14415941,NULL,'R',NULL,'2012-02-26 05:29:57',1,1),(41,'marcorubio',15745368,NULL,'R',NULL,'2012-02-26 05:28:42',1,1),(42,'SharronAngle',45528439,NULL,'R',NULL,'2012-02-26 05:28:43',1,1),(43,'ToomeyForSenate',26062385,NULL,'R',NULL,'2012-02-26 05:28:44',1,1),(44,'JoeWMiller',24618431,NULL,'R',NULL,'2012-02-26 05:28:45',1,1),(45,'ChristineOD',40745568,NULL,'R',NULL,'2012-02-26 05:28:46',1,1),(46,'DrRandPaul',NULL,NULL,'R',NULL,NULL,NULL,NULL),(47,'robportman',18915145,NULL,'R',NULL,'2012-02-26 05:28:50',1,1),(48,'JimRutledge2010',64080083,NULL,'R',NULL,'2012-02-26 05:28:51',1,1),(49,'hughesforsenate',66732534,NULL,'R',NULL,'2012-02-26 05:28:52',1,1),(50,'GilbertBaker',86084103,NULL,'R',NULL,'2012-02-26 05:28:52',1,1),(51,'Ron4Senate',142332083,NULL,'R',NULL,'2012-02-26 05:28:54',1,1),(52,'MarlinStutzman',24539426,NULL,'R',NULL,'2012-02-26 05:28:56',1,1),(53,'DannyTarkanian',64465025,NULL,'R',NULL,'2012-02-26 05:28:57',1,1),(54,'BuckForColorado',34959770,NULL,'R',NULL,'2012-02-26 05:28:57',1,1),(55,'RobSimmons',26793433,NULL,'R',NULL,'2012-02-26 05:28:58',1,1),(56,'akersforsenate',112491457,NULL,'R',NULL,'2012-02-26 05:28:59',1,1),(57,'JayS2629',19173608,NULL,'R',NULL,'2012-02-26 05:28:59',1,1),(58,'Sue_Lowden',72577569,NULL,'R',NULL,'2012-02-26 05:29:00',1,1),(59,'TimBridgewater',36893259,NULL,'R',NULL,'2012-02-26 05:29:01',1,1),(60,'ayotte2010',NULL,NULL,'R',NULL,'2012-02-26 05:29:01',NULL,1),(61,'DanCoats',110893482,NULL,'R',NULL,'2012-02-26 05:29:02',1,1),(62,'DinoRossiWA',146241212,NULL,'R',NULL,'2012-02-26 05:29:03',1,1),(63,'Huffman2010',121905148,NULL,'R',NULL,'2012-02-26 05:29:03',1,1),(64,'curtiscoleman',40325258,NULL,'R',NULL,'2012-02-26 05:29:04',1,1),(65,'janenortonforco',70992473,NULL,'R',NULL,'2012-02-26 05:29:05',1,1),(66,'LindaForSenate',263256558,NULL,'R',NULL,'2012-02-26 05:29:06',1,1),(67,'JoeForUSSenate',115119048,NULL,'R',NULL,'2012-02-26 05:29:06',1,1),(68,'ovidein2010',65360070,NULL,'R',NULL,'2012-02-26 05:29:07',1,1),(69,'Townsend4NY',130563022,NULL,'R',NULL,'2012-02-26 05:29:08',1,1),(70,'Chachas4Nevada',27555666,NULL,'R',NULL,'2012-02-26 05:29:09',1,1),(71,'dbwestlake',35768975,NULL,'R',NULL,'2012-02-26 05:29:09',1,1),(72,'malpass4senate',120996776,NULL,'R',NULL,'2012-02-26 05:29:10',1,1),(73,'schiffforsenate',49841000,NULL,'R',NULL,'2012-02-26 05:29:10',1,1),(74,'VoteConrad',68454527,NULL,'R',NULL,'2012-02-26 05:29:11',1,1),(75,'hoeven4senate',106733567,NULL,'R',NULL,'2012-02-26 05:29:11',1,1),(76,'votechad',136421213,NULL,'R',NULL,'2012-02-26 05:29:12',1,1),(77,'jdhayworth2010',107776340,NULL,'R',NULL,'2012-02-26 05:29:13',1,1),(78,'KYTrey',17015011,NULL,'R',NULL,'2012-02-26 05:29:14',1,1),(79,'Britton4VT',82133482,NULL,'R',NULL,'2012-02-26 05:29:14',1,1),(80,'BillJohnson2010',41738616,NULL,'R',NULL,'2012-02-26 05:29:16',1,1),(81,'Bill_Escoffery',175285026,NULL,'R',NULL,'2012-02-26 05:29:17',1,1),(82,'Benderforsenate',80149561,NULL,'R',NULL,'2012-02-26 05:29:18',1,1),(83,'binnie2010',85103852,NULL,'R',NULL,'2012-02-26 05:29:18',1,1),(84,'Moser2010',468440598,NULL,'R',NULL,'2012-02-26 05:29:18',1,1),(85,'donbatesjr',74793319,NULL,'R',NULL,'2012-02-26 05:29:19',1,1),(86,'Blakeman2010',105666728,NULL,'R',NULL,'2012-02-26 05:29:19',1,1),(87,'alramirezUSA',21209087,NULL,'R',NULL,'2012-02-26 05:29:21',1,1),(88,'JimHolt2010',87039308,NULL,'R',NULL,'2012-02-26 05:29:21',1,1),(89,'CavassoCan',141316052,NULL,'R',NULL,'2012-02-26 05:29:22',1,1),(90,'johnhostettler',78713943,NULL,'R',NULL,'2012-02-26 05:29:22',1,1),(91,'burks4senate',120864102,NULL,'R',NULL,'2012-02-26 05:29:23',1,1),(92,'pegluksik',25559782,NULL,'R',NULL,'2012-02-26 05:29:23',1,1),(94,'ChuckPurgason',90975710,NULL,'R',NULL,'2012-02-26 05:29:24',1,1),(95,'GaryBerntsen',95604478,NULL,'R',NULL,'2012-02-26 05:29:25',1,1),(96,'DeborahASolomon',44060093,NULL,'R',NULL,'2012-02-26 05:29:26',1,1),(97,'MacforCongress',93735887,NULL,'R',NULL,'2012-02-26 05:29:26',1,1),(98,'JohnPRoco',113980088,NULL,'R',NULL,'2012-02-26 05:29:27',1,1),(99,'Didier4Senate',167616453,NULL,'R',NULL,'2012-02-26 05:29:27',1,1),(100,'mikelee2010',249472128,NULL,'R',NULL,'2012-02-26 05:29:29',1,1);
/*!40000 ALTER TABLE `politicians` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-02-26 13:16:43
