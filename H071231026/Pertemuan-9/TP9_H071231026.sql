-- Peretemuan 9 --

# Nomor 1

START TRANSACTION
ROLLBACK

CREATE DATABASE manajemen_tim_sepakbola;

CREATE TABLE IF NOT EXISTS klub (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS pemain (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN KEY(id_klub) REFERENCES klub(id)
);

CREATE TABLE IF NOT EXISTS pertandingan (
	id INT AUTO_INCREMENT PRIMARY KEY,
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0,
	id_klub_tuan_rumah INT,
	id_klub_tamu INT,
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES klub(id),
	FOREIGN KEY(id_klub_tamu) REFERENCES klub(id)
);

CREATE INDEX index_posisi ON pemain (posisi);
CREATE INDEX index_kota_asal ON klub (kota_asal);

# Nomor 2

SELECT 
		customerName,
		country,
		SUM(amount) AS TotalPayment,
		COUNT(orderNumber) AS orderCount,
		MAX(paymentDate) AS LastPaymentDate,
		case
			when SUM(amount) > 100000 then 'VIP'
			when SUM(amount) BETWEEN 5000 AND 100000 then 'Loyal'
			ELSE 'New'
		END AS status
FROM customers
LEFT JOIN orders
USING(customerNumber)
LEFT JOIN payments
USING(customerNumber)
GROUP BY customerName, country
ORDER BY customerName

# Nomor 3

SELECT 
		customerNumber,
		customerName,
		SUM(quantityOrdered) AS total_quantity,
		case
			when SUM(quantityOrdered) > (SELECT AVG(total_quantity)
													FROM
													(SELECT customerNumber, SUM(quantityOrdered) AS total_quantity
													FROM customers
													JOIN orders USING(customerNumber)
													JOIN orderdetails USING(orderNumber)
													GROUP BY customerNumber) AS t) then 'di atas rata-rata'
			ELSE 'di bawah rata-rata'
		END AS kategori_pembelian
FROM customers
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
GROUP BY customerNumber, customerName
ORDER BY total_quantity DESC;	
				
																									
			

(SELECT AVG(total_quantity) 
FROM 

(SELECT customerNumber, SUM(quantityOrdered) AS total_quantity
FROM customers
JOIN orders USING(customerNumber)
JOIN orderdetails USING(orderNumber)
GROUP BY customerNumber) AS t)

# Soal Tambahan

START TRANSACTION

INSERT INTO klub (nama_klub, kota_asal) 
VALUES('Persija', 'Jakarta'),
		('Arema FC', 'Malang'),
		('Persebaya', 'Surabaya'),
		('PSM Makassar', 'Makassar'),
		('Bali United', 'Bali');

INSERT INTO pemain (nama_pemain, posisi, id_klub)
VALUES('Evan Dimas', 'Midfielder', 1),
		('Riko Simanjuntak', 'Forward', 1),
		('Hanif Sjahbandi', 'Defender', 2),
		('Makan Konate', 'Midfielder', 2),
		('David da Silva', 'Forward', 3),
		('Irfan Jaya', 'Forward', 4),
		('Rizky Pellu', 'Midfielder', 4),
		('Ilija Spasojevic', 'Forward', 5),
		('Andhika Wijaya', 'Defender', 5);

INSERT INTO pertandingan (tanggal_pertandingan, id_klub_tuan_rumah, skor_tuan_rumah, skor_tamu,  id_klub_tamu)
VALUES(2024-09-10, 1, 2, 1, 2),
		(2024-09-12, 3, 1, 1, 4),
		(2024-09-15, 5, 0, 3, 1),
		(2024-09-20, 2, 1, 2, 5),
		(2024-09-25, 4, 2, 0, 3);

ROLLBACK;

COMMIT;		