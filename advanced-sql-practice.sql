-- Practice: Generating a Database
-- Practice: SQL - 2 - Advanced SQL Queries - Joins, Subqueries, Grouping

START TRANSACTION;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(25),
    last_name VARCHAR(25),
    email VARCHAR(50)
);

CREATE TABLE orders(
	id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items(
	id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    item_name VARCHAR(50),
    item_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO customers(first_name, last_name, email)
VALUES ('Rina', 'Rai', 'rina@rai.com'), ('Bina', 'Ale', 'bina@ale.com'), ('Mina', 'KC', 'Mina@kc.com'), ('Gina', 'Rai', 'gina@rai.com');

INSERT INTO orders(customer_id, order_date, total_amount)
VALUES (1, '2025-01-01', 1000), (2, '2026-01-02', 550), (2, '2025-10-7', 250), (1, '2022-01-02', 800);

INSERT INTO order_items(order_id, item_name , item_price)
VALUES (1, 'Water Bottle', 20), (2, 'Calculator', 30), (2, 'Pen', 5), (3, 'Airphone', 15);

-- Task 1 - Inner Join
SELECT orders.id, customers.first_name, customers.last_name, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;


-- Task 2 - left join
SELECT orders.id, customers.first_name, customers.last_name, orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

-- Task 3 - GROUP BY with SUM to find the total amount spent by each customer:
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- Task 4 - GROUP BY with COUNT
SELECT customer_id, COUNT(id) AS total_orders
FROM orders
GROUP BY customer_id;

-- Task 5 - WHERE clause
SELECT * FROM orders
WHERE total_amount < 600;

-- task 6 - HAVING clause
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) < 2000;

-- Task - 7 - Subquery
SELECT *
FROM orders
WHERE customer_id IN (
    SELECT id FROM customers WHERE last_name = 'Smith'
);

-- From this activity, I learned using SQL JOINs, GROUP BY with aggregate functions, HAVING, and
-- subqueries to analyze customer order data. I learned how different joins affect results and
-- how aggregation helps summarize the information. The difficult part for me was understanding the
-- difference between WHERE and HAVING when working with grouped data.