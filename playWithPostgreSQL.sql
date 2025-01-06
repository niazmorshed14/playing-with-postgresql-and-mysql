SELECT * FROM actor; selects all the columns from the actor table;
--
SELECT first_name FROM actor;
--
SELECT actor_id, first_name, last_name FROM actor;
--
SELECT customer_id, payment_date, amount FROM payment;
--
SELECT * FROM film;
-- 
SELECT DISTINCT release_year FROM film;
--
SELECT DISTINCT release_year, rental_rate FROM film;
--
SELECT DISTINCT first_name FROM customer;
--
SELECT COUNT(*) FROM payment;
--
SELECT DISTINCT amount FROM payment;
--
SELECT COUNT (DISTINCT (amount)) FROM payment;
--
SELECT * FROM customer 
WHERE first_name = 'Barbara';
--
SELECT * FROM film 
WHERE rental_rate > 4;
--
SELECT * FROM film 
WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating = 'R';
--
SELECT COUNT(*) FROM film WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating = 'R';
--
SELECT * FROM film WHERE rating = 'R' OR rating = 'G'; 
--
SELECT title, replacement_cost 
FROM film WHERE release_year >= 2000 AND rating = 'PG-13';
--
SELECT title FROM film 
WHERE rating = 'PG' AND replacement_cost = 10.99;
--
SELECT title FROM film WHERE release_year < 2000 OR replacement_cost < 10;
--
SELECT * FROM customer ORDER BY first_name ASC;
--
SELECT * FROM customer ORDER BY first_name DESC;
--
SELECT * FROM customer ORDER BY store_id, first_name ASC;
--
SELECT 
	 store_id, 
	 first_name, 
	 last_name 
 FROM customer 
 ORDER BY 
	 store_id ASC, 
	 first_name DESC;
--
SELECT * FROM payment WHERE amount != 0.99 ORDER BY payment_date ASC LIMIT 10;
--
SELECT * FROM payment WHERE amount BETWEEN 8 AND 9;
--
SELECT * FROM payment WHERE amount NOT BETWEEN 8 AND 9;
--
SELECT * FROM payment WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15'
--
SELECT DISTINCT(amount) FROM payment;
--
SELECT * FROM payment WHERE amount IN ('1.99', '9.98', '7.99') ORDER BY amount ASC;
--
SELECT * FROM payment WHERE amount NOT IN ('0.00', '1.99', '9.98', '7.99') ORDER BY amount ASC;
--
SELECT * FROM customer WHERE first_name IN ('John', 'Jake');
--
SELECT * FROM customer WHERE first_name LIKE ('J%');
--
SELECT * FROM customer WHERE first_name ILIKE ('%T');
--
SELECT COUNT(*) FROM customer WHERE first_name LIKE ('J%');
--
SELECT * FROM customer WHERE first_name LIKE ('J%') AND last_name LIKE('S%');
--
SELECT * FROM customer WHERE first_name LIKE ('%er');
--
SELECT * FROM customer WHERE first_name LIKE ('_er%'); -- letter present before er
--
SELECT * FROM customer WHERE first_name LIKE ('_er_'); -- letter present before and after er
--
SELECT * FROM customer WHERE first_name NOT LIKE ('_er_');
--
SELECT MIN(replacement_cost) FROM film;
--
SELECT MAX(replacement_cost) FROM film;
--
SELECT MAX(replacement_cost), MIN(replacement_cost) FROM film;
--
SELECT AVG(replacement_cost) FROM film;
--
SELECT ROUND (AVG(replacement_cost), 3) FROM film; --upto 3 decimal point
--
SELECT SUM (replacement_cost) FROM film;
--
SELECT customer_id FROM payment GROUP BY customer_id;
--
SELECT customer_id, SUM (amount) FROM payment GROUP BY customer_id; --checking which customer spends maximum ammount
--
SELECT customer_id, SUM (amount) FROM payment 
	GROUP BY customer_id ORDER BY SUM(amount) ASC;
--
SELECT customer_id, staff_id, SUM (amount) FROM payment 
	GROUP BY customer_id, staff_id ORDER BY SUM(amount) DESC;
--
SELECT DATE(payment_date), SUM(amount) FROM payment 
	GROUP BY DATE(payment_date) ORDER BY SUM(amount); --only display the payment date on the full timestamp. finding out total amount spent on each date
--
SELECT customer_id, COUNT(amount) 
	FROM payment 
	GROUP BY customer_id  
	ORDER BY COUNT(amount) --finding total amount of transactions per each customer
--
SELECT staff_id, COUNT(amount) FROM payment 
	GROUP BY staff_id ORDER BY COUNT(amount)
--
SELECT customer_id, SUM(amount) FROM payment 
	GROUP BY customer_id HAVING SUM (amount) > 100;
--
SELECT COUNT(amount) FROM payment; --total number of transaction from the payment table
--
SELECT COUNT(amount) AS number_of_transactions FROM payment;
--
SELECT customer_id, SUM(amount) AS total_spent_amount 
	FROM payment 
	GROUP BY customer_id;
