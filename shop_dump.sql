-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: my_shop
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `basket`
--

DROP TABLE IF EXISTS `basket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `basket` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID корзины, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Корзина привязывается к пользователю',
  `orders_id` int NOT NULL COMMENT 'Корзина имеет привязку к заказу',
  `product_id` int NOT NULL COMMENT 'ID товара в корзине',
  `quantity` smallint NOT NULL COMMENT 'Кол-во товара в корзине',
  `price` decimal(10,2) NOT NULL COMMENT 'Цена товара в корзине с учетом скидки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`,`orders_id`,`product_id`),
  KEY `basket_user_id_fk` (`user_id`),
  KEY `basket_orders_id_fk` (`orders_id`),
  KEY `basket_product_id_fk` (`product_id`),
  CONSTRAINT `basket_orders_id_fk` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `basket_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `basket_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с позициями из заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket`
--

LOCK TABLES `basket` WRITE;
/*!40000 ALTER TABLE `basket` DISABLE KEYS */;
INSERT INTO `basket` VALUES (1,1,1,3,1,12411.00,'2021-03-18 11:11:39','2021-03-18 11:11:39'),(2,2,2,2,1,3599.00,'2021-03-18 11:11:39','2021-03-18 11:11:39'),(3,1,4,4,2,4551.00,'2021-03-18 11:11:39','2021-03-18 11:11:39'),(4,3,3,2,1,977.00,'2021-03-18 11:11:39','2021-03-18 11:11:39'),(5,4,4,1,1,977.00,'2021-03-18 11:11:39','2021-03-18 11:11:39'),(6,1,6,5,1,221.00,'2021-03-18 11:11:39','2021-03-18 11:11:39');
/*!40000 ALTER TABLE `basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID бренда, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(100) NOT NULL COMMENT 'Название бренда, обязательное поле, уникальное поле',
  `country` varchar(100) NOT NULL COMMENT 'Страна бренда, обяззательное поле',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описание брендая',
  `logo` varchar(255) DEFAULT NULL COMMENT 'url на логотип бренда',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица-справочник брендов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'JS Collections','Россия','Молодой, но уже популярный бренд родом из России','logo_js_collection.jpg','2021-02-28 19:12:15','2021-03-03 12:20:40'),(2,'PAUL&SHARK','США','Знаминитый бренд родом из США имеет большое кол-во поклонников по всему мирк','logo_paul_shark.jpg','2021-03-04 12:22:41','2021-02-27 08:38:18'),(3,'D&W','Италия','Европейский бренд любим за классический стиль','logo_d_w.jpg','2021-03-02 13:04:08','2021-03-13 06:23:51'),(4,'Black style','Канада','Молодежная одежда радующая цветом и качеством','logo_black_style.jpg','2021-03-06 20:56:03','2021-03-16 09:13:32');
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID товарной категории, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(50) DEFAULT NULL COMMENT 'Имя товарной категории',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описание товарной категории',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица-справочник с названием товарных категория/разделы каталога';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Юбки','Юбка – оружие современной женщины','2021-03-12 04:39:01','2021-03-12 04:39:01'),(2,'Шорты','Шорты – оригинальные варианты одежды, которые не выходят из обихода вот уже несколько десятилетий.','2021-03-12 04:39:01','2021-03-12 04:39:01'),(3,'Рубашки','Женские рубашки являются неотъемлемой частью гардероба женщин любых возрастов. ','2021-03-12 04:39:01','2021-03-12 04:39:01'),(4,'Брюки','Женские брюки могут использоваться в любое время года. ','2021-03-12 04:39:01','2021-03-12 04:39:01'),(5,'Футболки','Футболки являются базовым элементом женского гардероба, они могут составить основу практически любого повседневного образа.','2021-03-12 04:39:01','2021-03-12 04:39:01');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color`
--

DROP TABLE IF EXISTS `color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `color` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID цвета, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(20) NOT NULL COMMENT 'Название цвета товара',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица-справочник цвета товара';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color`
--

