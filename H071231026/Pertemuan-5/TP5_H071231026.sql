-- Tugas Praktikum 5 --

# Nomor 1
SELECT DISTINCT 
		c.customerName AS namaKustomer, 
		p.productName AS namaProduk, 
		pl.textDescription
FROM customers AS c
JOIN orders o 
USING(customerNumber)
JOIN orderdetails od 
USING(orderNumber)
JOIN products p 
USING(productCode)
JOIN productlines pl 
USING(productLine)
WHERE p.productName LIKE '%Titanic%'
ORDER BY c.customerName ASC;

# Nomor 2
SELECT c.customerName, 
		p.productName, 
		o.STATUS, 
		o.shippedDate
FROM customers AS c
JOIN orders AS o
USING(customerNumber)
JOIN orderdetails AS od
USING(orderNumber)
JOIN products AS p
USING(productCode)
WHERE productName LIKE '%Ferrari%'
		AND STATUS = 'Shipped'
		AND (shippedDate BETWEEN '2003-09-31' AND '2004-10-01')
ORDER BY shippedDate DESC;

# Nomor 3
SELECT * FROM employees
WHERE firstName = 'Gerard' OR lastName = 'Gerard'


SELECT s.firstName AS Supervisor, 
		k.firstName AS Karyawan
FROM employees AS k
JOIN employees AS s
ON k.reportsTo = s.employeeNumber
WHERE s.firstName = 'Gerard'
ORDER BY k.firstName ASC;

-- WHERE k.reportsTo = 1102
-- ORDER BY k.firstName ASC;

# Nomor 4
## a
SELECT c.customerName, 
		py.paymentDate, 
		e.firstName as employeeName, 
		py.amount
FROM customers AS c
JOIN payments AS py
USING(customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE '%-11-%' 
order by amount DESC;

## b
SELECT c.customerName, 
		py.paymentDate, 
		e.firstName as employeeName, 
		py.amount
FROM customers AS c
JOIN payments AS py
USING(customerNumber)
JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE py.paymentDate LIKE '%-11-%' 
ORDER BY py.amount DESC
LIMIT 1;

## c
SELECT c.customerName, pd.productName
FROM payments AS p
JOIN customers AS c
USING (customernumber)
JOIN orders AS o
USING (customernumber)
JOIN orderdetails AS od
USING (ordernumber)
JOIN products AS pd
USING (productcode)
WHERE c.customerName = 'Corporate Gift Ideas Co.' 
		AND p.paymentDate LIKE '%-11-%'