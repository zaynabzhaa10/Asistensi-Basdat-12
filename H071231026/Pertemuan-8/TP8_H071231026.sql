-- Tugas Praktikum 8 --
USE classicmodels;

#Nomor 1

(SELECT 
		productName,
		SUM(priceEach * quantityOrdered) AS TotalRevenue,
		'Pendapatan Tinggi' AS 'Pendapatan'
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
WHERE MONTH(orderDate) = 9
GROUP BY productName
ORDER BY TotalRevenue DESC
LIMIT 5)

UNION

(SELECT 
		productName,
		SUM(priceEach * quantityOrdered) AS TotalRevenue,
		'Pendapatan Pendek (kayak kamu)' AS 'Pendapatan'
FROM products
JOIN orderdetails
USING(productCode)
JOIN orders
USING(orderNumber)
WHERE MONTH(orderDate) = 9
GROUP BY productName
ORDER BY TotalRevenue ASC
LIMIT 5);

#Nomor 2

SELECT productName
FROM products

EXCEPT

SELECT productName
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
WHERE o.customerNumber IN
							(SELECT customerNumber
							FROM orders
							GROUP BY customerNumber
							HAVING COUNT(orderNumber) > 10)
AND o.customerNumber IN (SELECT distinct customerNumber
							FROM products p
							JOIN orderdetails od
							USING(productCode)
							WHERE priceEach > 
							(SELECT AVG(priceEach) FROM orderdetails))

# Nomor 3

SELECT customerName
FROM customers
JOIN payments
USING(customerNumber)
GROUP BY customerName
HAVING SUM(amount) > (SELECT AVG(totalPayment) * 2
                      FROM (SELECT customerNumber, SUM(amount) AS totalPayment
                            FROM payments
                            GROUP BY customerNumber) AS total)

INTERSECT

SELECT c.customerName
FROM customers c
JOIN orders o 
USING(customerNumber)
JOIN orderdetails od 
USING(orderNumber)
JOIN products p 
USING(productCode)
WHERE p.productLine IN ('Planes', 'Trains')
GROUP BY c.customerName
HAVING SUM(od.quantityOrdered * od.priceEach) > 20000;

# Nomor 4

SELECT 
    o.orderDate AS 'Tanggal',
    c.customerNumber AS 'CustomerNumber',
    'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
UNION
SELECT 
    orderDate, 
    customerNumber,
    'Memesan Barang' 
FROM orders
WHERE MONTH(orderDate) = 09 AND YEAR(orderDate) = 2003
AND orderDate NOT IN (  
	SELECT o.orderDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
UNION
SELECT 
    paymentDate, 
    customerNumber, 
    'Membayar Pesanan' FROM payments
WHERE MONTH(paymentDate) = 09 AND YEAR(paymentDate) = 2003
AND paymentDate NOT IN (  
	SELECT p.paymentDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
ORDER BY Tanggal;

# Nomor 5

SELECT p.productCode
FROM products p
JOIN orderdetails od
USING(productCode)
WHERE od.priceEach > (
    SELECT AVG(od2.priceEach) 
    FROM orderdetails od2
    JOIN orders o2 
    USING(orderNumber)
    WHERE o2.orderDate BETWEEN '2001-01-01' AND '2004-03-31'
) 
AND od.quantityOrdered > 48
AND LEFT(p.productVendor, 1) IN ('a', 'i', 'u', 'e', 'o')
EXCEPT
SELECT p.productCode 
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o 
USING(orderNumber)
JOIN customers c
USING(customerNumber)
WHERE c.country IN ('Japan','Germany','Italy');

