CREATE DATABASE  IF NOT EXISTS `kpi_wes` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `kpi_wes`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: kpi_wes
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
INSERT INTO `flow_steps` VALUES (1,1,1),(1,2,2),(2,4,1),(3,5,1),(4,6,1),(4,2,2);
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
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flows`
--

LOCK TABLES `flows` WRITE;
/*!40000 ALTER TABLE `flows` DISABLE KEYS */;
INSERT INTO `flows` VALUES (1,'Carton Erector Build','Storage Location Build'),(2,'Transport to Picking','Transport'),(3,'Heavy Single Line Picking','Picking'),(4,'PANDA','Picking'),(5,'Transport to Ship Sorter','Transport');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hardware`
--

LOCK TABLES `hardware` WRITE;
/*!40000 ALTER TABLE `hardware` DISABLE KEYS */;
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
  `ItemID` int NOT NULL,
  `StorageLocationID` int NOT NULL,
  `InventoryType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ItemID` (`ItemID`),
  KEY `StorageLocationID` (`StorageLocationID`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ID`),
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`StorageLocationID`) REFERENCES `storage_locations` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (11,1,1,'Test Inventory');
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
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Test','TEst Cat','22');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
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
  PRIMARY KEY (`ID`),
  KEY `WorkflowFlowID` (`WorkflowFlowID`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `order_workflow_flow_ibfk_2` FOREIGN KEY (`WorkflowFlowID`) REFERENCES `workflow_flows` (`ID`),
  CONSTRAINT `order_workflow_flow_ibfk_3` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_workflow_flow`
--

LOCK TABLES `order_workflow_flow` WRITE;
/*!40000 ALTER TABLE `order_workflow_flow` DISABLE KEYS */;
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
  PRIMARY KEY (`ID`),
  KEY `OrderWorkflowFlowID` (`OrderWorkflowFlowID`),
  CONSTRAINT `order_workflow_flow_steps_ibfk_1` FOREIGN KEY (`OrderWorkflowFlowID`) REFERENCES `order_workflow_flow` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_workflow_flow_steps`
--

LOCK TABLES `order_workflow_flow_steps` WRITE;
/*!40000 ALTER TABLE `order_workflow_flow_steps` DISABLE KEYS */;
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
  `OrderDateTime` datetime NOT NULL,
  `ItemID` int NOT NULL,
  `CustomerName` varchar(255) NOT NULL,
  `CustomerAddress` varchar(255) NOT NULL,
  `ShippingDate` datetime NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `Quantity` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ItemID` (`ItemID`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
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
  `Type` varchar(255) NOT NULL,
  `HardwareID` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `steps`
--

LOCK TABLES `steps` WRITE;
/*!40000 ALTER TABLE `steps` DISABLE KEYS */;
INSERT INTO `steps` VALUES (1,'Carton Erector','Hardware Type',NULL),(2,'Portal','Hardware Type',NULL),(3,'Scanner','Hardware Type',NULL),(4,'AMR','Transport',NULL),(5,'Heavy Lifting Arm','Hardware Type',NULL),(6,'Conveyco','Hardware Type',NULL),(7,'Conveyor','Hardware Type',NULL);
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
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_locations`
--

LOCK TABLES `storage_locations` WRITE;
/*!40000 ALTER TABLE `storage_locations` DISABLE KEYS */;
INSERT INTO `storage_locations` VALUES (1,'First Location','23424','4234'),(2,'Second Location','1234','321');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_flows`
--

LOCK TABLES `workflow_flows` WRITE;
/*!40000 ALTER TABLE `workflow_flows` DISABLE KEYS */;
INSERT INTO `workflow_flows` VALUES (1,1,1,'1'),(2,1,2,'2'),(3,2,4,'1');
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
  `StorageLocationID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `StorageLocationID` (`StorageLocationID`),
  CONSTRAINT `workflows_ibfk_1` FOREIGN KEY (`StorageLocationID`) REFERENCES `storage_locations` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflows`
--

LOCK TABLES `workflows` WRITE;
/*!40000 ALTER TABLE `workflows` DISABLE KEYS */;
INSERT INTO `workflows` VALUES (1,'Heavy Single Line Work Flow',1),(2,'Heavy Multi Line Work Flow',2);
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

-- Dump completed on 2022-08-25 13:23:49
