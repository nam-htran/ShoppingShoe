-- Create the TuanShoes database without specifying collation
CREATE DATABASE TuanShoes
GO

USE TuanShoes;
GO

-- Create the users table without Vietnamese collation for string fields
CREATE TABLE users (
    userId INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) NOT NULL UNIQUE,  -- Removed COLLATE clause
    password NVARCHAR(255) NOT NULL,  -- Removed COLLATE clause
    email NVARCHAR(100),  -- Removed COLLATE clause
    fullName NVARCHAR(100),  -- Removed COLLATE clause
    phone NVARCHAR(15),  -- Removed COLLATE clause
    address NVARCHAR(255),  -- Removed COLLATE clause
    role NVARCHAR(50) NOT NULL  -- Removed COLLATE clause
);
GO

-- Create the category table without Vietnamese collation for string fields
CREATE TABLE category (
    categoryId INT PRIMARY KEY IDENTITY(1,1),
    categoryName NVARCHAR(100) NOT NULL  -- Removed COLLATE clause
);
GO

-- Create the products table with price as DECIMAL and availability columns
CREATE TABLE products (
    productId INT PRIMARY KEY IDENTITY(1,1),
    productName NVARCHAR(100) NOT NULL,  -- Removed COLLATE clause
    price DECIMAL(10,2) NOT NULL,  -- Price as DECIMAL for calculations
    quantity INT NOT NULL, 
    color NVARCHAR(50),  -- Removed COLLATE clause
    categoryId INT,
    img NVARCHAR(255),  -- Removed COLLATE clause
    isAvailable BIT NOT NULL DEFAULT 1,  -- Availability column (1 = in stock, 0 = out of stock)
    sizes NVARCHAR(255),  -- Removed COLLATE clause
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);
GO

-- Create the orders table without Vietnamese collation for string fields
CREATE TABLE orders (
    orderId INT PRIMARY KEY IDENTITY(1,1),
    userId INT NOT NULL,
    orderDate DATETIME DEFAULT GETDATE(),
    totalPrice DECIMAL(10,2) NOT NULL,  -- Price as DECIMAL for consistency
    address NVARCHAR(255) NOT NULL,  -- Removed COLLATE clause
    status NVARCHAR(50) DEFAULT 'Pending',  -- Removed COLLATE clause
    FOREIGN KEY (userId) REFERENCES users(userId)
);
GO

-- Create the order_detail table with price as DECIMAL
CREATE TABLE order_detail (
    orderDetailId INT PRIMARY KEY IDENTITY(1,1),
    orderId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,  -- Price as DECIMAL for consistency
    size NVARCHAR(50),  -- Removed COLLATE clause
    FOREIGN KEY (orderId) REFERENCES orders(orderId),
    FOREIGN KEY (productId) REFERENCES products(productId)
);
GO

-- Insert data into category
INSERT INTO category (categoryName) VALUES 
    ('Sneakers'), 
    ('Boots'), 
    ('Sandals');
GO

-- Insert data into users
INSERT INTO users (username, password, email, fullName, phone, address, role)
VALUES 
    ('customer1', '12345', 'customer1@example.com', 'Customer One', '0123456789', 'Ho Chi Minh', 'customer'),
    ('admin', '12345', 'admin@example.com', 'Admin User', '0987654321', 'Ho Chi Minh', 'admin');
GO

-- Insert data into orders
INSERT INTO orders (userId, totalPrice, address, status)
VALUES (1, 270.00, 'Ha Noi', 'Shipped');
GO

-- Insert data into order_detail
INSERT INTO order_detail (orderId, productId, quantity, price, size)
VALUES 
    (1, 1, 1, 120.00, '7'),
    (1, 2, 1, 150.00, '8');
GO

-- Query with formatted price
-- Insert data into category table
INSERT INTO category (categoryName) VALUES 
('Running Shoes'),
('Casual Sneakers'),
('Formal Shoes'),
('Boots'),
('Sandals'),
('Slippers'),
('Basketball Shoes'),
('Tennis Shoes'),
('Soccer Cleats'),
('Hiking Boots');

