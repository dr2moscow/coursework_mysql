/* ���� �������� ������ - ����������� ���������� ��� ��������-�������� � ����� ���-��� SKU

������:

����������� ����� � ��������� � �������� �������� ��������-��������
�������� ������� ������� ������ ����������
���� ����������� ����������� ������� � �������� ����� �� �����
�������� �����, ������� ��������� �������
���������� ������������ - ������������ �� ���� ���� ������� ������� �������������, ���������� ���������
������������ ��������� - ��� ���������� �������, ��� ����� ������� �������, ��� ����� ������� ������� */

DROP DATABASE IF EXISTS my_shop;

CREATE DATABASE my_shop;

USE my_shop;

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` ( 
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID ������������, �������, �������������� �������� �������������, ���������������',
  `phone` varchar(11) UNIQUE NOT NULL COMMENT '���������� �������� ����� ������������ (������������ ��� ���� �� �������� �����������), ������������ ����',
  `email` varchar(100) UNIQUE NOT NULL COMMENT '���������� email ������������ (������������ ��� ���� �� �������� �����������), ������������ ����',
  `password` varchar(20) NOT NULL COMMENT '������ ������������, ������������ ��� ����������',
  `roll_id` int NOT NULL COMMENT '���� ������������ � ��������-��������, ������������ ����',
  `status` BOOLEAN DEFAULT TRUE COMMENT '������/��������� ������� ������ ����������� (��������/����������), ������������ ����, �� ��������� TRUE (1)',
  `first_name` varchar(100) NOT NULL COMMENT '��� ������������, ������������ ����',
  `last_name` varchar(100) NOT NULL COMMENT '������� ������������, ������������ ����',
  `gender` tinyint(1) DEFAULT NULL COMMENT '��� ������������, �������������� ����, 0 - ������� / 1 �������',
  `birthday_at` date DEFAULT NULL COMMENT '���� �������� ������������, �������������� ����',
  `last_login` datetime  COMMENT '���� ��������� ����������� ������������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ���������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������'
 ) COMMENT '������� ������� ������� ������������';



DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID �������, � ������������ ����� ���� ��������� ��������, �������, �������������� �������� �������������, ���������������',
  `user_id` int NOT NULL COMMENT '�������� � ID ������������, ������� ������ ������ � �������������, �� �� ����� ���� ��� �������� � ������������',
  `first_name` varchar(100) NOT NULL COMMENT '��� ���������� ������, ������������ ����',
  `last_name` varchar(100) NOT NULL COMMENT '������� ���������� ������, ������������ ����',
  `email` varchar(100) NOT NULL COMMENT 'Email ���������� ������, ������������ ����',
  `phone` varchar(11) NOT NULL COMMENT '������� �������� ���������� ������, ������������ ����',
  `country` varchar(50) DEFAULT NULL COMMENT '������ ���������� ������, �������������� ����',
  `city` varchar(50) DEFAULT NULL COMMENT '����� ���������� ������ ������������, �������������� ����',
  `zip` int DEFAULT NULL COMMENT '�������� ������ ������������, �������������� ����',
  `address` varchar(255) DEFAULT NULL COMMENT '����� �������� ������������, �������������� ���',
  `status` BOOLEAN DEFAULT TRUE COMMENT '������/��������� �������� (��������/����������), ������������ ����, �� ��������� TRUE (1)',  
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ���������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������'
) COMMENT '������� ������� ��������, � ������ ����������� ����� ���� ������ ������� ��� ��������, ��������-��������';



DROP TABLE IF EXISTS `roll`;

CREATE TABLE `roll` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID ���� ������������, �������, �������������� �������� �������������, ���������������',
  `name` varchar(255) UNIQUE DEFAULT NULL COMMENT '��������/�������� ���� ������������, �������� �� ������������',
  `status` BOOLEAN DEFAULT TRUE COMMENT '������/��������� ���� ������������ (��������/����������), ������������ ����, �� ��������� TRUE (1)',  
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������'
) COMMENT '�������-���������� ����� (������ ������� � �����������) ������������� � ���������-�������� ������� ��������';


DROP TABLE IF EXISTS `product_category`;

CREATE TABLE `product_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '���������� ID ������ �����-���������, �������, �������������� �������� �������������, ���������������',
  `product_id` int NOT NULL COMMENT 'ID �������� ������� ����������� � ��������� ',
  `category_id` int NOT NULL COMMENT 'ID ��������� � ������� ���������� �������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������',
  PRIMARY KEY (`id`,`product_id`,`category_id`)
) COMMENT '�������-���������� �������� ������ � �������� ���������� (���� � ���������)';



DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID �������� ���������, �������, �������������� �������� �������������, ���������������',
  `name` varchar(50) DEFAULT NULL COMMENT '��� �������� ���������',
  `description` varchar(255) DEFAULT NULL COMMENT '�������� �������� ���������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '�������-���������� � ��������� �������� ���������/������� ��������';



DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID ���������� �� ������� ������ �� ������, �������, �������������� �������� �������������, ���������������',
  `product_id` int NOT NULL COMMENT 'ID ������ ��� �������� ������ ������ �� ��������, ���������� ����, ������������ ����',
  `reserve` int DEFAULT NULL COMMENT '������� �� ��������� ��� ������� (�����������������)',
  `avaible` int DEFAULT NULL COMMENT '������� ��������� ��� ������� (�����������������)',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '������� � ��������� ������ �� ������, product_id ��������, ������ update';


DROP TABLE IF EXISTS `reviews`;

CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '���������� ID ������, �������, �������������� �������� �������������, ���������������',
  `user_id` int NOT NULL COMMENT '�������� � ID ������������, ����� ������ ����� ��������� - ������������, �� �� ����� ���� ��� �������� � ������������',
  `product_id` int NOT NULL COMMENT '�������� � ID ������',
  `rating` int NOT NULL COMMENT '������������ ����. ������ ������ �� 1 �� 5',
  `description` varchar(255) DEFAULT NULL COMMENT '�������������� ����. ����� � ������',
  `status` BOOLEAN DEFAULT FALSE COMMENT '������ ���������� ������ (1 - �����������, 0 - �� �����������), �� ��������� 0',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������',
   PRIMARY KEY (`id`,`user_id`,`product_id`)
) COMMENT '������� c ������� � �������� �� �����';



DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID ������, �������, �������������� �������� �������������, ���������������',
  `name` varchar(100) NOT NULL COMMENT '������������ ������',
  `sku` varchar(20) DEFAULT NULL COMMENT 'SKU ����� (�������) ������ �� ������������� �������������',
  `size_id` int DEFAULT NULL COMMENT 'ID ������� ������',
  `color_id` int DEFAULT NULL COMMENT 'ID ����� ������',
  `brand_id` int DEFAULT NULL COMMENT 'ID ������ ������',
  `description_preview` varchar(255) DEFAULT NULL COMMENT '�������� ������ ��� ����������� � ������� �������� (� ������)',
  `description` varchar(10000) DEFAULT NULL COMMENT '������ �������� ������',
  `media_id` int DEFAULT NULL COMMENT 'ID ����������� ������, ���������',
  `price` decimal(10,2) DEFAULT NULL COMMENT '��������� ���� ������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '������� c ��������� ������';


DROP TABLE IF EXISTS `size`;

CREATE TABLE `size` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID �������, �������, �������������� �������� �������������, ���������������',
  `name` varchar(10) UNIQUE NOT NULL COMMENT '�������� ������� ������ ',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '�������-���������� �������� ������';


DROP TABLE IF EXISTS `color`;

CREATE TABLE `color` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID �����, �������, �������������� �������� �������������, ���������������',
  `name` varchar(20) UNIQUE NOT NULL COMMENT '�������� ����� ������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '�������-���������� ����� ������';



DROP TABLE IF EXISTS `brands`;

CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID ������, �������, �������������� �������� �������������, ���������������',
  `name` varchar(100) UNIQUE NOT NULL COMMENT '�������� ������, ������������ ����, ���������� ����',
  `country` varchar(100) NOT NULL COMMENT '������ ������, ������������� ����',
  `description` varchar(255) DEFAULT NULL COMMENT '�������� �������',
  `logo` varchar(255) DEFAULT NULL COMMENT 'url �� ������� ������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '�������-���������� �������';


DROP TABLE IF EXISTS `product_img`;

