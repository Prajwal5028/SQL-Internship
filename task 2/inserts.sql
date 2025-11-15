-- Task 2: Data Insertion and Null Handling for LibraryDB
USE LibraryDB;

-- 1) Insert Authors (partial columns, NULL handling)
INSERT INTO Author (Name) VALUES
('J.K. Rowling'),
('George Orwell'),
('Agatha Christie');

-- 2) Insert Books (explicit columns, some NULLs allowed for Genre)
INSERT INTO Book (Title, Genre, AuthorID) VALUES
('Harry Potter and the Philosopher''s Stone', 'Fantasy', 1),
('1984', 'Dystopian', 2),
('Murder on the Orient Express', NULL, 3); -- Genre unknown -> NULL

-- 3) Insert Members (demonstrating uniqueness on Email)
INSERT INTO Member (Name, Email) VALUES
('Prajwal Kumbar', 'prajwal@example.com'),
('Anita Sharma', 'anita.sharma@example.com'),
('Guest User', NULL); -- if Email were NOT NULL this would fail

-- 4) Insert Loans (showing partial column insert and future return date NULL meaning not returned yet)
INSERT INTO Loan (BookID, MemberID, IssueDate, ReturnDate) VALUES
(1, 1, '2025-11-01', '2025-11-10'),
(2, 2, '2025-11-05', NULL),  -- not returned yet
(3, 1, '2025-11-07', NULL);

-- 5) Update statements
-- Update a book to add its missing Genre
UPDATE Book
SET Genre = 'Mystery'
WHERE BookID = 3;

-- Update multiple rows: extend return date for member 1's active loans
UPDATE Loan
SET ReturnDate = DATE_ADD(ReturnDate, INTERVAL 7 DAY)
WHERE MemberID = 1 AND ReturnDate IS NOT NULL;

-- 6) Delete statements
-- Delete a member who has no active loans (example)
DELETE FROM Member
WHERE MemberID = 3 AND NOT EXISTS (
    SELECT 1 FROM Loan WHERE Loan.MemberID = Member.MemberID AND ReturnDate IS NULL
);

-- 7) Transaction + Rollback example (how to rollback a deletion)
START TRANSACTION;
DELETE FROM Book WHERE BookID = 2; -- suppose we delete 1984 by mistake
-- ROLLBACK; -- uncomment to revert the delete
COMMIT;

-- 8) Insert into specific columns only
INSERT INTO Book (Title, AuthorID) VALUES ('New Release: SQL for Everyone', 1);

-- 9) Insert using SELECT (copy books of an author into another table example)
-- Create a temporary table to demonstrate INSERT...SELECT
CREATE TEMPORARY TABLE IF NOT EXISTS BookBackup AS
SELECT * FROM Book WHERE 1=0;

INSERT INTO BookBackup (BookID, Title, Genre, AuthorID)
SELECT BookID, Title, Genre, AuthorID FROM Book WHERE AuthorID = 1;

-- 10) Demonstration of ON DELETE CASCADE (concept)
-- ALTER TABLE Loan
-- DROP FOREIGN KEY IF EXISTS fk_loan_book;
-- ALTER TABLE Loan
-- ADD CONSTRAINT fk_loan_book FOREIGN KEY (BookID) REFERENCES Book(BookID) ON DELETE CASCADE;

-- 11) Dealing with NULL vs 0 examples
-- Find members with NULL email
SELECT * FROM Member WHERE Email IS NULL;

-- Update NULL Email to a default value
UPDATE Member SET Email = 'not-provided@example.com' WHERE Email IS NULL;

-- 12) Cleanup (optional for demo)
DROP TEMPORARY TABLE IF EXISTS BookBackup;
