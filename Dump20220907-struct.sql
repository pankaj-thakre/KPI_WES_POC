CREATE DATABASE  IF NOT EXISTS `kpi_wes2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `kpi_wes2`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: kpi_wes2
-- ------------------------------------------------------
-- Server version	8.0.30

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-07 11:07:47
