-- Create database
CREATE DATABASE LibraryDB;

-- Use the created database
USE LibraryDB;

-- Create 'Books' table to store book details
CREATE TABLE Books (
    bookID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique identifier for each book
    title VARCHAR(100) NOT NULL,            -- Title of the book
    author VARCHAR(100) NOT NULL,           -- Author of the book
    genre VARCHAR(50),                      -- Genre of the book
    publicationYear INT,                    -- Year the book was published
    isbn VARCHAR(20) UNIQUE                 -- ISBN number of the book
);

-- Create 'Members' table to store member details
CREATE TABLE Members (
    memberID INT PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each member
    firstName VARCHAR(50) NOT NULL,          -- First name of the member
    lastName VARCHAR(50) NOT NULL,           -- Last name of the member
    email VARCHAR(100) NOT NULL,             -- Email of the member
    phone VARCHAR(15)                       -- Phone number of the member
);

-- Create 'Transactions' table to store book issue/return details
CREATE TABLE Transactions (
    transactionID INT PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each transaction
    memberID INT,                                  -- Foreign key reference to Members
    bookID INT,                                    -- Foreign key reference to Books
    issueDate DATE NOT NULL,                       -- Date when the book was issued
    returnDate DATE,                               -- Date when the book is returned
    status VARCHAR(20) NOT NULL,                   -- Current status: 'Issued', 'Returned'
    FOREIGN KEY (memberID) REFERENCES Members(memberID), -- Linking member to transaction
    FOREIGN KEY (bookID) REFERENCES Books(bookID)  -- Linking book to transaction
);

-- Create 'Librarians' table to store librarian details
CREATE TABLE Librarians (
    librarianID INT PRIMARY KEY AUTO_INCREMENT,   -- Unique identifier for each librarian
    firstName VARCHAR(50) NOT NULL,                -- First name of the librarian
    lastName VARCHAR(50) NOT NULL,                 -- Last name of the librarian
    email VARCHAR(100) NOT NULL,                   -- Email of the librarian
    phone VARCHAR(15)                              -- Phone number of the librarian
);

-- Insert sample books
INSERT INTO Books (title, author, genre, publicationYear, isbn)
VALUES
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, '978-0061120084'),
('1984', 'George Orwell', 'Dystopian', 1949, '978-0451524935'),
('Moby Dick', 'Herman Melville', 'Adventure', 1851, '978-1503280786');

-- Insert sample members
INSERT INTO Members (firstName, lastName, email, phone)
VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210');

-- Insert sample transactions
INSERT INTO Transactions (memberID, bookID, issueDate, returnDate, status)
VALUES
(1, 1, '2025-05-01', '2025-05-15', 'Issued'),
(2, 2, '2025-05-03', '2025-05-17', 'Issued');

-- Insert sample librarians
INSERT INTO Librarians (firstName, lastName, email, phone)
VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '555-123-4567'),
('Bob', 'White', 'bob.white@example.com', '555-987-6543');

-- Retrieve all books that are currently issued
SELECT 
    Books.title, 
    Books.author, 
    Members.firstName AS memberFirstName, 
    Members.lastName AS memberLastName, 
    Transactions.issueDate
FROM Transactions
JOIN Books ON Transactions.bookID = Books.bookID
JOIN Members ON Transactions.memberID = Members.memberID
WHERE Transactions.status = 'Issued';
