-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: kpi_monitoring_system
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `activity_directions`
--

DROP TABLE IF EXISTS `activity_directions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_directions` (
  `direction_id` int NOT NULL AUTO_INCREMENT,
  `direction_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`direction_id`),
  UNIQUE KEY `direction_name` (`direction_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_directions`
--

LOCK TABLES `activity_directions` WRITE;
/*!40000 ALTER TABLE `activity_directions` DISABLE KEYS */;
INSERT INTO `activity_directions` VALUES (1,'Клиентская поддержка','2025-11-08 11:14:55','2025-11-08 11:14:55'),(2,'Техническая поддержка','2025-11-08 11:14:55','2025-11-08 11:14:55'),(3,'Продажи','2025-11-08 11:14:55','2025-11-08 11:14:55');
/*!40000 ALTER TABLE `activity_directions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calculated_metrics`
--

DROP TABLE IF EXISTS `calculated_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calculated_metrics` (
  `calculation_id` int NOT NULL AUTO_INCREMENT,
  `record_id` int NOT NULL COMMENT 'идентификатор записи ежедневных показателей',
  `metric_id` int NOT NULL,
  `calculated_value` decimal(10,4) NOT NULL COMMENT 'значение показателя',
  `period_type` enum('День','Неделя','Месяц') NOT NULL COMMENT 'Период усреднения',
  `calculation_date` date NOT NULL COMMENT 'Дата расчета показателя',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи',
  PRIMARY KEY (`calculation_id`),
  KEY `metric_id` (`metric_id`),
  KEY `calculated_metrics_ibfk_1` (`record_id`),
  CONSTRAINT `calculated_metrics_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `daily_metrics` (`record_id`) ON DELETE CASCADE,
  CONSTRAINT `calculated_metrics_ibfk_2` FOREIGN KEY (`metric_id`) REFERENCES `metrics` (`metric_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calculated_metrics`
--

LOCK TABLES `calculated_metrics` WRITE;
/*!40000 ALTER TABLE `calculated_metrics` DISABLE KEYS */;
INSERT INTO `calculated_metrics` VALUES (1,87,2,30.7692,'День','2024-11-08','2025-11-08 11:55:29'),(2,93,2,17.6471,'День','2024-11-12','2025-11-08 11:55:29'),(4,87,3,7.0222,'День','2024-11-08','2025-11-08 11:55:29'),(5,93,3,9.3333,'День','2024-11-12','2025-11-08 11:55:29'),(7,87,4,0.0000,'День','2024-11-08','2025-11-08 11:55:29'),(8,93,4,0.0000,'День','2024-11-12','2025-11-08 11:55:29'),(10,87,5,8.5443,'День','2024-11-08','2025-11-08 11:55:29'),(11,93,5,6.4286,'День','2024-11-12','2025-11-08 11:55:29');
/*!40000 ALTER TABLE `calculated_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_metrics`
--

DROP TABLE IF EXISTS `daily_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_metrics` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `report_date` date NOT NULL,
  `processed_requests` int DEFAULT '0' COMMENT 'кол-во обработанных обращений',
  `work_minutes` int DEFAULT '0' COMMENT 'время работы в минутах',
  `positive_feedbacks` int DEFAULT '0' COMMENT 'кол-во положительных оценок',
  `total_feedbacks` int DEFAULT '0' COMMENT 'общее кол-во полученных оценок',
  `first_contact_resolved` int DEFAULT '0' COMMENT 'кол-во обращений, решенных при первом контакте',
  `total_requests` int DEFAULT '0' COMMENT 'общее кол-во обращений',
  `quality_score` decimal(5,2) DEFAULT '0.00' COMMENT 'суммарный балл за контроль качества',
  `checked_requests` int DEFAULT '0' COMMENT 'кол-во проверенных обращений',
  `verification_status` enum('Ожидание','Одобрено','Отклонено') DEFAULT 'Ожидание' COMMENT 'статус проверки',
  `reviewer_comment` text COMMENT 'комментарий проверяющего рука',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`record_id`),
  UNIQUE KEY `unique_employee_date` (`employee_id`,`report_date`),
  KEY `idx_daily_metrics_date` (`report_date`),
  CONSTRAINT `daily_metrics_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_metrics`
--

LOCK TABLES `daily_metrics` WRITE;
/*!40000 ALTER TABLE `daily_metrics` DISABLE KEYS */;
INSERT INTO `daily_metrics` VALUES (85,6,'2024-11-07',35,531,5,10,3,62,0.00,35,'Ожидание',NULL,'2025-11-08 11:50:14','2025-11-08 11:55:02'),(87,6,'2024-11-08',45,316,5,7,4,13,0.00,23,'Одобрено',NULL,'2025-11-08 11:50:58','2025-11-08 11:55:02'),(93,6,'2024-11-12',45,420,5,6,3,17,0.00,54,'Одобрено',NULL,'2025-11-08 11:53:22','2025-11-08 11:55:12');
/*!40000 ALTER TABLE `daily_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `direction_id` int NOT NULL,
  `department_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`department_id`),
  KEY `direction_id` (`direction_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`direction_id`) REFERENCES `activity_directions` (`direction_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,1,'Первичная поддержка','2025-11-08 11:14:59','2025-11-08 11:14:59'),(2,1,'Эскалация проблем','2025-11-08 11:14:59','2025-11-08 11:14:59'),(3,2,'Технические специалисты','2025-11-08 11:14:59','2025-11-08 11:14:59');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `group_id` int NOT NULL,
  `role` enum('Сотрудник','Руководитель группы','Руководитель отдела') NOT NULL DEFAULT 'Сотрудник',
  `hire_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Активен','Уволен','В отпуске') DEFAULT 'Активен',
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `username` (`username`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `work_groups` (`group_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'petrov.ao','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Петров','Алексей','Олегович',1,'Руководитель отдела','2020-03-14 19:00:00','Активен'),(2,'ivanova_ea','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Иванова','Елена','Александровна',3,'Руководитель отдела','2019-11-19 19:00:00','Активен'),(3,'sidorova_im','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Сидорова','Ирина','Михайловна',1,'Руководитель группы','2021-06-09 19:00:00','Активен'),(4,'kozlov_dv','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Козлов','Дмитрий','Владимирович',2,'Руководитель группы','2022-01-24 19:00:00','Активен'),(5,'fedorova_os','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Федорова','Ольга','Сергеевна',3,'Руководитель группы','2021-09-13 19:00:00','Активен'),(6,'smirnov_ap','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Смирнов','Андрей','Петрович',1,'Сотрудник','2023-02-09 19:00:00','Активен'),(7,'volkova_ek','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Волкова','Екатерина','Константиновна',1,'Сотрудник','2023-03-14 19:00:00','Активен'),(8,'nikitin_rs','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Никитин','Роман','Сергеевич',1,'Сотрудник','2023-05-19 19:00:00','В отпуске'),(9,'orlova_ma','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Орлова','Мария','Алексеевна',2,'Сотрудник','2023-04-04 19:00:00','Активен'),(10,'belov_da','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Белов','Даниил','Андреевич',2,'Сотрудник','2023-06-11 19:00:00','Активен'),(11,'guseva_ia','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Гусева','Ирина','Анатольевна',2,'Сотрудник','2023-01-29 19:00:00','Активен'),(12,'popov_ms','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Попов','Максим','Степанович',3,'Сотрудник','2022-08-21 19:00:00','Активен'),(13,'kuznetsova_aa','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Кузнецова','Анна','Аркадьевна',3,'Сотрудник','2022-11-17 19:00:00','Активен'),(14,'vorobev_pk','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Воробьев','Павел','Кириллович',3,'Сотрудник','2023-07-07 19:00:00','Активен'),(15,'sokolov_va','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Соколов','Виктор','Александрович',4,'Сотрудник','2023-08-13 19:00:00','Активен'),(16,'efimova_na','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Ефимова','Наталья','Андреевна',5,'Сотрудник','2023-09-24 19:00:00','Активен'),(17,'morozov_is','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Морозов','Илья','Семенович',6,'Сотрудник','2023-10-29 19:00:00','Активен'),(18,'zaytsev_rm','$2y$10$rQdJk6X8c8W9vYbLqP5ZzOJkXqWm8nR7sVcC3bN2mM1pQrS5tG6C','Зайцев','Роман','Максимович',1,'Сотрудник','2022-11-30 19:00:00','Уволен');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics`
--

DROP TABLE IF EXISTS `metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics` (
  `metric_id` int NOT NULL AUTO_INCREMENT,
  `metric_name` varchar(255) NOT NULL,
  `unit` varchar(50) NOT NULL,
  `category` enum('primary','secondary') NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`metric_id`),
  UNIQUE KEY `metric_name` (`metric_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics`
--

LOCK TABLES `metrics` WRITE;
/*!40000 ALTER TABLE `metrics` DISABLE KEYS */;
INSERT INTO `metrics` VALUES (1,'Процент положительных отзывов','%','primary','Доля положительных оценок (4-5) от общего количества оценок','2025-11-08 11:15:05','2025-11-08 11:15:05'),(2,'Процент решений при первом контакте','%','primary','Доля обращений, решенных при первом обращении клиента','2025-11-08 11:15:05','2025-11-08 11:15:05'),(3,'Среднее время обработки','мин','primary','Среднее время на обработку одного обращения','2025-11-08 11:15:05','2025-11-08 11:15:05'),(4,'Средний балл качества','балл','primary','Средняя оценка качества работы по результатам проверки','2025-11-08 11:15:05','2025-11-08 11:15:05'),(5,'Производительность','обраб/час','secondary','Количество обработанных обращений в час','2025-11-08 11:15:05','2025-11-08 11:15:05');
/*!40000 ALTER TABLE `metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `notification_type` enum('info','warning','success','error') NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `related_entity` varchar(100) DEFAULT NULL,
  `related_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`notification_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,6,'Данные подтверждены','Ваши рабочие показатели подтверждены руководителем.','success',0,'daily_metrics',1,'2025-11-08 11:40:07'),(2,7,'Требуется проверка','Ваши данные ожидают проверки руководителем.','info',0,'daily_metrics',5,'2025-11-08 11:40:07'),(3,9,'Рекомендация по улучшению','Обратите внимание на время обработки обращений. Старайтесь укладываться в норматив 10 минут.','warning',1,'target_values',8,'2025-11-08 11:40:07'),(4,3,'Новый норматив','Установлены новые нормативы для вашей группы на 2024 год.','info',0,'target_values',1,'2025-11-08 11:40:07'),(5,12,'Отличная работа!','Ваши показатели качества превышают установленные нормативы. Так держать!','success',0,'calculated_metrics',15,'2025-11-08 11:40:07'),(6,7,'Данные отклонены','Ваши данные были отклонены. Проверьте корректность введенной информации.','error',1,'daily_metrics',19,'2025-11-08 11:40:07');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target_values`
--

DROP TABLE IF EXISTS `target_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target_values` (
  `target_id` int NOT NULL AUTO_INCREMENT,
  `metric_id` int NOT NULL,
  `object_id` int NOT NULL,
  `target_value` decimal(10,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `object_type` enum('Группа','Сотрудник') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`target_id`),
  KEY `metric_id` (`metric_id`),
  CONSTRAINT `target_values_ibfk_1` FOREIGN KEY (`metric_id`) REFERENCES `metrics` (`metric_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target_values`
--

LOCK TABLES `target_values` WRITE;
/*!40000 ALTER TABLE `target_values` DISABLE KEYS */;
INSERT INTO `target_values` VALUES (17,1,1,85.00,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(18,1,2,80.00,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(19,1,3,90.00,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(20,2,1,75.00,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(21,2,2,70.00,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(22,2,3,60.00,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(23,3,1,8.00,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(24,3,2,10.00,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(25,3,3,15.00,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(26,4,1,4.50,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(27,4,2,4.30,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(28,4,3,4.70,'2024-01-01','2024-12-31','Группа','2025-11-08 11:42:55','2025-11-08 11:42:55'),(29,1,6,90.00,'2024-01-01','2024-12-31','Сотрудник','2025-11-08 11:42:55','2025-11-08 11:42:55'),(30,2,6,80.00,'2024-01-01','2024-12-31','Сотрудник','2025-11-08 11:42:55','2025-11-08 11:42:55'),(31,3,6,7.00,'2024-01-01','2024-12-31','Сотрудник','2025-11-08 11:42:55','2025-11-08 11:42:55'),(32,4,6,4.80,'2024-01-01','2024-12-31','Сотрудник','2025-11-08 11:42:55','2025-11-08 11:42:55');
/*!40000 ALTER TABLE `target_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_groups`
--

DROP TABLE IF EXISTS `work_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_groups` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `work_groups_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_groups`
--

LOCK TABLES `work_groups` WRITE;
/*!40000 ALTER TABLE `work_groups` DISABLE KEYS */;
INSERT INTO `work_groups` VALUES (1,1,'Утренняя смена','2025-11-08 11:15:01','2025-11-08 11:15:01'),(2,1,'Вечерняя смена','2025-11-08 11:15:01','2025-11-08 11:15:01'),(3,2,'Сложные случаи','2025-11-08 11:15:01','2025-11-08 11:15:01'),(4,1,'Ночная смена','2025-11-08 11:34:35','2025-11-08 11:34:35'),(5,3,'Сервис инженеры','2025-11-08 11:34:35','2025-11-08 11:34:35'),(6,3,'Системные администраторы','2025-11-08 11:34:35','2025-11-08 11:34:35');
/*!40000 ALTER TABLE `work_groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-08 16:57:09