-- Insert sample data into the products table
INSERT INTO products (productName, price, quantity, color, categoryId, img, isAvailable, sizes) VALUES
('Nike Air Zoom Pegasus 40', 2767764, 50, 'Black', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCJvMd_mP-PCGCh6MRHv8Hr1kbhL-qopHaGQ&s', 1, '7,8,9,10,11'),
('Adidas Ultraboost 22', 4231225, 30, 'White', 1, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/092/products/ultraboost-22-djen-gz0127-01-standard.jpg', 1, '6,7,8,9,10'),
('Puma Deviate Nitro 2', 3554205, 20, 'Blue', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH56Cg5qBB5vy_E9Ro4bSB_918bMWXgl6ARQ&s', 1, '8,9,10,11'),
('Vans Old Skool', 1545571, 40, 'Black/White', 2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTS56BFV-r3hoL-MnQIiJFdXXB8rabfMRbo5w&s', 1, '7,8,9,10'),
('Converse Chuck Taylor All Star', 1286520, 60, 'Red', 2, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/347/923/products/121186-1.jpg', 1, '6,7,8,9,10,11'),
('Timberland 6-Inch Premium Boots', 4688280, 15, 'Brown', 4, 'https://cdn.authentic-shoes.com/wp-content/uploads/2023/05/timberland-mens-6-inch-premium-w.png', 1, '8,9,10,11,12'),
('Dr. Martens 1460', 3603850, 25, 'Black', 4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4lO5KFTgLHEJWPM3U5C7XoKe-jBOTTynNKQ&s', 1, '7,8,9,10,11'),
('Birkenstock Arizona Sandals', 2363710, 45, 'Brown', 5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvEwfgfo5AmTr56UH2RpPGyUfppCA9eTKmUg&s', 1, '6,7,8,9'),
('Crocs Classic Clog', 1167670, 100, 'Green', 6, 'https://www.crocs.com.vn/cdn/shop/products/10001-2Y2-2_1400x.jpg?v=1664259807', 1, '6,7,8,9,10'),
('Adidas Harden Vol. 7', 3554205, 25, 'Black/Red', 7, 'https://bizweb.dktcdn.net/thumb/grande/100/425/004/products/368308256-264480919688198-7523282906323671717-n-1692791386550.jpg?v=1692791390993', 1, '7,8,9,10,11'),
('Nike Court Air Zoom Vapor Pro', 3287920, 30, 'White', 8, 'https://authentic-shoes.com/wp-content/uploads/2023/12/httpshypebeast.comimage202311adi.png', 1, '6,7,8,9'),
('Adidas Adizero Ubersonic 4', 3083250, 20, 'Blue', 8, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDgnSfe0RvY9U2OKmVYL66vXwYxJD6ZmFmiQ&s', 1, '6,7,8,9'),
('Nike Tiempo Legend 9', 5292000, 10, 'Black', 9, 'https://i0.wp.com/azzurro-sport.com/wp-content/uploads/2021/06/Nike-Tiempo-Legend-9-Academy-TF-DA1191-146-1.jpg?fit=1065%2C1065&ssl=1', 1, '7,8,9,10'),
('Adidas Predator Edge+', 5772000, 15, 'Silver', 9, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvc5CURE52eOXK4hMZhFee21sd5USlbtNuJA&s', 1, '6,7,8,9'),
('Salomon Quest 4 GTX', 4938000, 10, 'Green', 10, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-hXoLV8mHcMlmC0seqOfredKjYopcWinXqQ&s', 1, '8,9,10,11'),
('Columbia Newton Ridge Plus', 3960000, 20, 'Brown', 10, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfcvjnK9-v1pBqmFdpKwwXtOAEEZJ550YZCw&s', 1, '8,9,10,11'),
('Reebok Classic Leather', 1771350, 50, 'White', 2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZxj10Z6A5GD9J5x8y_-nhAZmu5ev5ndHohw&s', 1, '6,7,8,9,10'),
('Skechers Go Walk 6', 1411600, 70, 'Gray', 6, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzHdslCQcgc91ACT1FWfJS7nXKK75KnRmHoQ&s', 1, '6,7,8,9'),
('ASICS Gel-Kayano 29', 3792000, 25, 'Blue', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlHeYanqOtOeTzFgix-iBnkyoECUxRLjr5FQ&s', 1, '7,8,9,10,11'),
('Hoka One One Clifton 9', 3287920, 20, 'Yellow', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS0wZtf5GHnMHcEwgM_n9uoE4X__y_bIxcPg&s', 1, '7,8,9,10,11'),
('New Balance 1080v12', 3996000, 30, 'Gray', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF_72yIQivSD5vnYlwzj_RO9X5DjkPYlDs8g&s', 1, '7,8,9,10'),
('Fila Disruptor II', 1613100, 40, 'Black', 2, 'https://bizweb.dktcdn.net/100/289/867/files/fila-heritage-disruptor-ii-white-2.jpg?v=1533143280331', 1, '6,7,8,9'),
('ECCO Helsinki 2', 3603850, 20, 'Brown', 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7ymxVuzDdAw9xuwCS34Jn0LJti7M11UdKag&s', 1, '7,8,9,10'),
('Clarks Tilden Walk', 2111300, 30, 'Black', 3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqpP7_aTi32dks-6eNhut-WUDo_x-4pkURbA&s', 1, '8,9,10,11'),
('Nike SB Dunk Low', 2534000, 20, 'Pink', 2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTE7fJ56ElSjDXF6R6kWgIf4CVN6hn0ouB1SQ&s', 1, '6,7,8,9'),
('Puma RS-X3', 2534000, 40, 'Multi-color', 2, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKNN7CB2YfAxTYSvgdjb3SPARgkbXelzuN5g&s', 1, '6,7,8,9,10'),
('Under Armour HOVR Phantom 3', 3287920, 15, 'Red', 1, 'https://www.underarmour.in/media/catalog/product/cache/a6c9600f6d89dc76028bfa07e5e1eb9a/3/0/3026953-120230829073211547.png', 1, '7,8,9,10,11'),
('Brooks Ghost 15', 3068800, 25, 'Gray', 1, 'https://www.brooksrunning.com/dw/image/v2/BGPF_PRD/on/demandware.static/-/Sites-brooks-master-catalog/default/dw9c96810c/original/110393/110393-462-l-ghost-15-mens-neutral-cushion-running-shoe.jpg?sw=425&sh=425&sm=fit&sfrm=png&bgcolor=F8F8F8', 1, '7,8,9,10');
