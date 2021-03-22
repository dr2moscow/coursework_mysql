/* Тема курсовой работы - минимальный функционал для интренет-магазина с малым кол-вом SKU

Задачи:

представить товар с привязкой к раздалем каталога интернет-магазина
показать текущие остатки товара покупателю
дать возможность покупателям оценить и оставить отзыв на товар
оформить заказ, выбрать платежную систему
обеспечить безопасности - разграничить по типу прав уровень доступа пользователей, логировать изменения
предоставить аналитику - ТОП покупаемых товаров, ТОП самых дешевых товаров, ТОП самых дорогих товаров */

DROP DATABASE IF EXISTS my_shop;

CREATE DATABASE my_shop;

USE my_shop;

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` ( 
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID пользователя, счетчик, присываивается системой автоматически, последовательно',
  `phone` varchar(11) UNIQUE NOT NULL COMMENT 'Уникальный мобилный номер пользователя (используется как один из способов авторизации), обязательное поле',
  `email` varchar(100) UNIQUE NOT NULL COMMENT 'Уникальный email пользователя (используется как один из способов авторизации), обязательное поле',
  `password` varchar(20) NOT NULL COMMENT 'Пароль пользователя, обязательный для заполнения',
  `roll_id` int NOT NULL COMMENT 'Роль пользователя в интернет-магазине, обязательное поле',
  `status` BOOLEAN DEFAULT TRUE COMMENT 'Статус/состояние учетной записи польователя (активная/неактивная), обязательное поле, по умолчанию TRUE (1)',
  `first_name` varchar(100) NOT NULL COMMENT 'Имя пользователя, обязательное поле',
  `last_name` varchar(100) NOT NULL COMMENT 'Фамилия пользователя, обязательное поле',
  `gender` tinyint(1) DEFAULT NULL COMMENT 'Пол пользователя, необязательное поле, 0 - женщина / 1 мужчина',
  `birthday_at` date DEFAULT NULL COMMENT 'День рождение пользователя, необязательное поле',
  `last_login` datetime  COMMENT 'Дата последней авторизации пользователя',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновление записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное'
 ) COMMENT 'Таблица учетных записей пользовтелей';



DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID профиля, у пользователя может быть множество профилей, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Привязка к ID пользователя, профайл всегда связан с пользователем, он не может быть без привязки к пользователю',
  `first_name` varchar(100) NOT NULL COMMENT 'Имя получателя заказа, обязательное поле',
  `last_name` varchar(100) NOT NULL COMMENT 'Фамилия получателя заказа, обязательное поле',
  `email` varchar(100) NOT NULL COMMENT 'Email получателя заказа, обязательное поле',
  `phone` varchar(11) NOT NULL COMMENT 'Сотовый телефолн получателя заказа, обязательное поле',
  `country` varchar(50) DEFAULT NULL COMMENT 'Страна получателя заказа, необязательное поле',
  `city` varchar(50) DEFAULT NULL COMMENT 'Город получателя заказа пользователя, необязательное поле',
  `zip` int DEFAULT NULL COMMENT 'Почтовый индекс пользователя, необязательное поле',
  `address` varchar(255) DEFAULT NULL COMMENT 'Адрес доставки пользователя, необязательное пол',
  `status` BOOLEAN DEFAULT TRUE COMMENT 'Статус/состояние профайла (активная/неактивная), обязательное поле, по умолчанию TRUE (1)',  
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновление записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное'
) COMMENT 'Таблица профиля доставки, у одного пользоватля могут быть разные профили для доставки, интернет-магазина';



DROP TABLE IF EXISTS `roll`;

CREATE TABLE `roll` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID роли пользователя, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(255) UNIQUE DEFAULT NULL COMMENT 'Название/описание роли пользователя, проверка на уникальность',
  `status` BOOLEAN DEFAULT TRUE COMMENT 'Статус/состояние роли пользователя (активная/неактивная), обязательное поле, по умолчанию TRUE (1)',  
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное'
) COMMENT 'Таблица-справочник ролей (уровня доступа к функционалу) пользователей в инетернет-магазине профиля доставки';


DROP TABLE IF EXISTS `product_category`;

CREATE TABLE `product_category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID связки товар-категория, счетчик, присываивается системой автоматически, последовательно',
  `product_id` int NOT NULL COMMENT 'ID продукта который привязываем к категории ',
  `category_id` int NOT NULL COMMENT 'ID категории к которой привязывкм продукт',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`,`product_id`,`category_id`)
) COMMENT 'Таблица-справочник привязки товара к товарным категориям (один к множеству)';



DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID товарной категории, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(50) DEFAULT NULL COMMENT 'Имя товарной категории',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описание товарной категории',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица-справочник с названием товарных категория/разделы каталога';



DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID информации об остатке товара на складе, счетчик, присываивается системой автоматически, последовательно',
  `product_id` int NOT NULL COMMENT 'ID товара для которого делаем запись об остатках, уникальное поле, обязательное поле',
  `reserve` int DEFAULT NULL COMMENT 'Остатки не доступные для продажи (зарезервированные)',
  `avaible` int DEFAULT NULL COMMENT 'Остатки доступные для продажи (зарезервированные)',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица с остатками товара на складе, product_id уникален, только update';


DROP TABLE IF EXISTS `reviews`;

CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID отзыва, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Привязка к ID пользователя, отзыв всегда имеет владельца - пользователя, он не может быть без привязки к пользователю',
  `product_id` int NOT NULL COMMENT 'Привязка к ID товара',
  `rating` int NOT NULL COMMENT 'Обязательное поле. Оценка товара от 1 до 5',
  `description` varchar(255) DEFAULT NULL COMMENT 'Необязательное поле. Отзыв о товаре',
  `status` BOOLEAN DEFAULT FALSE COMMENT 'Статус публикации отзыва (1 - опубликован, 0 - не опубликован), по умолчанию 0',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
   PRIMARY KEY (`id`,`user_id`,`product_id`)
) COMMENT 'Таблица c оценкой и отзывами на товар';



DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID товара, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(100) NOT NULL COMMENT 'Наименование товара',
  `sku` varchar(20) DEFAULT NULL COMMENT 'SKU номер (артикул) товара по классификации производителя',
  `size_id` int DEFAULT NULL COMMENT 'ID размера товара',
  `color_id` int DEFAULT NULL COMMENT 'ID цвета товара',
  `brand_id` int DEFAULT NULL COMMENT 'ID бренда товара',
  `description_preview` varchar(255) DEFAULT NULL COMMENT 'Описание товара для отображения в разделе каталога (в списке)',
  `description` varchar(10000) DEFAULT NULL COMMENT 'Полное описание товара',
  `media_id` int DEFAULT NULL COMMENT 'ID изображения товара, множество',
  `price` decimal(10,2) DEFAULT NULL COMMENT 'Розничная цена товара',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица c описанием товара';


DROP TABLE IF EXISTS `size`;

CREATE TABLE `size` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID размера, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(10) UNIQUE NOT NULL COMMENT 'Название размера товара ',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица-справочник размеров товара';


DROP TABLE IF EXISTS `color`;

CREATE TABLE `color` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID цвета, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(20) UNIQUE NOT NULL COMMENT 'Название цвета товара',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица-справочник цвета товара';



DROP TABLE IF EXISTS `brands`;

CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID бренда, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(100) UNIQUE NOT NULL COMMENT 'Название бренда, обязательное поле, уникальное поле',
  `country` varchar(100) NOT NULL COMMENT 'Страна бренда, обяззательное поле',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описание брендая',
  `logo` varchar(255) DEFAULT NULL COMMENT 'url на логотип бренда',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица-справочник брендов';


DROP TABLE IF EXISTS `product_img`;

CREATE TABLE `media` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID изоюражения, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(100) UNIQUE NOT NULL COMMENT 'Уникальное название файла с изображением товара',
  `size` varchar(100) NOT NULL COMMENT 'Размер файла изображения',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описания фалйа с изображением товара',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица-справочник по изображениям товара';



DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный номер заказа, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Заказ всегда имеет привязку к пользователю', 
  `profile_id` int NOT NULL COMMENT 'Заказ всегда имеет привязку к профелю',
  `order_status_id` int DEFAULT NULL COMMENT 'ID статуса заказа, берется из таблицы статусов заказа',
  `note` varchar(250) DEFAULT NULL COMMENT 'Комментарий покупателы к заказу, произвольный текст',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное', 
  PRIMARY KEY (`id`,`user_id`,`profile_id`)
) COMMENT 'Таблица c заказами покупателя';


DROP TABLE IF EXISTS `order_status`;

CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID статуса заказа, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(20) UNIQUE NOT NULL COMMENT 'Название/описание статуса заказа, уникальное значения поля',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица-справочник cтатусов заказа';


DROP TABLE IF EXISTS `basket`;

CREATE TABLE `basket` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID корзины, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Корзина привязывается к пользователю',
  `orders_id` int NOT NULL COMMENT 'Корзина имеет привязку к заказу',
  `product_id` int NOT NULL COMMENT 'ID товара в корзине',
  `quantity` smallint NOT NULL COMMENT 'Кол-во товара в корзине',
  `price` decimal(10,2) NOT NULL COMMENT 'Цена товара в корзине с учетом скидки',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`,`orders_id`,`product_id`)
) COMMENT 'Таблица с позициями из заказа';


