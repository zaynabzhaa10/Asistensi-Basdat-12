-- Tugas Praktikum 7 --

# Nomor 1
SELECT 
		productCode,
		productName,
		buyPrice
FROM products
WHERE buyPrice >
(SELECT AVG(buyPrice) FROM products);

# Nomor 2
SELECT 
		o.orderNumber,
		o.orderDate
FROM orders o
JOIN customers c
USING(customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE e.officeCode =
(SELECT oc.officeCode
FROM offices oc
WHERE oc.city = 'Tokyo');

# Nomor 3
SELECT 
		c.customerName,
		o.orderNumber,
		o.shippedDate,
		o.requiredDate,
		GROUP_CONCAT(p.productName) AS 'products',
		SUM(od.quantityOrdered) AS total_quantity_ordered,
		CONCAT(firstName, ' ', lastName) AS employeeName
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN orders o
USING(orderNumber)
JOIN customers c
USING(customerNumber)
JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE o.orderNumber =
(		
SELECT o.orderNumber
FROM orders o
WHERE o.shippedDate > o.requiredDate
);

# Nomor 4
SELECT 
		p.productName,
		p.productLine,
		SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od
USING(productCode)
JOIN
(
SELECT 
		p.productLine,
		SUM(od.quantityOrdered) AS total_quantity_ordered
FROM products p
JOIN orderdetails od
USING(productCode)
GROUP BY p.productLine
ORDER BY total_quantity_ordered DESC
LIMIT 3
) AS top
USING(productLine)
GROUP BY p.productName, p.productLine
ORDER BY p.productLine, total_quantity_ordered DESC;


SELECT 
      p.productLine,
      SUM(od.quantityOrdered) AS total_quantity_ordered   
FROM products p
JOIN orderdetails od
USING(productCode)
GROUP BY p.productLine
ORDER BY total_quantity_ordered DESC
LIMIT 3

# Soal Tambahan
SELECT 
		CONCAT(lastName, ' ', firstName) AS karyawan,
		SUM(amount) AS pendapatan
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING(customerNumber)
WHERE e.employeeNumber IN

(
(SELECT e.employeeNumber
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING(customerNumber)
GROUP BY e.employeeNumber
ORDER BY SUM(py.amount) ASC
LIMIT 1),

(SELECT e.employeeNumber
FROM employees e
JOIN customers c
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments py
USING(customerNumber)
GROUP BY e.employeeNumber
ORDER BY SUM(py.amount) DESC
LIMIT 1)
)
GROUP BY e.employeeNumber
ORDER BY pendapatan ASC;


