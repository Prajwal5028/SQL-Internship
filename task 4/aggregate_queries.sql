-- Task 4: Aggregate Functions and Grouping for LibraryDB
USE LibraryDB;

-- 1) Count total number of books
SELECT COUNT(*) AS total_books FROM Book;

-- 2) Count loans per book
SELECT b.BookID, b.Title, COUNT(l.LoanID) AS loan_count
FROM Book b
LEFT JOIN Loan l ON b.BookID = l.BookID
GROUP BY b.BookID, b.Title
ORDER BY loan_count DESC;

-- 3) Count loans per member
SELECT m.MemberID, m.Name, COUNT(l.LoanID) AS loans_by_member
FROM Member m
LEFT JOIN Loan l ON m.MemberID = l.MemberID
GROUP BY m.MemberID, m.Name
ORDER BY loans_by_member DESC;

-- 4) Average loan duration (in days) for returned books
SELECT ROUND(AVG(DATEDIFF(ReturnDate, IssueDate)),2) AS avg_loan_days
FROM Loan
WHERE ReturnDate IS NOT NULL;

-- 5) Sum of loan days per member (for returned loans)
SELECT m.MemberID, m.Name, SUM(DATEDIFF(ReturnDate, IssueDate)) AS total_days_borrowed
FROM Member m
JOIN Loan l ON m.MemberID = l.MemberID
WHERE l.ReturnDate IS NOT NULL
GROUP BY m.MemberID, m.Name
ORDER BY total_days_borrowed DESC;

-- 6) Books with more than 1 loan (HAVING example)
SELECT b.BookID, b.Title, COUNT(l.LoanID) AS loan_count
FROM Book b
LEFT JOIN Loan l ON b.BookID = l.BookID
GROUP BY b.BookID, b.Title
HAVING COUNT(l.LoanID) > 1;

-- 7) Average loans per author
SELECT a.AuthorID, a.Name, ROUND(AVG(book_loans.loan_count),2) AS avg_loans_per_book
FROM Author a
JOIN (
    SELECT b.AuthorID, b.BookID, COUNT(l.LoanID) AS loan_count
    FROM Book b
    LEFT JOIN Loan l ON b.BookID = l.BookID
    GROUP BY b.BookID, b.AuthorID
) AS book_loans ON a.AuthorID = book_loans.AuthorID
GROUP BY a.AuthorID, a.Name
ORDER BY avg_loans_per_book DESC;

-- 8) Highest number of loans by a single member (using LIMIT)
SELECT m.MemberID, m.Name, COUNT(l.LoanID) AS loans_count
FROM Member m
LEFT JOIN Loan l ON m.MemberID = l.MemberID
GROUP BY m.MemberID, m.Name
ORDER BY loans_count DESC
LIMIT 1;

-- 9) Using MAX to find the book with maximum loans (subquery)
SELECT BookID, Title, loan_count FROM (
  SELECT b.BookID, b.Title, COUNT(l.LoanID) AS loan_count
  FROM Book b
  LEFT JOIN Loan l ON b.BookID = l.BookID
  GROUP BY b.BookID, b.Title
) AS t
WHERE loan_count = (SELECT MAX(sub.loan_count) FROM (
    SELECT COUNT(l2.LoanID) AS loan_count
    FROM Book b2
    LEFT JOIN Loan l2 ON b2.BookID = l2.BookID
    GROUP BY b2.BookID
) AS sub);

-- 10) Group by multiple columns example: loans per book per member (how many times a member borrowed a specific book)
SELECT l.BookID, b.Title, l.MemberID, m.Name, COUNT(*) AS times_borrowed
FROM Loan l
JOIN Book b ON l.BookID = b.BookID
JOIN Member m ON l.MemberID = m.MemberID
GROUP BY l.BookID, b.Title, l.MemberID, m.Name
ORDER BY times_borrowed DESC;
