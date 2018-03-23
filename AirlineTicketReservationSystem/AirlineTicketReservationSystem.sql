CREATE DATABASE  IF NOT EXISTS `airlinesystem` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `airlinesystem`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: airlinesystem
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Table structure for table `airplane`
--

DROP TABLE IF EXISTS `airplane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airplane` (
  `Airplane_id` int(6) NOT NULL,
  `Total_number_of_seats` int(11) NOT NULL,
  `Airplane_type` varchar(45) NOT NULL,
  PRIMARY KEY (`Airplane_id`),
  KEY `FK_AIRPLANE_AIRPLANE_TYPE` (`Airplane_type`),
  CONSTRAINT `FK_AIRPLANE_AIRPLANE_TYPE` FOREIGN KEY (`Airplane_type`) REFERENCES `airplane_type` (`Airplane_type_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airplane`
--

LOCK TABLES `airplane` WRITE;
/*!40000 ALTER TABLE `airplane` DISABLE KEYS */;
INSERT INTO `airplane` VALUES (111111,290,'737'),(111112,290,'737'),(111113,290,'737'),(111114,240,'735'),(111115,305,'A520'),(111116,170,'A380'),(111117,170,'A380'),(111118,170,'A380'),(111119,170,'A380');
/*!40000 ALTER TABLE `airplane` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airplane_type`
--

DROP TABLE IF EXISTS `airplane_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airplane_type` (
  `Airplane_type_name` varchar(45) NOT NULL,
  `Max_seats` int(11) DEFAULT NULL,
  `Company` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Airplane_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airplane_type`
--

LOCK TABLES `airplane_type` WRITE;
/*!40000 ALTER TABLE `airplane_type` DISABLE KEYS */;
INSERT INTO `airplane_type` VALUES ('735',250,'Boeing'),('737',300,'Boeing'),('777',120,'Boeing'),('A380',180,'Airbus'),('A520',315,'Airbus');
/*!40000 ALTER TABLE `airplane_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `airlinesystem`.`airplane_type_AFTER_INSERT` AFTER INSERT ON `airplane_type` FOR EACH ROW
BEGIN
	DECLARE v_Airport_code varchar(4) DEFAULT '2202';
	DECLARE finished BOOL DEFAULT FALSE;
	DECLARE Airport_code_gezen CURSOR FOR (select a.Airport_code
											 from airport a
											 where a.Capacity>=new.Max_seats);

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;
	OPEN Airport_code_gezen; 
	repeat FETCH Airport_code_gezen INTO v_Airport_code ;
		IF NOT finished THEN
			insert into can_land values(new.Airplane_type_name,v_Airport_code);
		end if;
	UNTIL finished END REPEAT;
	CLOSE Airport_code_gezen;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airport` (
  `Airport_code` varchar(4) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `City` varchar(45) NOT NULL,
  `State` varchar(45) DEFAULT NULL,
  `Capacity` int(11) NOT NULL,
  PRIMARY KEY (`Airport_code`),
  UNIQUE KEY `Airport_code_UNIQUE` (`Airport_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('ATT','Atatürk','İstanbul',NULL,300),('BER','Berlin International Airport','Berlin','Berlin',500),('ERC','Ercan','Lefkoşa',NULL,200),('NYC','New York Airport','New York','Manhattan',300),('SBH','Sabiha Gökçen','İstanbul',NULL,500);
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `airlinesystem`.`airport_AFTER_INSERT` AFTER INSERT ON `airport` FOR EACH ROW
BEGIN
	DECLARE v_Airplane_type_name varchar(45) DEFAULT 0;
	DECLARE finished BOOL DEFAULT FALSE;
	DECLARE Airplane_type_name_gezen CURSOR FOR (select a.Airplane_type_name
											 from airplane_type a
											 where a.Max_seats<=new.Capacity);

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;
	OPEN Airplane_type_name_gezen; 
	repeat FETCH Airplane_type_name_gezen INTO v_Airplane_type_name ;
		IF NOT finished THEN
			insert into can_land values(v_Airplane_type_name,new.Airport_code);
		end if;
	UNTIL finished END REPEAT;
	CLOSE Airplane_type_name_gezen;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `bilet_göster`
--

DROP TABLE IF EXISTS `bilet_göster`;
/*!50001 DROP VIEW IF EXISTS `bilet_göster`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `bilet_göster` AS SELECT 
 1 AS `Customer_name`,
 1 AS `Customer_phone`,
 1 AS `Date`,
 1 AS `Flight_number`,
 1 AS `Leg_number`,
 1 AS `Seat_number`,
 1 AS `Departure_airport_code`,
 1 AS `Arrival_airport_code`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `can_land`
--

DROP TABLE IF EXISTS `can_land`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `can_land` (
  `Airplane_type_name` varchar(45) NOT NULL,
  `Airport_code` varchar(4) NOT NULL,
  PRIMARY KEY (`Airplane_type_name`,`Airport_code`),
  KEY `FK_CAN_LAND_AIRPORT` (`Airport_code`),
  CONSTRAINT `FK_CAN_LAND_AIRPLANE_TYPE` FOREIGN KEY (`Airplane_type_name`) REFERENCES `airplane_type` (`Airplane_type_name`) ON DELETE CASCADE,
  CONSTRAINT `FK_CAN_LAND_AIRPORT` FOREIGN KEY (`Airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `can_land`
--

LOCK TABLES `can_land` WRITE;
/*!40000 ALTER TABLE `can_land` DISABLE KEYS */;
INSERT INTO `can_land` VALUES ('735','ATT'),('737','ATT'),('777','ATT'),('A380','ATT'),('735','BER'),('737','BER'),('777','BER'),('A380','BER'),('A520','BER'),('777','ERC'),('A380','ERC'),('735','NYC'),('777','NYC'),('A380','NYC'),('735','SBH'),('737','SBH'),('777','SBH'),('A380','SBH'),('A520','SBH');
/*!40000 ALTER TABLE `can_land` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fare`
--

DROP TABLE IF EXISTS `fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fare` (
  `Flight_number` int(6) NOT NULL,
  `Fare_code` int(2) NOT NULL,
  `Amount` int(6) NOT NULL,
  `Restrictions` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Flight_number`,`Fare_code`),
  CONSTRAINT `FK_FARE_FLIGHT` FOREIGN KEY (`Flight_number`) REFERENCES `flight` (`Flight_number`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fare`
--

LOCK TABLES `fare` WRITE;
/*!40000 ALTER TABLE `fare` DISABLE KEYS */;
INSERT INTO `fare` VALUES (100000,1,100,'no pets'),(100000,2,150,'no pets'),(100000,3,250,'no pets'),(100002,1,50,'no pc'),(100002,2,70,'no pc'),(100003,1,300,'no smoke'),(100003,2,500,'no smoke'),(100003,3,800,'no smoke'),(100004,1,100,'No Pets'),(100004,2,200,'No Smoke'),(100009,1,150,'No pets, no smoke.'),(100009,2,200,'No smoke.');
/*!40000 ALTER TABLE `fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight` (
  `Flight_number` int(6) NOT NULL,
  `Airline` varchar(45) NOT NULL,
  `Weekdays` varchar(8) NOT NULL,
  PRIMARY KEY (`Flight_number`),
  UNIQUE KEY `Fligth_number_UNIQUE` (`Flight_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (100000,'THY','MT'),(100001,'THY','TTWF'),(100002,'SUN','FSS'),(100003,'QAT','MTTW'),(100004,'PEG','SM'),(100009,'SUN','MTT');
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight_leg`
--

DROP TABLE IF EXISTS `flight_leg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flight_leg` (
  `Flight_number` int(6) NOT NULL,
  `Leg_number` int(2) NOT NULL,
  `Departure_airport_code` varchar(3) NOT NULL,
  `Scheduled_departure_time` time NOT NULL,
  `Arrival_airport_code` varchar(3) NOT NULL,
  `Scheduled_arrival_time` time NOT NULL,
  PRIMARY KEY (`Flight_number`,`Leg_number`),
  KEY `FK_FLIGHT_LEG_AIRPORTa` (`Arrival_airport_code`),
  KEY `FK_FLIGHT_LEG_AIRPORTd` (`Departure_airport_code`),
  CONSTRAINT `FK_FLIGHT_LEG_AIRPORTa` FOREIGN KEY (`Arrival_airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE CASCADE,
  CONSTRAINT `FK_FLIGHT_LEG_AIRPORTd` FOREIGN KEY (`Departure_airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE CASCADE,
  CONSTRAINT `FK_FLIGHT_LEG_FLIGHT` FOREIGN KEY (`Flight_number`) REFERENCES `flight` (`Flight_number`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight_leg`
--

LOCK TABLES `flight_leg` WRITE;
/*!40000 ALTER TABLE `flight_leg` DISABLE KEYS */;
INSERT INTO `flight_leg` VALUES (100000,1,'SBH','10:15:00','ERC','11:45:00'),(100000,2,'ERC','12:15:00','ATT','13:45:00'),(100001,1,'ERC','14:00:00','SBH','15:00:00'),(100001,2,'SBH','15:45:00','ATT','16:45:00'),(100003,1,'SBH','14:15:00','ERC','15:45:00'),(100004,1,'BER','19:30:00','SBH','22:15:00'),(100009,1,'SBH','20:00:00','BER','22:45:00');
/*!40000 ALTER TABLE `flight_leg` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `airlinesystem`.`flight_leg_BEFORE_INSERT_2` BEFORE INSERT ON `flight_leg` FOR EACH ROW
BEGIN
	if new.Departure_airport_code=new.Arrival_airport_code
    then
    signal sqlstate '45000' set message_text = 'Kalkis havalimanı ve iniş havalimanı aynı olamaz!';
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `leg_instance`
--

DROP TABLE IF EXISTS `leg_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `leg_instance` (
  `Flight_number` int(6) NOT NULL,
  `Leg_number` int(2) NOT NULL,
  `Date` date NOT NULL,
  `Number_of_available_seats` int(11) NOT NULL,
  `Airplane_id` int(6) NOT NULL,
  `Departure_airport_code` varchar(4) NOT NULL,
  `Departure_time` time NOT NULL,
  `Arrival_airport_code` varchar(4) DEFAULT NULL,
  `Arrival_time` time DEFAULT NULL,
  PRIMARY KEY (`Flight_number`,`Leg_number`,`Date`),
  KEY `FK_LEG_INSTANCE_AIRPLANE` (`Airplane_id`),
  KEY `FK_LEG_INSTANCE_AIRPORTd` (`Departure_airport_code`),
  KEY `FK_LEG_INSTANCE_AIRPORTa` (`Arrival_airport_code`),
  CONSTRAINT `FK_LEG_INSTANCE_AIRPLANE` FOREIGN KEY (`Airplane_id`) REFERENCES `airplane` (`Airplane_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_LEG_INSTANCE_AIRPORTa` FOREIGN KEY (`Arrival_airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE CASCADE,
  CONSTRAINT `FK_LEG_INSTANCE_AIRPORTd` FOREIGN KEY (`Departure_airport_code`) REFERENCES `airport` (`Airport_code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leg_instance`
--

LOCK TABLES `leg_instance` WRITE;
/*!40000 ALTER TABLE `leg_instance` DISABLE KEYS */;
INSERT INTO `leg_instance` VALUES (100000,1,'2017-01-10',165,111116,'SBH','10:15:00','ERC','11:45:00'),(100000,2,'2017-01-10',165,111117,'ERC','12:15:00','ATT','13:45:00'),(100001,1,'2017-03-11',165,111116,'ERC','14:00:00','SBH','15:00:00'),(100001,2,'2017-03-11',165,111118,'SBH','16:00:00','ATT','17:00:00'),(100003,1,'2017-01-12',165,111117,'SBH','14:15:00','ERC','15:45:00'),(100004,1,'2017-02-28',273,111111,'BER','19:45:00','SBH','22:30:00'),(100009,1,'2017-05-20',264,111112,'SBH','20:00:00',NULL,NULL);
/*!40000 ALTER TABLE `leg_instance` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `airlinesystem`.`leg_instance_BEFORE_INSERT` BEFORE INSERT ON `leg_instance` FOR EACH ROW
BEGIN
	if new.Departure_airport_code=new.Arrival_airport_code
    then
    signal sqlstate '45000' set message_text = 'Kalkis havalimanı ve iniş havalimanı aynı olamaz!';
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `panel`
--

DROP TABLE IF EXISTS `panel`;
/*!50001 DROP VIEW IF EXISTS `panel`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `panel` AS SELECT 
 1 AS `Flight_number`,
 1 AS `Leg_number`,
 1 AS `Scheduled_departure_time`,
 1 AS `Arrival_airport_code`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `seat_reservation`
--

DROP TABLE IF EXISTS `seat_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seat_reservation` (
  `Flight_number` int(6) NOT NULL,
  `Leg_number` int(2) NOT NULL,
  `Date` date NOT NULL,
  `Seat_number` int(5) NOT NULL,
  `Customer_name` varchar(60) DEFAULT NULL,
  `Customer_phone` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`Flight_number`,`Leg_number`,`Date`,`Seat_number`),
  CONSTRAINT `FK_SEAT_RESERVATION_FLIGHT` FOREIGN KEY (`Flight_number`) REFERENCES `flight` (`Flight_number`) ON DELETE CASCADE,
  CONSTRAINT `FK_SEAT_RESERVATION_FLIGHT_LEG` FOREIGN KEY (`Flight_number`, `Leg_number`) REFERENCES `flight_leg` (`Flight_number`, `Leg_number`) ON DELETE CASCADE,
  CONSTRAINT `FK_SEAT_RESERVATION_LEG_INSTANCE` FOREIGN KEY (`Flight_number`, `Leg_number`, `Date`) REFERENCES `leg_instance` (`Flight_number`, `Leg_number`, `Date`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat_reservation`
--

LOCK TABLES `seat_reservation` WRITE;
/*!40000 ALTER TABLE `seat_reservation` DISABLE KEYS */;
INSERT INTO `seat_reservation` VALUES (100000,1,'2017-01-10',1,'Ali Karabaş','905541232395'),(100000,1,'2017-01-10',2,'Ali Osman','905551232391'),(100000,1,'2017-01-10',3,'Ali Hüsnü','905571212395'),(100000,1,'2017-01-10',5,'Ali Kır','905541237395'),(100000,1,'2017-01-10',12,'Hüseyin Karataş','905542232395'),(100000,1,'2017-01-10',13,'Ahmet Dayıoğlu','905541232396'),(100000,1,'2017-01-10',20,'Ayşe Fatma','905541232394'),(100000,1,'2017-01-10',100,'Şahnaz Gülnar','5441818118'),(100000,2,'2017-01-10',5,'Ali Hüsnü','905571212395'),(100000,2,'2017-01-10',10,'Ayşe Fatma','905541232394'),(100000,2,'2017-01-10',21,'Ali Osman','905551232391'),(100000,2,'2017-01-10',22,'Ali Kır','905541237395'),(100000,2,'2017-01-10',32,'Hüseyin Karataş','905542232395'),(100000,2,'2017-01-10',53,'Ahmet Dayıoğlu','905541232396'),(100000,2,'2017-01-10',99,'Hayrullah Karabaş','905541111395'),(100001,1,'2017-03-11',11,'Nur Fatma','905541232122'),(100001,1,'2017-03-11',21,'Şengül Kır','905541227495'),(100001,1,'2017-03-11',27,'Ali Gülnur','905551288891'),(100001,1,'2017-03-11',31,'Hüseyin Merto','905548152395'),(100001,1,'2017-03-11',51,'Ali Mert','905571212122'),(100001,1,'2017-03-11',54,'Ahmet Güleşen','905546542396'),(100001,1,'2017-03-11',92,'Hayriye Kara','905551161323'),(100001,1,'2017-03-11',96,'Nurcan Karatay','905051441315'),(100001,1,'2017-03-11',99,'Hayrullah Karabaş','905541111395'),(100001,2,'2017-03-11',1,'Nur Fatma','905541232122'),(100001,2,'2017-03-11',2,'Şengül Kır','905541227495'),(100001,2,'2017-03-11',4,'Ali Gülnur','905551288891'),(100001,2,'2017-03-11',6,'Hüseyin Merto','905548152395'),(100001,2,'2017-03-11',10,'Aydan Candaş','905061239122'),(100001,2,'2017-03-11',11,'Külhan Candaş','905051239728'),(100001,2,'2017-03-11',66,'Mertcan Ali Tosun','905061282138'),(100003,1,'2017-01-12',1,'Meliscan Kıraç','905599927495'),(100003,1,'2017-01-12',17,'Emre Fatma','905541777122'),(100003,1,'2017-01-12',18,'Nur Karaca','905557821323'),(100003,1,'2017-01-12',33,'Halide Mert','905548888395'),(100003,1,'2017-01-12',55,'Emrecan Güleşen','905079892396'),(100003,1,'2017-01-12',66,'Nurcan Osman','905576441315'),(100003,1,'2017-01-12',73,'Alihan Can','905551281891'),(100003,1,'2017-01-12',88,'Alican Mertcan','905571212922'),(100003,1,'2017-01-12',91,'Mert Kara','905541676395'),(100004,1,'2017-02-28',1,'Sabri Algöz','05383510691'),(100004,1,'2017-02-28',2,'Can Algöz','05355556681'),(100004,1,'2017-02-28',3,'Şengül Algöz','05551119954'),(100004,1,'2017-02-28',18,'Ali Kırbaç','05031119832'),(100004,1,'2017-02-28',21,'Nurullah Ali Türk','05311188043'),(100004,1,'2017-02-28',29,'Şeyma Ateş','05438906734'),(100004,1,'2017-02-28',158,'Kibariye Hüsnüşengül','05335547896'),(100004,1,'2017-02-28',165,'Semih Saygıner','05661237893'),(100004,1,'2017-02-28',203,'Türker Hacınur','05451269829'),(100004,1,'2017-02-28',204,'Şengülcan Hacınur','05451159821'),(100009,1,'2017-05-20',5,'Çağlayan Gürses','905381198956'),(100009,1,'2017-05-20',10,'Recep Kıvrılan','905389996588'),(100009,1,'2017-05-20',18,'Hüseyin Can Gülsen','905411167835'),(100009,1,'2017-05-20',71,'Recep Sağlı','905551119948'),(100009,1,'2017-05-20',117,'Herkül Alioğlu','905569345601'),(100009,1,'2017-05-20',145,'Ümmüşen Güleç','905311759842');
/*!40000 ALTER TABLE `seat_reservation` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `airlinesystem`.`seat_reservation_BEFORE_INSERT` BEFORE INSERT ON `seat_reservation` FOR EACH ROW
BEGIN
	declare maxKoltuk int(3) default 0;
    set maxKoltuk = ( select a.Number_of_available_seats from leg_instance a where a.Flight_number=new.Flight_number and a.Leg_number=new.Leg_number and a.Date=new.Date );
    if new.Seat_number>maxKoltuk
    then
    signal sqlstate '45000' set message_text = 'Uygun koltuk sayısından büyük numaralı koltuk girişi yapılamaz!';
	end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `airlinesystem`.`seat_reservation_AFTER_INSERT` AFTER INSERT ON `seat_reservation` FOR EACH ROW
BEGIN
	update leg_instance
    set Number_of_available_seats=Number_of_available_seats-1
    where Flight_number=new.Flight_number and Leg_number=new.Leg_number and Date=new.Date;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'airlinesystem'
--

--
-- Final view structure for view `bilet_göster`
--

/*!50001 DROP VIEW IF EXISTS `bilet_göster`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bilet_göster` AS select `a`.`Customer_name` AS `Customer_name`,`a`.`Customer_phone` AS `Customer_phone`,`a`.`Date` AS `Date`,`a`.`Flight_number` AS `Flight_number`,`a`.`Leg_number` AS `Leg_number`,`a`.`Seat_number` AS `Seat_number`,`b`.`Departure_airport_code` AS `Departure_airport_code`,`b`.`Arrival_airport_code` AS `Arrival_airport_code` from (`seat_reservation` `a` join `flight_leg` `b` on(((`a`.`Flight_number` = `b`.`Flight_number`) and (`a`.`Leg_number` = `b`.`Leg_number`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `panel`
--

/*!50001 DROP VIEW IF EXISTS `panel`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `panel` AS select `a`.`Flight_number` AS `Flight_number`,`a`.`Leg_number` AS `Leg_number`,`b`.`Scheduled_departure_time` AS `Scheduled_departure_time`,`b`.`Arrival_airport_code` AS `Arrival_airport_code` from (`leg_instance` `a` join `flight_leg` `b`) where ((`a`.`Flight_number` = `b`.`Flight_number`) and (`a`.`Leg_number` = `b`.`Leg_number`) and (`a`.`Departure_airport_code` = 'SBH')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-04 23:53:22
