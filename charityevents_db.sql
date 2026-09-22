-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: charityevents_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Current Database: `charityevents_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `charityevents_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `charityevents_db`;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(80) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Fun Run','Charity running and walking events'),(2,'Gala Dinner','Formal fundraising dinners'),(3,'Silent Auction','Auctions of donated items'),(4,'Concert','Musical fundraising performances'),(5,'Bake Sale','Community baking fundraisers');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(150) NOT NULL,
  `description` text,
  `purpose` varchar(255) DEFAULT NULL,
  `event_date` datetime NOT NULL,
  `location` varchar(150) NOT NULL,
  `ticket_price` decimal(10,2) DEFAULT '0.00',
  `image_url` varchar(300) DEFAULT NULL,
  `goal_amount` decimal(12,2) DEFAULT '0.00',
  `raised_amount` decimal(12,2) DEFAULT '0.00',
  `status` enum('active','suspended') DEFAULT 'active',
  `category_id` int NOT NULL,
  `org_id` int NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `fk_event_category` (`category_id`),
  KEY `fk_event_org` (`org_id`),
  CONSTRAINT `fk_event_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `fk_event_org` FOREIGN KEY (`org_id`) REFERENCES `organisations` (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'City Sunrise Fun Run','A 5km/10km run through the city at sunrise.','Raise funds for child education','2026-10-15 06:30:00','Brisbane CBD',25.00,'https://picsum.photos/seed/run/600/400',50000.00,12500.00,'active',1,1),(2,'Hope Gala Dinner','An elegant evening of dining and entertainment.','Support cancer research','2026-11-20 19:00:00','Gold Coast Hotel',150.00,'https://picsum.photos/seed/gala/600/400',100000.00,42000.00,'active',2,1),(3,'Art for Good Auction','Silent auction of local artworks.','Fund community art programs','2026-10-28 18:00:00','Sydney Art Hall',40.00,'https://picsum.photos/seed/art/600/400',30000.00,9800.00,'active',3,2),(4,'Green Earth Concert','Live music to support reforestation.','Plant 10,000 trees','2026-12-05 20:00:00','Melbourne Arena',60.00,'https://picsum.photos/seed/concert/600/400',75000.00,21000.00,'active',4,2),(5,'Community Bake Sale','A family-friendly bake sale.','Fund local food bank','2026-10-05 09:00:00','Sydney Town Hall',5.00,'https://picsum.photos/seed/bake/600/400',5000.00,1200.00,'active',5,1),(6,'Twilight 10K','An evening 10km run for mental health.','Support mental health services','2026-11-02 18:00:00','Brisbane Riverwalk',30.00,'https://picsum.photos/seed/twilight/600/400',40000.00,8000.00,'active',1,1),(7,'Charity Rock Night','Rock bands unite for a cause.','Fund youth shelters','2026-12-18 19:30:00','Perth Concert Hall',55.00,'https://picsum.photos/seed/rock/600/400',60000.00,15000.00,'active',4,2),(8,'Winter Gala 2026','Black-tie gala for children\'s hospitals.','Build a new paediatric wing','2026-09-01 18:30:00','Adelaide Grand',200.00,'https://picsum.photos/seed/winter/600/400',150000.00,150000.00,'active',2,1),(9,'Suspicious Auction','Placeholder event under review.','Pending investigation','2026-11-11 17:00:00','Unknown',20.00,'https://picsum.photos/seed/susp/600/400',10000.00,0.00,'suspended',3,2);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisations`
--

DROP TABLE IF EXISTS `organisations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisations` (
  `org_id` int NOT NULL AUTO_INCREMENT,
  `org_name` varchar(150) NOT NULL,
  `mission` text,
  `email` varchar(120) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `website` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisations`
--

LOCK TABLES `organisations` WRITE;
/*!40000 ALTER TABLE `organisations` DISABLE KEYS */;
INSERT INTO `organisations` VALUES (1,'Hope Foundation','Empowering communities through education and health.','info@hopefoundation.org','0400 111 222','https://hopefoundation.org'),(2,'Green Earth Trust','Protecting our planet for future generations.','hello@greenearth.org','0400 333 444','https://greenearth.org');
/*!40000 ALTER TABLE `organisations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-22 22:08:24
