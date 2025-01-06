USE sql_inventory; -- selecting a database
-- 
SELECT name, unit_price, unit_price*10 AS new_price FROM products;
-- 
SELECT * FROM orders WHERE order_date BETWEEN '2018-01-01' and '2018-12-31';
-- 
SELECT * FROM order_items WHERE order_id = 6 AND quantity * unit_price > 30;
-- 
SELECT * FROM customers WHERE last_name REGEXP 'field|mac|rose'; -- finds all the customers having the words in their last name
-- 
SELECT * FROM customers WHERE last_name REGEXP '[gim]e'; -- there should g or i or m before 'e'
-- 
SELECT * FROM customers WHERE last_name REGEXP '[a-h]e'; -- any character between a to h should be present before e
-- 
SELECT * FROM orders WHERE shipped_date IS NULL; 
-- 
SELECT first_name, last_name FROM customers ORDER BY birth_date DESC;
-- 
SELECT *, quantity * unit_price AS total_price FROM order_items WHERE order_id = 6 ORDER BY total_price DESC;
-- 
SELECT * FROM customers LIMIT 4, 2; -- skipped first 4 customers and printed only 2 customers which is 5,6

-- inner join 
SELECT order_id, products.product_id, name, quantity, order_items.unit_price 
	FROM order_items 
	INNER JOIN products 
		ON order_items.product_id = products.product_id;

-- joining across databases
SELECT * FROM order_items 
	JOIN sql_inventory.products 
		ON order_items.product_id = sql_inventory.products.product_id;

-- self joins: joining table with itself 
SELECT 
	employees.employee_id,
    employees.first_name as employee_name,
    managers.first_name as manager_name,
    managers.employee_id as manager_id
FROM employees JOIN employees as managers 
ON employees.reports_to = managers.employee_id;

-- joining multiple tables
  SELECT 
	  o.order_id,
      o.order_date,
      c.first_name,
      os.name as status
	FROM orders o
		JOIN customers c
			ON o.customer_id = c.customer_id
		JOIN order_statuses os
			ON o.status = os.order_status_id;

-- compound join codnitions
SELECT * FROM 
	order_items AS oi
    JOIN order_item_notes AS oin
		ON oi.order_id = oin.order_Id
        AND oi.product_id = oin.product_id;

-- outer joins
SELECT 
		c.customer_id,
		c.first_name,
		o.customer_id
  FROM customers c 
	LEFT JOIN orders o
		ON c.customer_id = o.customer_id
	    ORDER BY c.customer_id;
        
-- another example of outer join     
SELECT 
	 c.customer_id,
     c.first_name,
     o.customer_id
	FROM orders o 
		RIGHT JOIN customers c
			ON c.customer_id = o.customer_id
		ORDER BY c.customer_id;
    
-- outer joins between multiple tables
SELECT 
	 c.customer_id,
     c.first_name AS customer_name,
     o.order_id,
     sh.name AS shipper_name
 FROM customers c 
	LEFT JOIN orders o
		ON c.customer_id = o.customer_id
	LEFT JOIN shippers sh
		ON o.shipper_id = sh.shipper_id
	ORDER BY c.customer_id;

-- self outer joins
SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS managers
 FROM employees e 
	LEFT JOIN employees m
		ON e.reports_to = m.employee_id;
        
-- The USING clause. Can only be used if the column names are same in differen tables
SELECT 
	o.order_id,
    c.first_name
 FROM orders o
	JOIN customers c
		USING (customer_id); -- which is equivalent of [ON o.customer_id = c.customer_id]
    
-- cross joins
 SELECT 
	c.first_name AS customer_name,
    p.name AS product_name
 FROM customers c
 CROSS JOIN products p
 ORDER BY c.first_name;

-- unions
SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

-- another example of union
SELECT 
	customer_id,
    first_name,
    points,
    "Bronze" AS type 
FROM customers
WHERE points < 2000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    "Silver" AS type 
FROM customers
WHERE points BETWEEN  2000 AND 3000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    "GOLD" AS type 
FROM customers
WHERE points > 3000
ORDER BY first_name ASC;

-- inserting single row
 INSERT INTO customers
 VALUES (
	  DEFAULT, 
     'Md. Niaz', 
     'Morshed', 
      NULL,
      NULL,
     'Dhaka South',
     'Dhaka',
     'BD',
     100);

-- inserting multiple rows
INSERT INTO shippers (name)
VALUES ('Niaz Shipper 1'), ('Niaz Shipper 2'), ('Niaz Shipper 3');

-- inserting hierarchical rows
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2012-01-02', 1);
INSERT INTO orders_items
VALUES (LAST_INSERT_ID(), 19, 1, 2.99),
	   (LAST_INSERT_ID(), 12, 4, 3.99);
       
-- copying all data from one table to another
CREATE TABLE orders_archived AS
SELECT * FROM orders;

-- copying subset of data from one table to another
INSERT INTO orders_archived 
SELECT * FROM orders WHERE order_date < '2019-01-01';

-- updating rows
UPDATE invoices
SET payment_total = 100,
	payment_date = '2020-01-01'
WHERE invoice_id = 1;

-- another example of updating rows
UPDATE invoices
SET payment_total = invoice_total * 50,
	payment_date = due_date
WHERE client_id = 3;

-- using subqueries in updates
UPDATE invoices
SET payment_total = invoice_total * 50,
	payment_date = due_date
WHERE client_id IN 
	        (SELECT client_id
	        FROM clients
	        WHERE state IN ('CA', 'NY'));
-- deleting rows
DELETE FROM invoices; -- deletes all records from table

-- another example of deleting rows
DELETE FROM invoices 
WHERE invoice_id = 1;

-- deleting rows using subqueries 
DELETE FROM invoices 
WHERE client_id = (
		SELECT * FROM clients 
		WHERE client_id = 1);
        
        
-- using Case in query
SELECT 
	student_id,
    totalSemesterFees,
    CASE 
		WHEN totalSemesterFees < 1500 THEN 'Low'
        WHEN totalSemesterFees BETWEEN 1500 AND 1800 THEN 'Medium'
        ELSE 'High'
	END AS fee_category
FROM studentAcademic;