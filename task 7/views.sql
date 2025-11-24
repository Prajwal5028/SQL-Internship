-- Task 7: Creating Views in LibraryDB
USE LibraryDB;

---------------------------------------------------
-- 1) Basic View: View of all borrowed books
---------------------------------------------------
CREATE VIEW BorrowedBooks AS
SELECT l.LoanID, b.Title, m.Name AS Borrower, l.IssueDate, l.ReturnDate
FROM Loan l
JOIN Book b ON l.BookID = b.BookID
JOIN Member m ON l.MemberID = m.MemberID;

-- Usage:
SELECT * FROM BorrowedBooks;

---------------------------------------------------
-- 2) View with filtering: Active loans (not returned)
---------------------------------------------------
CREATE VIEW ActiveLoans AS
SELECT l.LoanID, b.Title, m.Name, l.IssueDate
FROM Loan l
JOIN Book b ON l.BookID = b.BookID
JOIN Member m ON l.MemberID = m.MemberID
WHERE l.ReturnDate IS NULL;

SELECT * FROM ActiveLoans;

---------------------------------------------------
-- 3) View with aggregated data: Total loans per book
---------------------------------------------------
CREATE VIEW BookLoanStats AS
SELECT b.BookID, b.Title, COUNT(l.LoanID) AS total_loans
FROM Book b
LEFT JOIN Loan l ON b.BookID = l.BookID
GROUP BY b.BookID, b.Title;

SELECT * FROM BookLoanStats;

---------------------------------------------------
-- 4) Updatable view example (simple, no joins)
---------------------------------------------------
CREATE VIEW MemberBasicInfo AS
SELECT MemberID, Name, Email
FROM Member;

-- Test update (allowed only if DB supports updatable views)
-- UPDATE MemberBasicInfo SET Name = 'Updated Name' WHERE MemberID = 1;

---------------------------------------------------
-- 5) View with WITH CHECK OPTION (prevents invalid updates)
---------------------------------------------------
CREATE VIEW ValidEmails AS
SELECT MemberID, Name, Email
FROM Member
WHERE Email IS NOT NULL
WITH CHECK OPTION;

-- UPDATE ValidEmails SET Email = NULL WHERE MemberID = 2;
-- (Above will fail because CHECK OPTION prevents breaking view condition)

---------------------------------------------------
-- 6) Dropping a view
---------------------------------------------------
-- DROP VIEW IF EXISTS BorrowedBooks;

---------------------------------------------------
-- 7) Using a view in another view (nested views)
---------------------------------------------------
CREATE VIEW TopBorrowedBooks AS
SELECT BookID, Title, total_loans
FROM BookLoanStats
WHERE total_loans = (SELECT MAX(total_loans) FROM BookLoanStats);

SELECT * FROM TopBorrowedBooks;
