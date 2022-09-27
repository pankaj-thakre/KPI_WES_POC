CREATE DATABASE  IF NOT EXISTS `kpi_wes2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `kpi_wes2`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: kpi_wes2
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `flow_steps`
--

DROP TABLE IF EXISTS `flow_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flow_steps` (
  `FlowID` int NOT NULL,
  `StepID` int NOT NULL,
  `StepOrder` int DEFAULT NULL,
  KEY `FlowID` (`FlowID`),
  KEY `StepID` (`StepID`),
  CONSTRAINT `flow_steps_ibfk_1` FOREIGN KEY (`FlowID`) REFERENCES `flows` (`ID`),
  CONSTRAINT `flow_steps_ibfk_2` FOREIGN KEY (`StepID`) REFERENCES `steps` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_steps`
--

LOCK TABLES `flow_steps` WRITE;
/*!40000 ALTER TABLE `flow_steps` DISABLE KEYS */;
INSERT INTO `flow_steps` VALUES (7,1,1),(7,2,2),(8,4,1),(9,5,1),(10,15,1),(11,4,1),(12,6,1),(12,2,2),(13,7,1);
/*!40000 ALTER TABLE `flow_steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flows`
--

DROP TABLE IF EXISTS `flows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flows` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `StrategyName` varchar(255) DEFAULT NULL,
  `FlowType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flows`
--

LOCK TABLES `flows` WRITE;
/*!40000 ALTER TABLE `flows` DISABLE KEYS */;
INSERT INTO `flows` VALUES (7,'Carton Erector Build','Storage Location Build','CEB'),(8,'Transport to Picking','Transport','TP'),(9,'Heavy Single Line Picking','Picking','HSLP'),(10,'AutoStore Picking','Picking','AP'),(11,'Transport to Packing','Transport','TPK'),(12,'PANDA','Packing','PANDA'),(13,'Transport to Ship Sorter','Transport','TSS');
/*!40000 ALTER TABLE `flows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hardware`
--

DROP TABLE IF EXISTS `hardware`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hardware` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `Model` varchar(255) DEFAULT NULL,
  `WeightCapacity` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hardware`
--

LOCK TABLES `hardware` WRITE;
/*!40000 ALTER TABLE `hardware` DISABLE KEYS */;
INSERT INTO `hardware` VALUES (1,'EAGLE','CARTON ERECTOR','T20CF',NULL),(2,'Windows 11 ','PORTAL','Win 11 ',NULL),(3,'Zebra','SCANNER',' DS4308-XD (IDENTIFER)',NULL),(4,'RARUK','AMR','MiR1000 (IDENTIFIER)',NULL),(5,'Swisslog','Heavy Lifting Arm','ItemPiQ',NULL),(6,'Conveyor- I','Conveyor','ID-121',NULL),(7,'Conveyor  - II','Conveyor','ID-122',NULL);
/*!40000 ALTER TABLE `hardware` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ParentID` int DEFAULT NULL,
  `InventoryType` varchar(255) DEFAULT NULL,
  `LPN` varchar(200) DEFAULT NULL,
  `Quantity` varchar(200) DEFAULT NULL,
  `HardwareID` int DEFAULT NULL,
  `ItemID` int DEFAULT NULL,
  `Setting1` varchar(200) DEFAULT NULL,
  `Setting2` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `HardwareID` (`HardwareID`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`HardwareID`) REFERENCES `hardware` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,NULL,'Electronic Good','P-100','1',1,1,'Setting-I','Setting-II'),(2,NULL,'Electronic Good','L-200','1',1,2,'Setting-I','Setting-II'),(3,NULL,'Electronic Good','T-300','1',4,3,'Setting-I','Setting-II'),(4,NULL,'Electronic Good','M-400','1',5,4,'Setting-I','Setting-II'),(5,NULL,'Electronic Good','H-500','1',7,5,'Setting-I','Setting-II'),(6,NULL,'Storage Location','R-222','1',3,6,'Setting-I','Setting-II'),(7,NULL,'Storage Location','B-333','1',1,7,'Setting-I','Setting-II'),(8,7,'Electronic Good','M-400','1',5,4,'Setting-I','Setting-II'),(9,6,'Electronic Good','L-200','1',1,2,'Setting-I','Setting-II'),(10,6,'Electronic Good','P-100','1',1,1,'Setting-I','Setting-I'),(11,7,'Electronic Good','H-500','1',7,5,'Setting-I','Setting-II');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Category` varchar(255) DEFAULT NULL,
  `Weight` varchar(255) DEFAULT NULL,
  `Dimensions` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Printer','Goods','5','20x10x5'),(2,'Laptop','Goods','7','10x10x5'),(3,'Television','Goods','12.5','40x20x5'),(4,'Mobile','Goods','1','5x5'),(5,'Headphones','Goods','2','7x7'),(6,'Racks','Storage','100','150x150x15'),(7,'Bins','Storage','20','30x30x15');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ParentID` int DEFAULT NULL,
  `OrderID` int NOT NULL,
  `LogName` varchar(255) NOT NULL,
  `Created` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (123,0,59,'ORDER 59 received from external system (Order Type: Picking)','2022-09-23 14:56:16'),(124,123,59,'WESFC locating Inentory','2022-09-23 14:56:17'),(125,123,59,'WESFC located item 3 in Storage Location 0','2022-09-23 14:56:17'),(126,123,59,'WESFC started Transport to Picking Zone Workflow','2022-09-23 14:56:17'),(127,125,59,'WESFC send command to AMR for hardware RARUK','2022-09-23 14:56:17'),(128,127,59,'Received Response from AMR (Success)','2022-09-23 14:56:17'),(129,128,59,'WESFC send command to AMR for hardware RARUK','2022-09-23 14:56:18'),(130,126,59,'WESFC started flow Heavy Single Line Picking','2022-09-23 14:56:18'),(131,129,59,'Received Response from AMR (Success)','2022-09-23 14:56:18'),(132,0,60,'ORDER 60 received from external system (Order Type: Picking)','2022-09-23 14:57:38'),(133,132,60,'WESFC locating Inentory','2022-09-23 14:57:38'),(134,132,60,'WESFC located item 3 in Storage Location 0','2022-09-23 14:57:38'),(135,132,60,'WESFC started Transport to Picking Zone Workflow','2022-09-23 14:57:38'),(136,139,60,'WESFC send command to AMR for hardware RARUK','2022-09-23 14:57:38'),(137,136,60,'Received Response from AMR (Success)','2022-09-23 14:57:39'),(138,139,60,'WESFC send command to AMR for hardware RARUK','2022-09-23 14:57:39'),(139,135,60,'WESFC started flow Heavy Single Line Picking','2022-09-23 14:57:39'),(140,138,60,'Received Response from AMR (Success)','2022-09-23 14:57:39');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_workflow_flow`
--

DROP TABLE IF EXISTS `order_workflow_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_workflow_flow` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `WorkflowFlowID` int NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_workflow_flow`
--

LOCK TABLES `order_workflow_flow` WRITE;
/*!40000 ALTER TABLE `order_workflow_flow` DISABLE KEYS */;
INSERT INTO `order_workflow_flow` VALUES (23,1,7,1),(24,2,7,1),(25,3,9,1),(26,4,8,1),(27,5,10,1),(28,6,10,1),(29,7,9,1),(30,8,9,1),(31,9,9,1),(32,10,9,1),(33,11,9,1),(34,12,9,1),(35,17,9,1),(36,18,9,1),(37,19,9,1),(38,20,9,1),(39,21,9,1),(40,22,9,1),(41,23,9,1),(42,24,9,1),(43,25,9,1),(44,26,9,1),(45,27,9,1),(46,28,9,1),(47,29,9,1),(48,30,9,1),(49,32,9,1),(50,33,9,1),(51,34,9,1),(52,35,9,1),(53,36,9,1),(54,37,9,1),(55,38,9,1),(56,39,9,1),(57,40,9,1),(58,41,9,1),(59,42,9,1),(60,43,9,1),(61,45,9,1),(62,46,9,1),(63,47,9,1),(64,48,9,1),(65,49,9,1),(66,50,9,1),(67,53,9,1),(68,54,9,1),(69,55,9,1),(70,56,9,1),(71,57,9,1),(72,58,9,1),(73,59,9,1),(74,60,9,1);
/*!40000 ALTER TABLE `order_workflow_flow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_workflow_flow_steps`
--

DROP TABLE IF EXISTS `order_workflow_flow_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_workflow_flow_steps` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `OrderWorkflowFlowID` int NOT NULL,
  `step_status` varchar(50) DEFAULT NULL,
  `stepID` int DEFAULT NULL,
  `flowID` int DEFAULT NULL,
  `workflowID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `OrderWorkflowFlowID` (`OrderWorkflowFlowID`),
  CONSTRAINT `order_workflow_flow_steps_ibfk_1` FOREIGN KEY (`OrderWorkflowFlowID`) REFERENCES `order_workflow_flow` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_workflow_flow_steps`
--

LOCK TABLES `order_workflow_flow_steps` WRITE;
/*!40000 ALTER TABLE `order_workflow_flow_steps` DISABLE KEYS */;
INSERT INTO `order_workflow_flow_steps` VALUES (1,23,'In-Progress',1,7,7),(2,23,'To-Do',2,7,7),(3,23,'To-Do',3,7,7),(4,23,'To-Do',4,8,7),(5,23,'To-Do',5,9,7),(6,23,'To-Do',4,8,7),(7,23,'To-Do',15,10,7),(8,23,'To-Do',4,11,7),(9,23,'To-Do',6,12,7),(10,23,'To-Do',2,12,7),(11,23,'To-Do',3,12,7),(12,23,'To-Do',7,13,7),(13,24,'In-Progress',1,7,7),(14,24,'To-Do',2,7,7),(15,24,'To-Do',3,7,7),(16,24,'To-Do',4,8,7),(17,24,'To-Do',5,9,7),(18,24,'To-Do',4,8,7),(19,24,'To-Do',15,10,7),(20,24,'To-Do',4,11,7),(21,24,'To-Do',6,12,7),(22,24,'To-Do',2,12,7),(23,24,'To-Do',3,12,7),(24,24,'To-Do',7,13,7),(25,25,'In-Progress',4,8,9),(26,25,'To-Do',4,11,9),(27,26,'In-Progress',5,9,8),(28,26,'To-Do',4,8,8),(29,26,'To-Do',1,7,8),(30,26,'To-Do',2,7,8),(31,26,'To-Do',3,7,8),(32,26,'To-Do',6,12,8),(33,26,'To-Do',2,12,8),(34,26,'To-Do',3,12,8),(35,26,'To-Do',7,13,8),(36,27,'In-Progress',6,12,10),(37,27,'To-Do',2,12,10),(38,27,'To-Do',3,12,10),(39,27,'To-Do',7,13,10),(40,28,'In-Progress',6,12,10),(41,28,'To-Do',2,12,10),(42,28,'To-Do',3,12,10),(43,28,'To-Do',7,13,10),(44,39,'In-Progress',4,8,9),(45,40,'In-Progress',4,8,9),(46,41,'In-Progress',4,8,9),(47,42,'In-Progress',4,8,9),(48,43,'In-Progress',4,8,9),(49,43,'To-Do',4,11,9),(50,44,'In-Progress',4,8,9),(51,44,'To-Do',4,11,9),(52,45,'In-Progress',4,8,9),(53,45,'To-Do',4,11,9),(54,55,'In-Progress',4,8,9),(55,56,'In-Progress',4,8,9),(56,56,'To-Do',4,11,9),(57,66,'In-Progress',4,8,9),(58,66,'To-Do',4,11,9),(59,67,'In-Progress',4,8,9),(60,67,'To-Do',4,11,9),(61,69,'In-Progress',4,8,9),(62,70,'In-Progress',4,8,9),(63,70,'To-Do',4,11,9),(64,71,'In-Progress',4,8,9),(65,71,'To-Do',4,11,9),(66,72,'In-Progress',4,8,9),(67,72,'To-Do',4,11,9),(68,73,'In-Progress',4,8,9),(69,73,'To-Do',4,11,9),(70,74,'In-Progress',4,8,9),(71,74,'To-Do',4,11,9);
/*!40000 ALTER TABLE `order_workflow_flow_steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `OrderType` varchar(250) DEFAULT NULL,
  `OrderDateTime` datetime NOT NULL,
  `InventoryID` int NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `Quantity` varchar(50) DEFAULT NULL,
  `WorkflowID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `WorkflowID` (`WorkflowID`),
  KEY `InventoryID` (`InventoryID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`WorkflowID`) REFERENCES `workflows` (`ID`),
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`InventoryID`) REFERENCES `inventory` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'CEB','2022-08-31 00:08:00',1,NULL,'1',7),(2,'CEB','2022-08-31 00:08:00',2,NULL,'1',7),(3,'TP','2022-08-31 00:08:00',3,NULL,'1',9),(4,'HSLP','2022-08-31 00:08:00',4,NULL,'1',8),(5,'PANDA','2022-08-31 00:08:00',5,NULL,'1',10),(6,'PANDA','2022-08-31 00:08:00',5,NULL,'1',10),(29,'PPP','2022-09-22 22:46:00',3,NULL,'1',9),(30,'PPP','2022-09-22 22:46:00',3,NULL,'1',9),(31,'PPP','2022-09-22 22:46:00',3,NULL,'1',9),(32,'PPP','2022-09-22 22:46:00',3,NULL,'1',9),(33,'Picking','2022-09-22 22:46:00',3,NULL,'1',9),(34,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(35,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(36,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(37,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(38,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(39,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(40,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(41,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(42,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(43,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(44,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(45,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(46,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(47,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(48,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(49,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(50,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(51,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(52,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(53,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(54,'Picking','2022-09-22 23:20:00',3,NULL,'1',9),(55,'Picking','2022-09-23 16:20:00',3,NULL,'1',9),(56,'Picking','2022-09-23 18:40:00',3,NULL,'1',9),(57,'Picking','2022-09-23 18:40:00',3,NULL,'1',9),(58,'Picking','2022-09-23 18:40:00',3,NULL,'1',9),(59,'Picking','2022-09-23 18:40:00',3,NULL,'1',9),(60,'Picking','2022-09-23 18:40:00',3,NULL,'1',9);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `steps`
--

DROP TABLE IF EXISTS `steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `steps` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Type` varchar(255) DEFAULT NULL,
  `HardwareID` int DEFAULT NULL,
  `Setting1` varchar(255) DEFAULT NULL,
  `Setting2` varchar(255) DEFAULT NULL,
  `Elapsed` time DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `steps`
--

LOCK TABLES `steps` WRITE;
/*!40000 ALTER TABLE `steps` DISABLE KEYS */;
INSERT INTO `steps` VALUES (1,'Carton Erector',NULL,1,'Setting-I','Setting-II','00:00:12'),(2,'Scanner with Portal',NULL,2,'Setting-I','Setting-II',NULL),(3,'Scanner',NULL,3,'Setting-I','Setting-II',NULL),(4,'AMR',NULL,4,'Setting-I','Setting-II',NULL),(5,'Heavy Lifting Arm',NULL,5,'Setting-I','Setting-II','00:00:47'),(6,'Conveyco',NULL,7,'Setting-I','Setting-II',NULL),(7,'Conveyor',NULL,6,'Setting-I','Setting-II',NULL),(15,'AutoStore',NULL,1,'AutoStore Setting','Setting-II',NULL);
/*!40000 ALTER TABLE `steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage_locations`
--

DROP TABLE IF EXISTS `storage_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage_locations` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) NOT NULL,
  `BuildingNo` varchar(200) NOT NULL,
  `BlockNo` varchar(200) NOT NULL,
  `HardwareID` int DEFAULT NULL,
  `LPN` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `HardwareID` (`HardwareID`),
  CONSTRAINT `storage_locations_ibfk_1` FOREIGN KEY (`HardwareID`) REFERENCES `hardware` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_locations`
--

LOCK TABLES `storage_locations` WRITE;
/*!40000 ALTER TABLE `storage_locations` DISABLE KEYS */;
INSERT INTO `storage_locations` VALUES (111,'Test Location','123','22',4,'LS23423');
/*!40000 ALTER TABLE `storage_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_flows`
--

DROP TABLE IF EXISTS `workflow_flows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workflow_flows` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `WorkflowID` int NOT NULL,
  `FlowID` int NOT NULL,
  `FlowOrder` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `WorkflowID` (`WorkflowID`),
  KEY `FlowID` (`FlowID`),
  CONSTRAINT `workflow_flows_ibfk_1` FOREIGN KEY (`WorkflowID`) REFERENCES `workflows` (`ID`),
  CONSTRAINT `workflow_flows_ibfk_2` FOREIGN KEY (`FlowID`) REFERENCES `flows` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_flows`
--

LOCK TABLES `workflow_flows` WRITE;
/*!40000 ALTER TABLE `workflow_flows` DISABLE KEYS */;
INSERT INTO `workflow_flows` VALUES (8,7,7,'1'),(9,7,8,'2'),(10,7,9,'3'),(11,7,8,'4'),(12,7,10,'5'),(13,7,11,'6'),(14,7,12,'7'),(15,7,13,'8'),(16,8,7,'3'),(17,8,8,'2'),(18,8,9,'1'),(19,8,12,'4'),(20,8,13,'5'),(21,9,8,'1'),(22,9,11,'2'),(23,10,12,'1'),(24,10,13,'2'),(25,11,7,'1'),(26,11,8,'2'),(27,11,9,'3'),(28,11,11,'4'),(29,11,12,'5'),(30,11,13,'6');
/*!40000 ALTER TABLE `workflow_flows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflows`
--

DROP TABLE IF EXISTS `workflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workflows` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `StorageLocationID` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflows`
--

LOCK TABLES `workflows` WRITE;
/*!40000 ALTER TABLE `workflows` DISABLE KEYS */;
INSERT INTO `workflows` VALUES (7,'Heavy Multi Line Work Flow',0),(8,'Heavy Single Line Work Flow',0),(9,'Transport to Picking Zone',0),(10,'PANDA Flow',0),(11,'Heavy Single Line Work Flow',0);
/*!40000 ALTER TABLE `workflows` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-27 10:30:54