CREATE TABLE `media` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID �����������, �������, �������������� �������� �������������, ���������������',
  `name` varchar(100) UNIQUE NOT NULL COMMENT '���������� �������� ����� � ������������ ������',
  `size` varchar(100) NOT NULL COMMENT '������ ����� �����������',
  `description` varchar(255) DEFAULT NULL COMMENT '�������� ����� � ������������ ������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '�������-���������� �� ������������ ������';



DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '���������� ����� ������, �������, �������������� �������� �������������, ���������������',
  `user_id` int NOT NULL COMMENT '����� ������ ����� �������� � ������������', 
  `profile_id` int NOT NULL COMMENT '����� ������ ����� �������� � �������',
  `order_status_id` int DEFAULT NULL COMMENT 'ID ������� ������, ������� �� ������� �������� ������',
  `note` varchar(250) DEFAULT NULL COMMENT '����������� ���������� � ������, ������������ �����',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������', 
  PRIMARY KEY (`id`,`user_id`,`profile_id`)
) COMMENT '������� c �������� ����������';


DROP TABLE IF EXISTS `order_status`;

CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID ������� ������, �������, �������������� �������� �������������, ���������������',
  `name` varchar(20) UNIQUE NOT NULL COMMENT '��������/�������� ������� ������, ���������� �������� ����',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '�������-���������� c������� ������';


DROP TABLE IF EXISTS `basket`;

CREATE TABLE `basket` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '���������� ID �������, �������, �������������� �������� �������������, ���������������',
  `user_id` int NOT NULL COMMENT '������� ������������� � ������������',
  `orders_id` int NOT NULL COMMENT '������� ����� �������� � ������',
  `product_id` int NOT NULL COMMENT 'ID ������ � �������',
  `quantity` smallint NOT NULL COMMENT '���-�� ������ � �������',
  `price` decimal(10,2) NOT NULL COMMENT '���� ������ � ������� � ������ ������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������',
  PRIMARY KEY (`id`,`orders_id`,`product_id`)
) COMMENT '������� � ��������� �� ������';


DROP TABLE IF EXISTS `discounts`;

CREATE TABLE `discounts` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID ������, �������, �������������� �������� �������������, ���������������',
  `product_id` int NOT NULL COMMENT 'ID ������ � �������� ����������� ������',
  `discount` float UNSIGNED COMMENT 'C�����, ��� 1.0 - ��������� ������, �������� <1.0 ����������� � ����. ��� min = 0.00 max = 1.00',
  `started_at` datetime COMMENT '������ �������� ������',
  `finished_at` datetime COMMENT '��������� �������� ������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '������� � ��������� ������ �� ���������';



DROP TABLE IF EXISTS `pay_systems`;

CREATE TABLE `pay_systems` (
  `id` int AUTO_INCREMENT PRIMARY KEY COMMENT '���������� ID ��������� �������, �������, �������������� �������� �������������, ���������������',
  `name` varchar(50) UNIQUE DEFAULT NULL COMMENT '�������� ��������� �������, �������� �� ������������',
  `status` BOOLEAN DEFAULT FALSE COMMENT '���������� ��������� �������, 1 - ������� / 0 - �� �������, �� ��������� 0',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������' 
) COMMENT '�������-���������� ������ ��������� ������';



DROP TABLE IF EXISTS `transactions`;

CREATE TABLE `transactions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '���������� ID ��������� �������, �������, �������������� �������� �������������, ���������������',
  `user_id` int NOT NULL COMMENT '�������� � ������������',
  `orders_id` int NOT NULL COMMENT '�������� � ������, ����� ������������� �������� � ������',
  `pay_system_id` int NOT NULL COMMENT '�� ����� ��������� ������� ��������� ��',
  `summ` decimal(10,2) NOT NULL COMMENT '����� �������',
  `message` varchar(100) DEFAULT NULL COMMENT '��������� ��������� �������',
  `type` BOOLEAN NOT NULL COMMENT '��� ����������, 1 - ������ / 0 - ��������',
  `status` BOOLEAN NOT NULL COMMENT '������ ����������, 1 - ��������� / 0 - �� ���������',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT '���� ����������, ����������� ������������ ����� � �������� ��������� ������',
  `created_at` datetime DEFAULT current_timestamp COMMENT '���� �������� ������, ����������� �������������, ���� ������������',
  PRIMARY KEY (`id`,`user_id`,`orders_id`,`pay_system_id`)
) COMMENT '������� � ����������� ������������';


DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE COMMENT '����������� �������� � ��';
