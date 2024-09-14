USE LIBRARY;

ALTER TABLE books
ADD published_year YEAR NOT NULL;

ALTER TABLE  books
ADD genre VARCHAR(50) NOT NULL;

ALTER TABLE books
ADD copies_available INT NOT NULL;

CREATE TABLE members(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE,
phone_number CHAR(10),
join_date DATE NOT NULL,
membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings(
id INT PRIMARY KEY AUTO_INCREMENT,
member_id INT NOT NULL,
book_id INT NOT NULL,
borrow_date DATE NOT NULL,
return_date DATE,
FOREIGN KEY(book_id) REFERENCES books(id),
FOREIGN KEY(member_id) REFERENCES members(id)
);