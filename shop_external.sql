-- ���������� ������� ������

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
	
	
-- ���������� �������������
-- 1. �������������. ��� ������ � ��������� �������
CREATE OR REPLACE VIEW orders_profile (order_id, order_created, status, status_date, customer, phone, address, comments) AS
SELECT 
	id AS "� ������",
	created_at AS "���� ������",
	(SELECT name FROM order_status WHERE order_status.id = orders.order_status_id) AS '������ ������',
	(SELECT updated_at FROM order_status WHERE order_status.id = orders.order_status_id) AS '���� �������',
	(SELECT CONCAT(first_name,' ',last_name) FROM profiles WHERE profiles.id = orders.profile_id) AS '���������� ������',
	(SELECT phone FROM profiles WHERE profiles.id = orders.profile_id) AS '���������� �������',
	(SELECT CONCAT(country,', ',city,' ',zip,', ',address) FROM profiles WHERE profiles.id = orders.profile_id) AS '����� �������� ������',
	note AS "����������� � ������"
FROM orders
	ORDER BY id;

-- ���������
SELECT * FROM orders_profile; # ��� ������
SELECT * FROM orders_profile WHERE status = "�����������"; # ������ ������ � ��������


-- 2. �������������. ������� ������� ���������� � ������
CREATE OR REPLACE VIEW products_info (id, name, sku, brand, product_size, color, stock, price) AS
SELECT 
	id,
	name AS '�����',
	sku AS '�������',
	(SELECT name FROM brands WHERE id = brand_id) AS '�����',
	(SELECT name FROM size WHERE id = size_id) AS '������',
	(SELECT name FROM color WHERE id = color_id) AS '����',
	(SELECT avaible FROM stock WHERE id = products.id) AS '������� ������',
	price AS '����'
FROM products ORDER BY price;

-- ���������
SELECT * FROM products_info; # ��� ������
SELECT * FROM products_info WHERE color = '�����'; # ������ ����� ������ �����
				

-- �������		
-- 1. �������. ��� �� ���������, ��� ������ � ������� � ����������� �� ���� ��������� (��� join)
SELECT 
	(SELECT CONCAT(first_name,' ',last_name) FROM users WHERE users.id = user_id) AS '����������',
	rating AS '������ ������',
	description AS '����� � ������',
	(SELECT name FROM products WHERE id = user_id) AS '�����',
	updated_at AS '���� ������'
FROM reviews WHERE user_id = 1 ORDER BY updated_at;

-- 2. ������� �������� ������ � ��� �������� � ������ ��������
SELECT 
	id,
	name AS '�����',
	sku AS '�������',
	(SELECT name FROM brands WHERE id = brand_id) AS '�����',
	description AS '�������� ������',
	(SELECT name FROM size WHERE id = size_id) AS '������',
	(SELECT name FROM color WHERE id = color_id) AS '����',
	(SELECT reserve FROM stock WHERE id = products.id) AS '����������������� �����',
	(SELECT avaible FROM stock WHERE id = products.id) AS '������� ������',
	(SELECT categories.name FROM categories WHERE categories.id = products.id) AS '������',
	price AS '����'
FROM products ORDER BY price ;

-- 3. �������� ����� ������� ������ � ������������
SELECT
	id,
	name,
	price 
FROM products
	WHERE price = (SELECT MAX(price) FROM products);

-- 4. ������� ���� ������ ������ �����.
SELECT 
	AVG(price)
FROM
	(SELECT * FROM products WHERE color_id=1) AS prod;

-- ��������
-- �������. ���������� � ��� ������������ ����� � ����� ��� �������� �������
DROP TRIGGER IF EXISTS watchlog_products;
delimiter //
CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;

