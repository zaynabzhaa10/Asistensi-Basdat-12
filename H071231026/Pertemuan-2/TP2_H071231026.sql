USE classmodels;

-- Nomor 1--
SELECT productCode, productName, quantityInStock
FROM products
WHERE quantityInStock >= 5000
AND quantityInStock <= 6000
ORDER BY quantityInStock;

-- Nomor 2--
SELECT orderNumber, orderDate, STATUS, customerNumber
FROM orders
WHERE STATUS != 'shipped'
ORDER BY orderNumber;

-- Nomor 3 --
SELECT employeeNumber, firstName, lastName, email, jobTitle
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY firstName
LIMIT 10;

-- Nomor 4--
SELECT productCode, productName, productLine, buyPrice
FROM products
ORDER BY buyPrice DESC
LIMIT 5, 10;

-- Nomor 5--
SELECT DISTINCT country, city
FROM customers
ORDER BY country, city;

-- Nomor 6--
SELECT * FROM employees 
WHERE firstName = 'Gerard';

SELECT customerName, city, country, salesRepEmployeeNumber
FROM customers
WHERE salesRepEmployeeNumber = 1370;
