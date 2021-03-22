-- Добавление внешних ключей

USE my_shop;

ALTER TABLE 
	reviews
		ADD CONSTRAINT reviews_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id),
		ADD CONSTRAINT reviews_product_id_fk FOREIGN KEY (product_id) REFERENCES products(id);
	
ALTER TABLE 
	orders
		ADD CONSTRAINT orders_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id),
		ADD CONSTRAINT orders_profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id),
		ADD CONSTRAINT orders_status_id_fk FOREIGN KEY (order_status_id) REFERENCES order_status(id);
	
ALTER TABLE 
	basket
		ADD CONSTRAINT basket_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id),
		ADD CONSTRAINT basket_orders_id_fk FOREIGN KEY (orders_id) REFERENCES orders(id),
		ADD CONSTRAINT basket_product_id_fk FOREIGN KEY (product_id) REFERENCES products(id);
	
ALTER TABLE 
	products
		ADD CONSTRAINT products_size_id_fk FOREIGN KEY (size_id) REFERENCES size(id),
		ADD CONSTRAINT products_media_id_fk FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE,
		ADD CONSTRAINT products_brand_id_fk FOREIGN KEY (brand_id) REFERENCES brands(id),
		ADD CONSTRAINT products_color_id_fk FOREIGN KEY (color_id) REFERENCES color(id);

ALTER TABLE 
	discounts
		ADD CONSTRAINT discounts_product_id_fk FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE;

ALTER TABLE 
	stock
		ADD CONSTRAINT stock_product_id_fk FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE;
	
ALTER TABLE 
	product_category 
		ADD CONSTRAINT product_category_product_id_fk FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
		ADD CONSTRAINT product_category_category_id_fk FOREIGN KEY (category_id) REFERENCES categories(id);
	
ALTER TABLE
	users 
		ADD CONSTRAINT users_roll_id_fk FOREIGN KEY (roll_id) REFERENCES roll(id);
	
ALTER TABLE 
	profiles 
		ADD CONSTRAINT profiles_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE 
	transactions 
		ADD CONSTRAINT transaction_user_id_fk FOREIGN KEY (user_id) REFERENCES users(id),
		ADD CONSTRAINT transaction_orders_id_fk FOREIGN KEY (orders_id) REFERENCES orders(id),
		ADD CONSTRAINT transaction_pay_system_id_fk FOREIGN KEY (pay_system_id) REFERENCES pay_systems(id);
	
	
-- Добавление представления
-- 1. Представление. Для работы с отправкой заказов
CREATE OR REPLACE VIEW orders_profile (order_id, order_created, status, status_date, customer, phone, address, comments) AS
SELECT 
	id AS "№ заказа",
	created_at AS "дата заказа",
	(SELECT name FROM order_status WHERE order_status.id = orders.order_status_id) AS 'Статус заказа',
	(SELECT updated_at FROM order_status WHERE order_status.id = orders.order_status_id) AS 'Дата статуса',
	(SELECT CONCAT(first_name,' ',last_name) FROM profiles WHERE profiles.id = orders.profile_id) AS 'Получатель заказа',
	(SELECT phone FROM profiles WHERE profiles.id = orders.profile_id) AS 'Контактный телефон',
	(SELECT CONCAT(country,', ',city,' ',zip,', ',address) FROM profiles WHERE profiles.id = orders.profile_id) AS 'Адрес отправки заказа',
	note AS "Комментарий к заказу"
FROM orders
	ORDER BY id;

-- Проверяем
SELECT * FROM orders_profile; # все заказы
SELECT * FROM orders_profile WHERE status = "Подтвержден"; # заказы готовы к отгрузке


-- 2. Представление. Выводит сводную информацию о товаре
CREATE OR REPLACE VIEW products_info (id, name, sku, brand, product_size, color, stock, price) AS
SELECT 
	id,
	name AS 'Товар',
	sku AS 'Артикул',
	(SELECT name FROM brands WHERE id = brand_id) AS 'Бренд',
	(SELECT name FROM size WHERE id = size_id) AS 'Размер',
	(SELECT name FROM color WHERE id = color_id) AS 'Цвет',
	(SELECT avaible FROM stock WHERE id = products.id) AS 'Остатки товара',
	price AS 'Цена'
FROM products ORDER BY price;

-- Проверяем
SELECT * FROM products_info; # все товары
SELECT * FROM products_info WHERE color = 'серый'; # только товар серого цвета
				

-- Запросы		
-- 1. Запросю. Для ЛК покупатея, все отзывы о товарах с сортировкой по дате обноления (без join)
SELECT 
	(SELECT CONCAT(first_name,' ',last_name) FROM users WHERE users.id = user_id) AS 'Покупатель',
	rating AS 'Оценка товара',
	description AS 'Отзыв о товаре',
	(SELECT name FROM products WHERE id = user_id) AS 'Товар',
	updated_at AS 'Дата отзыва'
FROM reviews WHERE user_id = 1 ORDER BY updated_at;

-- 2. Выводим описание товара и его свойства и раздел каталога
SELECT 
	id,
	name AS 'Товар',
	sku AS 'Артикул',
	(SELECT name FROM brands WHERE id = brand_id) AS 'Бренд',
	description AS 'Описание товара',
	(SELECT name FROM size WHERE id = size_id) AS 'Размер',
	(SELECT name FROM color WHERE id = color_id) AS 'Цвет',
	(SELECT reserve FROM stock WHERE id = products.id) AS 'Зарезервированный торар',
	(SELECT avaible FROM stock WHERE id = products.id) AS 'Остатки товара',
	(SELECT categories.name FROM categories WHERE categories.id = products.id) AS 'Раздел',
	price AS 'Цена'
FROM products ORDER BY price ;

-- 3. Выбираем самые дорогие товары в ассортименте
SELECT
	id,
	name,
	price 
FROM products
	WHERE price = (SELECT MAX(price) FROM products);

-- 4. Средняя цена товара белого цвета.
SELECT 
	AVG(price)
FROM
	(SELECT * FROM products WHERE color_id=1) AS prod;

-- Триггеры
-- Триггер. Записываем в лог безопасности какой и когда был добавлен продукт
DROP TRIGGER IF EXISTS watchlog_products;
delimiter //
CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;