LOCK TABLES `color` WRITE;
/*!40000 ALTER TABLE `color` DISABLE KEYS */;
INSERT INTO `color` VALUES (1,'серый','2021-03-12 04:39:01','2021-03-12 04:39:01'),(2,'белый','2021-03-12 04:39:01','2021-03-12 04:39:01'),(3,'синий','2021-03-12 04:39:01','2021-03-12 04:39:01'),(4,'черный','2021-03-12 04:39:01','2021-03-12 04:39:01'),(5,'красный','2021-03-12 04:39:01','2021-03-12 04:39:01'),(6,'голубой','2021-03-12 04:39:01','2021-03-12 04:39:01');
/*!40000 ALTER TABLE `color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID скидки, счетчик, присываивается системой автоматически, последовательно',
  `product_id` int NOT NULL COMMENT 'ID товара к которому применяется скидка',
  `discount` float unsigned DEFAULT NULL COMMENT 'Cкидка, где 1.0 - отсуствие скидки, значение <1.0 коэффициент к цене. где min = 0.00 max = 1.00',
  `started_at` datetime DEFAULT NULL COMMENT 'Начало действия скидки',
  `finished_at` datetime DEFAULT NULL COMMENT 'Окончания действия скидки',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  KEY `discounts_product_id_fk` (`product_id`),
  CONSTRAINT `discounts_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с размерами скидок по продуктам';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (1,1,0.2,'2021-03-18 11:11:39','2021-03-19 11:11:39','2021-03-11 10:28:24','2020-12-01 17:17:29'),(2,1,0.5,'2021-04-18 11:11:39','2021-04-18 11:11:39','2021-03-11 10:28:24','2020-12-01 17:17:29'),(3,3,0.11,'2021-03-18 11:11:39','2021-03-25 11:11:39','2021-03-11 10:28:24','2020-12-01 17:17:29'),(4,4,0.04,'2021-03-18 11:11:39','2021-03-20 11:11:39','2021-03-11 10:28:24','2020-12-01 17:17:29'),(5,5,0.75,'2021-04-02 11:11:39','2021-04-10 11:11:39','2021-03-11 10:28:24','2020-12-01 17:17:29');
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `created_at` datetime NOT NULL,
  `table_name` varchar(45) NOT NULL,
  `str_id` bigint NOT NULL,
  `name_value` varchar(45) NOT NULL
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Логирование операций в ИМ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID изоюражения, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(100) NOT NULL COMMENT 'Уникальное название файла с изображением товара',
  `size` varchar(100) NOT NULL COMMENT 'Размер файла изображения',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описания фалйа с изображением товара',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица-справочник по изображениям товара';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,'tempora.jpg','5421','Repellendus eaque quo porro officiis accusantium magni rerum.','2021-03-06 21:53:41','2021-02-28 21:42:00'),(2,'tem.jpg','6047','Dolorum quasi laborum iure numquam.','2021-02-23 17:26:29','2020-04-28 15:26:51'),(3,'sunt.jpg','4735','Odio fugiat itaque doloribus ut.','2021-03-17 22:27:28','2020-04-22 21:19:16'),(4,'vitae.jpg','8492','Magnam est tempore dolore magnam.','2021-03-11 07:12:08','2020-06-19 22:34:48'),(5,'asperiores.jpg','8156','Sapiente id in quasi sint dolore recusandae.','2021-02-24 00:36:09','2021-01-10 07:23:00'),(6,'odio.jpg','9633','Quas id aut mollitia aut vitae ut.','2021-03-14 04:51:37','2021-01-14 07:33:36'),(7,'occaecati.jpg','1212','Enim quis possimus natus et blanditiis animi.','2021-03-04 12:11:16','2021-03-13 05:54:34'),(8,'in.jpg','6637','Modi excepturi fuga facilis enim omnis sunt est.','2021-03-15 09:07:59','2020-12-18 07:04:22'),(9,'recusandae.jpg','93284','Eius ab voluptas necessitatibus suscipit velit quo commodi.','2021-03-04 16:31:13','2020-07-29 05:02:26'),(10,'nulla.jpg','43434','Et minima ab quidem dicta voluptatem repellat illo.','2021-03-11 10:28:24','2020-12-01 17:17:29');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID статуса заказа, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(20) NOT NULL COMMENT 'Название/описание статуса заказа, уникальное значения поля',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица-справочник cтатусов заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'Создан','2021-03-18 11:11:39','2021-03-18 11:11:39'),(2,'Подтвержден','2021-03-18 11:11:39','2021-03-18 11:11:39'),(3,'Собран','2021-03-18 11:11:39','2021-03-18 11:11:39'),(4,'Отправлен','2021-03-18 11:11:39','2021-03-18 11:11:39'),(5,'Выполнен','2021-03-18 11:11:39','2021-03-18 11:11:39');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный номер заказа, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Заказ всегда имеет привязку к пользователю',
  `profile_id` int NOT NULL COMMENT 'Заказ всегда имеет привязку к профелю',
  `order_status_id` int DEFAULT NULL COMMENT 'ID статуса заказа, берется из таблицы статусов заказа',
  `note` varchar(250) DEFAULT NULL COMMENT 'Комментарий покупателы к заказу, произвольный текст',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`,`user_id`,`profile_id`),
  KEY `orders_user_id_fk` (`user_id`),
  KEY `orders_profile_id_fk` (`profile_id`),
  KEY `orders_status_id_fk` (`order_status_id`),
  CONSTRAINT `orders_profile_id_fk` FOREIGN KEY (`profile_id`) REFERENCES `profiles` (`id`),
  CONSTRAINT `orders_status_id_fk` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`id`),
  CONSTRAINT `orders_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица c заказами покупателя';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,9,1,1,'Доставить до 19:00','2021-03-18 11:11:39','2021-03-18 11:11:39'),(2,2,2,2,'Незвонить','2021-03-18 11:11:39','2021-03-18 11:11:39'),(3,9,7,3,'Как можно быстрей','2021-03-18 11:11:39','2021-03-18 11:11:39'),(4,8,3,4,'Только в выходные','2021-03-18 11:11:39','2021-03-18 11:11:39'),(5,4,8,5,'Незвонить','2021-03-18 11:11:39','2021-03-18 11:11:39'),(6,1,6,1,'Перезвоните мне быстрей!','2021-03-18 11:11:39','2021-03-18 11:11:39');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `orders_profile`
--

DROP TABLE IF EXISTS `orders_profile`;
/*!50001 DROP VIEW IF EXISTS `orders_profile`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `orders_profile` AS SELECT 
 1 AS `order_id`,
 1 AS `order_created`,
 1 AS `status`,
 1 AS `status_date`,
 1 AS `customer`,
 1 AS `phone`,
 1 AS `address`,
 1 AS `comments`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `pay_systems`
--

DROP TABLE IF EXISTS `pay_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pay_systems` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID платежной системы, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(50) DEFAULT NULL COMMENT 'Название платежной системы, проверка на уникальность',
  `status` tinyint(1) DEFAULT '0' COMMENT 'Активность платежной системы, 1 - активна / 0 - не активна, по умолчанию 0',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица-справочник списка платежных систем';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_systems`
--

LOCK TABLES `pay_systems` WRITE;
/*!40000 ALTER TABLE `pay_systems` DISABLE KEYS */;
INSERT INTO `pay_systems` VALUES (1,'Банковской картой онлайн',1,'2021-03-18 11:00:08','2021-03-18 11:00:08'),(2,'Банковски переводом',1,'2021-03-18 11:00:08','2021-03-18 11:00:08'),(3,'При получении',0,'2021-03-18 11:00:08','2021-03-18 11:00:08');
/*!40000 ALTER TABLE `pay_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID связки товар-категория, счетчик, присываивается системой автоматически, последовательно',
  `product_id` int NOT NULL COMMENT 'ID продукта который привязываем к категории ',
  `category_id` int NOT NULL COMMENT 'ID категории к которой привязывкм продукт',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`,`product_id`,`category_id`),
  KEY `product_category_product_id_fk` (`product_id`),
  KEY `product_category_category_id_fk` (`category_id`),
  CONSTRAINT `product_category_category_id_fk` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `product_category_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица-справочник привязки товара к товарным категориям (один к множеству)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,1,1,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(2,2,1,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(3,3,1,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(4,4,5,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(5,5,5,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(6,6,5,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(7,7,5,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(8,8,5,'2021-03-12 04:39:01','2021-03-12 04:39:01');
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID товара, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(100) NOT NULL COMMENT 'Наименование товара',
  `sku` varchar(20) DEFAULT NULL COMMENT 'SKU номер (артикул) товара по классификации производителя',
  `size_id` int DEFAULT NULL COMMENT 'ID размера товара',
  `color_id` int DEFAULT NULL COMMENT 'ID цвета товара',
  `brand_id` int DEFAULT NULL COMMENT 'ID бренда товара',
  `description_preview` varchar(255) DEFAULT NULL COMMENT 'Описание товара для отображения в разделе каталога (в списке)',
  `description` varchar(10000) DEFAULT NULL COMMENT 'Полное описание товара',
  `media_id` int DEFAULT NULL COMMENT 'ID изображения товара, множество',
  `price` decimal(10,2) DEFAULT NULL COMMENT 'Розничная цена товара',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  KEY `products_size_id_fk` (`size_id`),
  KEY `products_media_id_fk` (`media_id`),
  KEY `products_brand_id_fk` (`brand_id`),
  KEY `products_color_id_fk` (`color_id`),
  CONSTRAINT `products_brand_id_fk` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  CONSTRAINT `products_color_id_fk` FOREIGN KEY (`color_id`) REFERENCES `color` (`id`),
  CONSTRAINT `products_media_id_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_size_id_fk` FOREIGN KEY (`size_id`) REFERENCES `size` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица c описанием товара';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Юбка JS Collections','5862366',1,1,2,'Строгая юбка черного цвета на лето','Сезон: лето. Состав: 97% полиэстер, 3% спандекс.',1,3480.00,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(2,'Юбка JS Collections','5862365',2,1,2,'Строгая юбка черного цвета на лето','Сезон: лето. Состав: 97% полиэстер, 3% спандекс.',2,3480.00,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(3,'Юбка JS Collections','5862364',4,1,2,'Строгая юбка черного цвета на лето','Сезон: лето. Состав: 97% полиэстер, 3% спандекс.',3,3480.00,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(4,'Футболка PAUL&SHARK','47651-15',2,3,1,'Белая классическая футболка из натурального хлопка','Футболка от бренда PAUL&SHARK. Модель полуприлегающего кроя, белого цвета. Круглый ворот под горло, короткий рукав, акула желтого цвета на груди, фирменный значок на левом рукаве.',4,12100.00,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(5,'Футболка PAUL&SHARK','47652-15',3,3,1,'Белая классическая футболка из натурального хлопка','Футболка от бренда PAUL&SHARK. Модель полуприлегающего кроя, белого цвета. Круглый ворот под горло, короткий рукав, акула желтого цвета на груди, фирменный значок на левом рукаве.',5,12100.00,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(6,'Футболка PAUL&SHARK','47653-15',1,3,1,'Белая классическая футболка из натурального хлопка','Футболка от бренда PAUL&SHARK. Модель полуприлегающего кроя, белого цвета. Круглый ворот под горло, короткий рукав, акула желтого цвета на груди, фирменный значок на левом рукаве.',6,12100.00,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(7,'Футболка PAUL&SHARK','47650-15',4,3,1,'Белая классическая футболка из натурального хлопка','Футболка от бренда PAUL&SHARK. Модель полуприлегающего кроя, белого цвета. Круглый ворот под горло, короткий рукав, акула желтого цвета на груди, фирменный значок на левом рукаве.',7,12100.00,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(8,'Шорты PAUL&SHARK','47333-15',1,3,1,'Белые короткие шорты идеальны для прогулки','Шорты от бренда PAUL&SHARK. Модель полуприлегающего кроя, белого цвета. ',8,4500.00,'2021-03-12 04:39:01','2021-03-12 04:39:01');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `watchlog_products` AFTER INSERT ON `products` FOR EACH ROW BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `products_info`
--

DROP TABLE IF EXISTS `products_info`;
/*!50001 DROP VIEW IF EXISTS `products_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `products_info` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `sku`,
 1 AS `brand`,
 1 AS `product_size`,
 1 AS `color`,
 1 AS `stock`,
 1 AS `price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID профиля, у пользователя может быть множество профилей, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Привязка к ID пользователя, профайл всегда связан с пользователем, он не может быть без привязки к пользователю',
  `first_name` varchar(100) NOT NULL COMMENT 'Имя получателя заказа, обязательное поле',
  `last_name` varchar(100) NOT NULL COMMENT 'Фамилия получателя заказа, обязательное поле',
  `email` varchar(100) NOT NULL COMMENT 'Email получателя заказа, обязательное поле',
  `phone` varchar(11) NOT NULL COMMENT 'Сотовый телефолн получателя заказа, обязательное поле',
  `country` varchar(50) DEFAULT NULL COMMENT 'Страна получателя заказа, необязательное поле',
  `city` varchar(50) DEFAULT NULL COMMENT 'Город получателя заказа пользователя, необязательное поле',
  `zip` int DEFAULT NULL COMMENT 'Почтовый индекс пользователя, необязательное поле',
  `address` varchar(255) DEFAULT NULL COMMENT 'Адрес доставки пользователя, необязательное пол',
  `status` tinyint(1) DEFAULT '1' COMMENT 'Статус/состояние профайла (активная/неактивная), обязательное поле, по умолчанию TRUE (1)',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновление записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  KEY `profiles_user_id_fk` (`user_id`),
  CONSTRAINT `profiles_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица профиля доставки, у одного пользоватля могут быть разные профили для доставки, интернет-магазина';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,3,'Nicklaus','Stark','maximillia28@example.org','79162824310','Bermuda','Rossiechester',124112,'0481 Mohr Green\nSouth Rubyefurt, ME 33778',1,'2021-03-01 02:54:54','2019-06-18 09:27:27'),(2,2,'Linnie','Wintheiser','aliyah01@example.net','79016415518','Russia','Moscow',195541,'0547 Dolly Crest\nSouth Maximilianland, WV 06714-7881',1,'2021-03-15 02:30:17','2012-10-25 10:25:11'),(3,3,'Marcia','Heaney','dixie27@example.com','79117701122','Montserrat','East Benniemouth',171816,'9268 Moen Row Apt. 247\nPort Leestad, ME 33357',1,'2021-03-12 22:14:32','2015-02-22 11:10:02'),(4,3,'Alf','Saderik','cesar41@example.net','79037581162','Bermuda','East Ernest',123451,'034 Gorczany Islands Suite 342\nDeonteland, MS 07113',0,'2021-03-10 11:13:51','2014-06-18 01:15:27'),(5,4,'Dandre','Carter','aprosacco@example.org','71115211122','Uruguay','Harveymouth',451123,'7119 Kautzer Throughway Apt. 521\nNorth Helenaview, AZ 15899-4903',1,'2021-03-06 00:01:36','2012-04-11 05:28:03'),(6,4,'Ulises','Nikolaus','thiel.melvina@example.org','79122147483','Uganda','Lenorastad',278111,'305 Carroll Rapids Suite 869\nHarleyhaven, LA 80991-1478',0,'2021-03-12 16:33:51','2015-04-29 12:00:55'),(7,5,'Kobe','Bernhard','eduardo.luettgen@example.org','79247772132','Thailand','Jailynhaven',651123,'89345 Lexie Squares\nRaefort, HI 62100-4384',1,'2021-02-28 01:32:12','2019-01-27 13:01:02'),(8,3,'Shaylee','Collins','lwindler@example.com','79150101213','Myanmar','Port Margarita',771444,'08022 Hegmann Locks\nAudrastad, VA 99543-5972',0,'2021-03-11 14:15:06','2011-09-30 19:34:22'),(9,5,'Tania','Bartoletti','ayden.dubuque@example.org','75105127712','Russia','Ianberg',501231,'058 McCullough Rue\nFraneckiside, MI 53415-5241',1,'2021-03-02 15:49:48','2017-04-26 10:22:19'),(10,6,'Willard','Walsh','lenna.purdy@example.org','72147483647','Russia','North Jaydestad',312111,'558 Eva Stream Apt. 688\nSchneiderfurt, KY 72702-1697',1,'2021-03-08 05:17:52','2011-09-26 13:31:54'),(11,1,'Esperanza','Hauck','goldner.lucio@example.org','79175414455','Russia','New Deannastad',132121,'6007 Roob Terrace\nAronfort, LA 73253-5468',1,'2021-03-01 12:51:20','2014-10-21 07:11:43'),(12,1,'Katlyn','Kulas','maxwell94@example.net','79187483647','Russia','Moscow',766171,'379 Wyman Mews\nKarachester, NV 96305',1,'2021-03-02 09:32:10','2021-01-25 13:42:21'),(13,1,'Keanu','Wehner','blanda.stefanie@example.net','79194417744','Russia','New Keelyhaven',441221,'0728 Jodie Groves Apt. 941\nRathside, MO 50055',1,'2021-03-17 15:34:41','2015-02-16 23:58:53'),(14,4,'Daisy','Huel','eliezer.hand@example.org','79991214411','Russia','Port Karentown',999112,'87454 Paucek Passage\nBotsfordburgh, CT 68288-8874',1,'2021-02-27 11:54:41','2015-07-20 16:26:56'),(15,4,'Myrtice','Johnston','dbeatty@example.net','79168494512','Russia','Runtehaven',551312,'9074 Zula Mountains\nLethaview, SD 12272-7857',1,'2021-03-12 06:07:58','2013-04-07 23:08:01'),(16,5,'Ivan','Ivanov','ivan@mail.ru','79161012229','Russia','Moscow',129515,'Argunovskay str. 10k1',1,'2021-03-02 15:49:48','2017-04-26 10:22:19'),(17,3,'Zahar','Ivanov','zaharivanov@mail.ru','79141012229','Russia','Moscow',129515,'Argunovskay str. 9k1',1,'2021-03-02 15:49:48','2017-04-26 10:22:19');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID отзыва, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Привязка к ID пользователя, отзыв всегда имеет владельца - пользователя, он не может быть без привязки к пользователю',
  `product_id` int NOT NULL COMMENT 'Привязка к ID товара',
  `rating` int NOT NULL COMMENT 'Обязательное поле. Оценка товара от 1 до 5',
  `description` varchar(255) DEFAULT NULL COMMENT 'Необязательное поле. Отзыв о товаре',
  `status` tinyint(1) DEFAULT '0' COMMENT 'Статус публикации отзыва (1 - опубликован, 0 - не опубликован), по умолчанию 0',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`,`user_id`,`product_id`),
  KEY `reviews_user_id_fk` (`user_id`),
  KEY `reviews_product_id_fk` (`product_id`),
  CONSTRAINT `reviews_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `reviews_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица c оценкой и отзывами на товар';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,3,1,5,'Идеально для делового стиля',0,'2006-04-09 00:41:54','2020-09-19 20:28:55'),(2,1,1,5,'Понравился цвет, материал добротный',1,'2020-10-29 06:06:11','1958-02-25 11:17:37'),(3,4,2,4,'Ужасные швы, маломерка!',1,'2020-11-24 00:00:43','1964-12-30 02:48:55'),(4,2,4,4,'Все понравилось',0,'2021-02-01 02:42:22','1926-06-10 13:16:22'),(5,5,5,5,'Вернула обратно, ужасное качество',1,'2020-06-10 12:25:29','1923-12-31 20:46:54'),(6,1,1,5,'Давно искала и нашла, полюбила с первого взгляда',1,'2020-05-10 11:58:00','2018-01-26 11:13:19'),(7,6,1,5,'Идеально для делового стиля',0,'2006-04-09 00:41:54','2020-09-19 20:28:55'),(8,7,1,5,'Понравился цвет, материал добротный',1,'2020-10-29 06:06:11','1958-02-25 11:17:37'),(9,5,2,4,'Ужасные швы, маломерка!',1,'2020-11-24 00:00:43','1964-12-30 02:48:55'),(10,4,4,4,'Все понравилось',0,'2021-02-01 02:42:22','1926-06-10 13:16:22'),(11,3,5,5,'Вернула обратно, ужасное качество',1,'2020-06-10 12:25:29','1923-12-31 20:46:54'),(12,2,5,5,'Вернула обратно, ужасное качество',1,'2020-06-10 12:25:29','1923-12-31 20:46:54'),(13,1,5,5,'Вернула обратно, ужасное качество',1,'2020-06-10 12:25:29','1923-12-31 20:46:54'),(14,3,1,5,'Давно искала и нашла, полюбила с первого взгляда',1,'2020-05-10 11:58:00','2018-01-26 11:13:19');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roll`
--

DROP TABLE IF EXISTS `roll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roll` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID роли пользователя, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(255) DEFAULT NULL COMMENT 'Название/описание роли пользователя, проверка на уникальность',
  `status` tinyint(1) DEFAULT '1' COMMENT 'Статус/состояние роли пользователя (активная/неактивная), обязательное поле, по умолчанию TRUE (1)',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица-справочник ролей (уровня доступа к функционалу) пользователей в инетернет-магазине профиля доставки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roll`
--

LOCK TABLES `roll` WRITE;
/*!40000 ALTER TABLE `roll` DISABLE KEYS */;
INSERT INTO `roll` VALUES (1,'Администратор',1,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(2,'Менеджер',0,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(3,'Покупатель',1,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(4,'Незарегистрированный пользователь',1,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(5,'Маркетолог',1,'2021-03-12 04:39:01','2021-03-12 04:39:01');
/*!40000 ALTER TABLE `roll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `size`
--

DROP TABLE IF EXISTS `size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `size` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID размера, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(10) NOT NULL COMMENT 'Название размера товара ',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица-справочник размеров товара';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `size`
--

LOCK TABLES `size` WRITE;
/*!40000 ALTER TABLE `size` DISABLE KEYS */;
INSERT INTO `size` VALUES (1,'36','2021-03-12 04:39:01','2021-03-12 04:39:01'),(2,'L','2021-03-12 04:39:01','2021-03-12 04:39:01'),(3,'42','2021-03-12 04:39:01','2021-03-12 04:39:01'),(4,'XL','2021-03-12 04:39:01','2021-03-12 04:39:01'),(5,'XXL','2021-03-12 04:39:01','2021-03-12 04:39:01');
/*!40000 ALTER TABLE `size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID информации об остатке товара на складе, счетчик, присываивается системой автоматически, последовательно',
  `product_id` int NOT NULL COMMENT 'ID товара для которого делаем запись об остатках, уникальное поле, обязательное поле',
  `reserve` int DEFAULT NULL COMMENT 'Остатки не доступные для продажи (зарезервированные)',
  `avaible` int DEFAULT NULL COMMENT 'Остатки доступные для продажи (зарезервированные)',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  KEY `stock_product_id_fk` (`product_id`),
  CONSTRAINT `stock_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с остатками товара на складе, product_id уникален, только update';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,0,10,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(2,2,0,0,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(3,3,2,6,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(4,4,0,2,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(5,5,0,3,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(6,6,1,4,'2021-03-12 04:39:01','2021-03-12 04:39:01'),(7,7,0,200,'2021-03-12 04:39:01','2021-03-12 04:39:01');
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID платежной системы, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Привязка к пользователю',
  `orders_id` int NOT NULL COMMENT 'Привязка к заказу, может отсутствовать привязка к заказу',
  `pay_system_id` int NOT NULL COMMENT 'Из какой платежной системы поступили ДС',
  `summ` decimal(10,2) NOT NULL COMMENT 'Сумма платежа',
  `message` varchar(100) DEFAULT NULL COMMENT 'Сообщение платежной системы',
  `type` tinyint(1) NOT NULL COMMENT 'Тип транзакции, 1 - приход / 0 - списание',
  `status` tinyint(1) NOT NULL COMMENT 'Статус транзакции, 1 - проведена / 0 - не проведена',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`,`user_id`,`orders_id`,`pay_system_id`),
  KEY `transaction_user_id_fk` (`user_id`),
  KEY `transaction_orders_id_fk` (`orders_id`),
  KEY `transaction_pay_system_id_fk` (`pay_system_id`),
  CONSTRAINT `transaction_orders_id_fk` FOREIGN KEY (`orders_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `transaction_pay_system_id_fk` FOREIGN KEY (`pay_system_id`) REFERENCES `pay_systems` (`id`),
  CONSTRAINT `transaction_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с финансовыми транзакциями';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,9,1,1,12411.00,'successful',1,1,'2021-03-18 11:11:39','2021-03-18 11:11:39'),(2,2,2,2,3599.00,'successful',1,1,'2021-03-18 11:11:39','2021-03-18 11:11:39'),(3,1,6,1,4511.00,'successful',1,1,'2021-03-18 11:11:39','2021-03-18 11:11:39'),(4,8,3,1,977.00,'successful',1,1,'2021-03-18 11:11:39','2021-03-18 11:11:39'),(5,8,4,2,977.00,'successful',1,0,'2021-03-18 11:11:39','2021-03-18 11:11:39');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID пользователя, счетчик, присываивается системой автоматически, последовательно',
  `phone` varchar(11) NOT NULL COMMENT 'Уникальный мобилный номер пользователя (используется как один из способов авторизации), обязательное поле',
  `email` varchar(100) NOT NULL COMMENT 'Уникальный email пользователя (используется как один из способов авторизации), обязательное поле',
  `password` varchar(20) NOT NULL COMMENT 'Пароль пользователя, обязательный для заполнения',
  `roll_id` int NOT NULL COMMENT 'Роль пользователя в интернет-магазине, обязательное поле',
  `status` tinyint(1) DEFAULT '1' COMMENT 'Статус/состояние учетной записи польователя (активная/неактивная), обязательное поле, по умолчанию TRUE (1)',
  `first_name` varchar(100) NOT NULL COMMENT 'Имя пользователя, обязательное поле',
  `last_name` varchar(100) NOT NULL COMMENT 'Фамилия пользователя, обязательное поле',
  `gender` tinyint(1) DEFAULT NULL COMMENT 'Пол пользователя, необязательное поле, 0 - женщина / 1 мужчина',
  `birthday_at` date DEFAULT NULL COMMENT 'День рождение пользователя, необязательное поле',
  `last_login` datetime DEFAULT NULL COMMENT 'Дата последней авторизации пользователя',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновление, заполняется автомтически датой и временем обновление записи',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  KEY `users_roll_id_fk` (`roll_id`),
  CONSTRAINT `users_roll_id_fk` FOREIGN KEY (`roll_id`) REFERENCES `roll` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица учетных записей пользовтелей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'79165554433','genes@example.net','f40b4fbc0c439eeed31',5,1,'Alina','Reichert',0,'2002-04-19','2021-03-08 11:34:23','2020-12-14 18:38:51','1958-11-20 17:33:46'),(2,'79164443322','genes22@example.net','f40b433c0c439eeed31',2,1,'Polina','Reichert',0,'2000-05-01','2021-03-08 11:34:23','2020-12-14 18:38:51','1958-11-20 17:33:46'),(3,'79162221100','genes77@example.net','f40b323c0c439eeed31',3,1,'Arisha','Reichert',0,'1976-05-10','2021-03-08 11:34:23','2020-12-14 18:38:51','1958-11-20 17:33:46'),(4,'79169014411','hagenes.teagan@example.net','f4e0b4fbc0c439e26d31',3,1,'Petra','Reichert',0,'1968-04-19','2021-03-08 11:34:23','2020-12-14 18:38:51','1958-11-20 17:33:46'),(5,'79069014881','kylee15@example.org','fa2440c5c75a2778184a',3,0,'Icie','Goodwin',1,'1989-04-14','2021-02-28 06:50:30','2020-10-29 06:06:11','1958-02-25 11:17:37'),(6,'79011112233','zkris@example.com','0506e6ebf3fc91378e1b',3,0,'Sierra','Cummings',0,'1996-05-14','2021-02-26 13:35:46','2020-11-24 00:00:43','1964-12-30 02:48:55'),(7,'79035411121','jewell.muller@example.org','025812acb9176f95392d',3,1,'Howell','O\'Kon',1,'2002-08-10','2021-02-19 11:02:52','2021-02-01 02:42:22','1926-06-10 13:16:22'),(8,'79035413331','daufderhar@example.net','7aed768d4b15cd5c3d4d',3,1,'Dolores','Muller',0,'1938-01-17','2021-03-05 23:15:44','2020-06-10 12:25:29','1923-12-31 20:46:54'),(9,'79113533421','wilfrid70@example.net','557ef0efc5a60a38a691',1,0,'Genesis','Paucek',1,'1985-05-22','2021-02-20 11:58:02','2020-05-10 11:58:00','2018-01-26 11:13:19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'my_shop'
--

--
-- Final view structure for view `orders_profile`
--

/*!50001 DROP VIEW IF EXISTS `orders_profile`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `orders_profile` (`order_id`,`order_created`,`status`,`status_date`,`customer`,`phone`,`address`,`comments`) AS select `orders`.`id` AS `№ заказа`,`orders`.`created_at` AS `дата заказа`,(select `order_status`.`name` from `order_status` where (`order_status`.`id` = `orders`.`order_status_id`)) AS `Статус заказа`,(select `order_status`.`updated_at` from `order_status` where (`order_status`.`id` = `orders`.`order_status_id`)) AS `Дата статуса`,(select concat(`profiles`.`first_name`,' ',`profiles`.`last_name`) from `profiles` where (`profiles`.`id` = `orders`.`profile_id`)) AS `Получатель заказа`,(select `profiles`.`phone` from `profiles` where (`profiles`.`id` = `orders`.`profile_id`)) AS `Контактный телефон`,(select concat(`profiles`.`country`,', ',`profiles`.`city`,' ',`profiles`.`zip`,', ',`profiles`.`address`) from `profiles` where (`profiles`.`id` = `orders`.`profile_id`)) AS `Адрес отправки заказа`,`orders`.`note` AS `Комментарий к заказу` from `orders` order by `orders`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `products_info`
--

/*!50001 DROP VIEW IF EXISTS `products_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `products_info` (`id`,`name`,`sku`,`brand`,`product_size`,`color`,`stock`,`price`) AS select `products`.`id` AS `id`,`products`.`name` AS `Товар`,`products`.`sku` AS `Артикул`,(select `brands`.`name` from `brands` where (`brands`.`id` = `products`.`brand_id`)) AS `Бренд`,(select `size`.`name` from `size` where (`size`.`id` = `products`.`size_id`)) AS `Размер`,(select `color`.`name` from `color` where (`color`.`id` = `products`.`color_id`)) AS `Цвет`,(select `stock`.`avaible` from `stock` where (`stock`.`id` = `products`.`id`)) AS `Остатки товара`,`products`.`price` AS `Цена` from `products` order by `products`.`price` */;
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

-- Dump completed on 2021-03-22 22:18:02
