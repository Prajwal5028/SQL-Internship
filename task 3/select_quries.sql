-- Task 3: Basic SELECT Queries for LibraryDB

USE LibraryDB;

-- 1) Select all rows from Book
SELECT * FROM Book;

-- 2) Select specific columns
SELECT Title, Genre FROM Book;

-- 3) WHERE filtering examples
SELECT * FROM Member WHERE Email IS NOT NULL;

-- 4) AND / OR conditions
SELECT * FROM Loan 
WHERE MemberID = 1 AND ReturnDate IS NULL;

SELECT * FROM Book 
WHERE Genre = 'Fantasy' OR Genre = 'Mystery';

-- 5) LIKE filtering
SELECT * FROM Book WHERE Title LIKE '%Harry%';

-- 6) BETWEEN example
SELECT * FROM Loan 
WHERE IssueDate BETWEEN '2025-11-01' AND '2025-11-10';

-- 7) ORDER BY ascending/descending
SELECT * FROM Book ORDER BY Title ASC;
SELECT * FROM Book ORDER BY Title DESC;

-- 8) LIMIT to show specific number of rows
SELECT * FROM Book LIMIT 2;

-- 9) IN vs =
SELECT * FROM Author WHERE AuthorID IN (1, 3);
