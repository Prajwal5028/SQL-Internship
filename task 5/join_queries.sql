-- Task 5: SQL Joins (Inner, Left, Right, Full, Cross, Natural, Self-Join)
USE LibraryDB;

-- INNER JOIN: rows matching in both tables
SELECT o.LoanID, b.BookID, b.Title, m.MemberID, m.Name, o.IssueDate
FROM Loan o
INNER JOIN Book b ON o.BookID = b.BookID
INNER JOIN Member m ON o.MemberID = m.MemberID;

-- LEFT JOIN: all rows from left (Book), matching loans if any
SELECT b.BookID, b.Title, COUNT(l.LoanID) AS loan_count
FROM Book b
LEFT JOIN Loan l ON b.BookID = l.BookID
GROUP BY b.BookID, b.Title;

-- RIGHT JOIN: all rows from right (Member), matching loans if any
SELECT m.MemberID, m.Name, l.LoanID, l.IssueDate
FROM Loan l
RIGHT JOIN Member m ON l.MemberID = m.MemberID;

-- FULL OUTER JOIN using LEFT + RIGHT + UNION (for MySQL)
SELECT b.BookID, b.Title, l.LoanID
FROM Book b
LEFT JOIN Loan l ON b.BookID = l.BookID
UNION
SELECT b.BookID, b.Title, l.LoanID
FROM Book b
RIGHT JOIN Loan l ON b.BookID = l.BookID;

-- CROSS JOIN: Cartesian product (use carefully)
SELECT b.Title, m.Name
FROM Book b
CROSS JOIN Member m
LIMIT 10;

-- SELF JOIN: members who borrowed same book as member 1
SELECT a.MemberID AS MemberA, b.MemberID AS MemberB, a.BookID
FROM Loan a
JOIN Loan b ON a.BookID = b.BookID AND a.MemberID <> b.MemberID
WHERE a.MemberID = 1;

-- NATURAL JOIN (example; only works if column names match)
-- SELECT * FROM Book NATURAL JOIN Author;

-- Join more than two tables
SELECT l.LoanID, b.Title, a.Name AS AuthorName, m.Name AS MemberName, l.IssueDate, l.ReturnDate
FROM Loan l
JOIN Book b ON l.BookID = b.BookID
JOIN Author a ON b.AuthorID = a.AuthorID
JOIN Member m ON l.MemberID = m.MemberID;

-- Nested join example
SELECT x.BookID, x.Title, x.loan_count, m.Name
FROM (
    SELECT b.BookID, b.Title, COUNT(l.LoanID) AS loan_count
    FROM Book b
    LEFT JOIN Loan l ON b.BookID = l.BookID
    GROUP BY b.BookID, b.Title
) AS x
LEFT JOIN Loan latest ON x.BookID = latest.BookID
LEFT JOIN Member m ON latest.MemberID = m.MemberID;

-- Join without foreign key (still works if column values match)
SELECT b.BookID, b.Title, l.LoanID
FROM Book b
JOIN Loan l ON b.BookID = l.BookID;
