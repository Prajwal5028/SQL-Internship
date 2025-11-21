-- Task 6: Subqueries and Nested Queries for LibraryDB
USE LibraryDB;

-- 1) Scalar subquery in SELECT: get number of loans per member as a column
SELECT m.MemberID, m.Name,
  (SELECT COUNT(*) FROM Loan l WHERE l.MemberID = m.MemberID) AS loans_count
FROM Member m;

-- 2) Correlated subquery in WHERE: members who have more than average loans
SELECT m.MemberID, m.Name
FROM Member m
WHERE (SELECT COUNT(*) FROM Loan l WHERE l.MemberID = m.MemberID) >
      (SELECT AVG(member_loans.cnt) FROM (SELECT COUNT(*) AS cnt FROM Loan GROUP BY MemberID) AS member_loans);

-- 3) Subquery with IN: books that have been loaned by member 1
SELECT * FROM Book
WHERE BookID IN (SELECT BookID FROM Loan WHERE MemberID = 1);

-- 4) EXISTS example: authors who have at least one book loaned
SELECT a.AuthorID, a.Name
FROM Author a
WHERE EXISTS (
    SELECT 1 FROM Book b JOIN Loan l ON b.BookID = l.BookID
    WHERE b.AuthorID = a.AuthorID
);

-- 5) Scalar subquery with = : book with maximum loans
SELECT Title FROM Book
WHERE BookID = (
    SELECT BookID FROM (
        SELECT b.BookID, COUNT(l.LoanID) AS loan_count
        FROM Book b
        LEFT JOIN Loan l ON b.BookID = l.BookID
        GROUP BY b.BookID
        ORDER BY loan_count DESC
        LIMIT 1
    ) AS t
);

-- 6) Subquery in FROM clause (derived table): top 3 most-loaned books
SELECT t.BookID, t.Title, t.loan_count
FROM (
    SELECT b.BookID, b.Title, COUNT(l.LoanID) AS loan_count
    FROM Book b
    LEFT JOIN Loan l ON b.BookID = l.BookID
    GROUP BY b.BookID, b.Title
    ORDER BY loan_count DESC
    LIMIT 3
) AS t;

-- 7) Correlated subquery to find members who borrowed the same book multiple times
SELECT DISTINCT m.MemberID, m.Name
FROM Member m
WHERE EXISTS (
    SELECT 1 FROM (
        SELECT BookID, COUNT(*) cnt FROM Loan WHERE MemberID = m.MemberID GROUP BY BookID HAVING COUNT(*) > 1
    ) AS dup
);

-- 8) Use of NOT IN (careful with NULLs): authors without any books loaned
SELECT * FROM Author
WHERE AuthorID NOT IN (
    SELECT DISTINCT b.AuthorID FROM Book b JOIN Loan l ON b.BookID = l.BookID
);

-- 9) Subquery returning multiple rows used with IN for filtering members by recent activity
SELECT * FROM Member
WHERE MemberID IN (
    SELECT MemberID FROM Loan WHERE IssueDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
);

-- 10) Performance note: rewrite correlated subquery as JOIN for better performance (example)
-- Correlated (may be slow):
SELECT m.MemberID, m.Name
FROM Member m
WHERE (SELECT COUNT(*) FROM Loan l WHERE l.MemberID = m.MemberID) > 5;

-- Equivalent using JOIN + GROUP BY (usually faster):
SELECT m.MemberID, m.Name, COUNT(l.LoanID) AS cnt
FROM Member m
JOIN Loan l ON m.MemberID = l.MemberID
GROUP BY m.MemberID, m.Name
HAVING COUNT(l.LoanID) > 5;