DROP TABLE IF EXISTS `discounts`;

CREATE TABLE `discounts` (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID скидки, счетчик, присываивается системой автоматически, последовательно',
  `product_id` int NOT NULL COMMENT 'ID товара к которому применяется скидка',
  `discount` float UNSIGNED COMMENT 'Cкидка, где 1.0 - отсуствие скидки, значение <1.0 коэффициент к цене. где min = 0.00 max = 1.00',
  `started_at` datetime COMMENT 'Начало действия скидки',
  `finished_at` datetime COMMENT 'Окончания действия скидки',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица с размерами скидок по продуктам';



DROP TABLE IF EXISTS `pay_systems`;

CREATE TABLE `pay_systems` (
  `id` int AUTO_INCREMENT PRIMARY KEY COMMENT 'Уникальный ID платежной системы, счетчик, присываивается системой автоматически, последовательно',
  `name` varchar(50) UNIQUE DEFAULT NULL COMMENT 'Название платежной системы, проверка на уникальность',
  `status` BOOLEAN DEFAULT FALSE COMMENT 'Активность платежной системы, 1 - активна / 0 - не активна, по умолчанию 0',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное' 
) COMMENT 'Таблица-справочник списка платежных систем';



DROP TABLE IF EXISTS `transactions`;

CREATE TABLE `transactions` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Уникальный ID платежной системы, счетчик, присываивается системой автоматически, последовательно',
  `user_id` int NOT NULL COMMENT 'Привязка к пользователю',
  `orders_id` int NOT NULL COMMENT 'Привязка к заказу, может отсутствовать привязка к заказу',
  `pay_system_id` int NOT NULL COMMENT 'Из какой платежной системы поступили ДС',
  `summ` decimal(10,2) NOT NULL COMMENT 'Сумма платежа',
  `message` varchar(100) DEFAULT NULL COMMENT 'Сообщение платежной системы',
  `type` BOOLEAN NOT NULL COMMENT 'Тип транзакции, 1 - приход / 0 - списание',
  `status` BOOLEAN NOT NULL COMMENT 'Статус транзакции, 1 - проведена / 0 - не проведена',
  `updated_at` datetime DEFAULT current_timestamp ON UPDATE current_timestamp COMMENT 'Дата обновление, заполняется автомтически датой и временем обновленя записи',
  `created_at` datetime DEFAULT current_timestamp COMMENT 'Дата создания записи, заполняется автоматически, поле обязательное',
  PRIMARY KEY (`id`,`user_id`,`orders_id`,`pay_system_id`)
) COMMENT 'Таблица с финансовыми транзакциями';


DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE COMMENT 'Логирование операций в ИМ';
