-- Pertemuan 6 --

# Nomor 1
SELECT 
    c.customerName, 
    CONCAT(e.firstName, ' ', e.lastName) AS salesRep, 
    (c.creditLimit - SUM(py.amount)) AS remainingCredit
FROM customers AS c
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN payments AS py
USING(customerNumber)
GROUP BY c.customerName
HAVING remainingCredit >= 0
ORDER BY c.customerName;


# Nomor 2
SELECT 
    p.productName AS "Nama Produk",
    GROUP_CONCAT(DISTINCT c.customerName ORDER BY c.customerName SEPARATOR ', ') AS "Nama Customer",
    COUNT(DISTINCT c.customerNumber) AS "Jumlah Customer",
    SUM(od.quantityOrdered) AS "Total Quantitas"
FROM products AS p 
JOIN orderdetails AS od
USING(productCode)
JOIN orders AS o 
USING(orderNumber)
JOIN customers AS c 
USING(customerNumber)
GROUP BY p.productName
ORDER BY p.productName;

# Nomor 3
SELECT CONCAT(e.firstName, ' ', e.lastName) AS employeeName,
		COUNT(DISTINCT c.customerNumber) AS totalCustomers
FROM employees AS e
JOIN customers AS c
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY e.employeeNumber
ORDER BY totalCustomers DESC;

# Nomor 4
SELECT 
    CONCAT(e.firstName, ' ', e.lastName) AS "Nama Karyawan",
    p.productName AS "Nama Produk",
    SUM(od.quantityOrdered) AS 'Jumlah Pesanan'
FROM products AS p
JOIN orderdetails AS od
USING(productCode)
JOIN orders AS o
USING(orderNumber)
JOIN customers AS c
USING(customerNumber)
RIGHT JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices AS oc
USING(officeCode)
WHERE oc.country = 'Australia'
GROUP BY e.employeeNumber, p.productName
ORDER BY `Jumlah Pesanan` DESC;

SELECT employees.firstName, offices.country
FROM employees 
JOIN offices
USING(officeCode)
WHERE offices.country = 'Australia'

# Nomor 5
SELECT 
    DISTINCT c.customerName AS "Nama Pelanggan", 
    GROUP_CONCAT(DISTINCT p.productName ORDER BY p.productName SEPARATOR ', ') AS "Nama Produk", 
    COUNT(DISTINCT p.productName) AS "Banyak Jenis Produk"
FROM customers AS c
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od
USING(orderNumber)
JOIN products AS p
USING(productCode)
WHERE o.shippedDate IS NULL
GROUP BY c.customerNumber 
ORDER BY c.customerName ;

SELECT * FROM orders;