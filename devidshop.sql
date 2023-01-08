create database devidshop;
use devidshop;

-- Create a table for storing user information
CREATE TABLE users (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  image VARCHAR(255),
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  city VARCHAR(50) NOT NULL,
  state CHAR(2) NOT NULL,
  zip_code CHAR(5) NOT NULL,
  phone VARCHAR(15) NOT NULL,
  user_role ENUM('customer', 'admin', 'staff') DEFAULT 'customer',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a table for storing categories information
CREATE TABLE categories (
	id INTEGER AUTO_INCREMENT primary KEY,
    cate_name VARCHAR(255) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a table for storing product information
CREATE TABLE products (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  cate_id INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  view_total INTEGER NOT NULL,
  sale_off INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cate_id) REFERENCES categories(id)
);

-- Create a table for storing colors
CREATE TABLE colors (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  hex_code CHAR(6) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a table for storing sizes
CREATE TABLE sizes (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a table for storing product images
CREATE TABLE product_images (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  product_id INTEGER NOT NULL,
  image VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Create a table for storing product color options
CREATE TABLE product_colors (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  product_id INTEGER NOT NULL,
  color_id INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (color_id) REFERENCES colors(id)
);

-- Create a table for storing product size options
CREATE TABLE product_sizes (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  product_id INTEGER NOT NULL,
  size_id INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (size_id) REFERENCES sizes(id)
);

CREATE TABLE sale_off (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    sale_code VARCHAR(255) NOT NULL,
    count INTEGER NOT NULL,
    sale_percent INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sale_off_storage (
	sale_off_id INTEGER AUTO_INCREMENT NOT NULL,
    user_id INTEGER NOT NULL,
    sale_code VARCHAR(255) NOT NULL,
    count INTEGER NOT NULL,
    sale_percent INTEGER NOT NULL,
    FOREIGN KEY (sale_off_id) REFERENCES sale_off(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create a table for storing categories information
CREATE TABLE comments (
	id INTEGER AUTO_INCREMENT primary KEY,
    user_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    comd_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);


-- Create a table for storing orders
CREATE TABLE orders (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  status ENUM('pending', 'paid', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create a table for storing order items
CREATE TABLE order_items (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE news (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    sub_title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE banners (
	id INTEGER AUTO_INCREMENT PRIMARY KEY,
    image VARcHAR(255),
    title VARCHAR(255) NOT NULL,
    sub_title VARCHAR(255) NOT NULL,
    bg_color VARCHAR(255) NOT NULL,
    nav_link TEXT NOT NULL
);
SELECT products.*,
       GROUP_CONCAT(product_image.image SEPARATOR ',') AS images FROM products
JOIN product_image ON products.id = product_image.product_id
GROUP BY products.id;


drop table banners, news, users, categories, products, order_items, orders, comments, product_colors, product_size, product_image, sale_off, sale_off_storage;
drop table product_images, product_colors, product_sizes, sizes, colors;
INSERT INTO categories (cate_name) values ("Áo phông");
-- Insert a color
INSERT INTO colors (name, hex_code)
VALUES ('blue', '0000FF'),('white', 'fff'),('Red', 'FF0000');
	
select * from colors;

-- Insert a size
INSERT INTO sizes (name)
VALUES ('small'),('medium'),('Large');

-- Insert a product image
INSERT INTO product_images (product_id, image)
VALUES 
(2 , 'https://bucket.nhanh.vn/store/25618/artCT/87003/ao_thun_dep_1.jpg'),
(1, 'https://lh3.googleusercontent.com/CX1Hg1a3Set1C1V1-zcioxVWYVyUQQKrOV2eZr6JUfpM1zmlZp8HOyH_PNpEDJQORLMnfz924JL7_tbuGdw5z9vFkG2EkBJRwoS1BxoEKCktIlXpHcHW-dinZlRDa_8brYVZzVC3');

update product_images set image = 'https://lh3.googleusercontent.com/CX1Hg1a3Set1C1V1-zcioxVWYVyUQQKrOV2eZr6JUfpM1zmlZp8HOyH_PNpEDJQORLMnfz924JL7_tbuGdw5z9vFkG2EkBJRwoS1BxoEKCktIlXpHcHW-dinZlRDa_8brYVZzVC3' where id = 1;

-- Associate a color with the product
INSERT INTO product_colors (product_id, color_id)
VALUES
(2, 2),
(2, 3), 
(1, 2),
(1, 1);

-- Associate a size with the product
INSERT INTO product_sizes (product_id, size_id)
VALUES (2, 1),(2, 2),(1, 1);

INSERT INTO products (cate_id, description, name, price, view_total, sale_off) values (1, "Shirt made of soft and durable material", "blue t-shirt", 220.50, 0, 0);
INSERT INTO products (cate_id, description, name, price, view_total, sale_off) values (1, "The shirt is made of durable materials, the design is modern and cool", "sundree t-shirt", 300.00, 0, 20);
update products set name = 'sundree t-shirt' where id = 2;
update products set description = 'The shirt is made of durable materials, the design is modern and cool' where id = 2;
select * from products;

-- SELECT p.*, i.image, c.name AS color, s.name AS size
-- FROM products AS p
-- LEFT JOIN product_images AS i ON p.id = i.product_id
-- LEFT JOIN product_colors AS pc ON p.id = pc.product_id
-- LEFT JOIN colors AS c ON pc.color_id = c.id
-- LEFT JOIN product_sizes AS ps ON p.id = ps.product_id
-- LEFT JOIN sizes AS s ON ps.size_id = s.id;

-- SELECT p.*, GROUP_CONCAT(i.image) AS images, GROUP_CONCAT(c.name) AS colors, GROUP_CONCAT(s.name) AS sizes
-- FROM products AS p
-- LEFT JOIN product_images AS i ON p.id = i.product_id
-- LEFT JOIN product_colors AS pc ON p.id = pc.product_id
-- LEFT JOIN colors AS c ON pc.color_id = c.id
-- LEFT JOIN product_sizes AS ps ON p.id = ps.product_id
-- LEFT JOIN sizes AS s ON ps.size_id = s.id
-- GROUP BY p.id;

SELECT p.*, GROUP_CONCAT(DISTINCT i.image) AS images, GROUP_CONCAT(DISTINCT c.name) AS colors, GROUP_CONCAT(DISTINCT s.name) AS sizes FROM products AS p LEFT JOIN product_images AS i ON p.id = i.product_id LEFT JOIN product_colors AS pc ON p.id = pc.product_id LEFT JOIN colors AS c ON pc.color_id = c.id LEFT JOIN product_sizes AS ps ON p.id = ps.product_id LEFT JOIN sizes AS s ON ps.size_id = s.id GROUP BY p.id having p.name like '%%';

INSERT INTO users (first_name, last_name, image, email, password, address, city, state, zip_code, phone, user_role)
VALUES ('John', 'Doe', 'john_doe.jpg', 'john@example.com', 'mypassword', '123 Main St', 'New York', 'ON', '10001', '123-456-7890', 'customer');

select * from users;
update users set state = 'ON' where id = 1;

INSERT INTO sale_off (sale_code, count, sale_percent)
VALUES ('BLACKFRIDAY', 100, 20);


INSERT INTO sale_off_storage (sale_off_id, user_id, sale_code, count, sale_percent)
VALUES (1, 1, 'BLACKFRIDAY', 1, 20);
