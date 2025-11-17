# Task 3 – Writing Basic SELECT Queries

## Files Included
- `select_queries.sql` — sample SELECT queries demonstrating filtering, sorting, limits, pattern-matching, and more.
- `README.md` — this file.

## Overview
This task covers extracting data from the Library Management System using SELECT queries and common clauses:

- SELECT (projection)
- WHERE (filtering)
- AND / OR
- LIKE (pattern matching)
- BETWEEN (range)
- ORDER BY (sorting)
- LIMIT (row restriction)
- IN operator
- Aliasing
- DISTINCT

---

# Example Queries (see `select_queries.sql`)
- `SELECT * FROM Book;`
- `SELECT Title, Genre FROM Book;`
- `SELECT * FROM Member WHERE Email IS NOT NULL;`
- `SELECT * FROM Loan WHERE MemberID = 1 AND ReturnDate IS NULL;`
- `SELECT * FROM Book WHERE Title LIKE '%Harry%';`
- `SELECT * FROM Loan WHERE IssueDate BETWEEN '2025-11-01' AND '2025-11-10';`
- `SELECT * FROM Book ORDER BY Title DESC;`
- `SELECT * FROM Book LIMIT 2;`
- `SELECT * FROM Author WHERE AuthorID IN (1, 3);`

---

# Interview Questions & Answers

### 1. What does `SELECT *` do?  
`SELECT *` retrieves **all columns** from the specified table for every row that matches the query.

### 2. How do you filter rows?  
Use the `WHERE` clause with conditions, optionally combined with `AND`, `OR`, and parentheses.  
Example: `SELECT * FROM Loan WHERE MemberID = 1 AND ReturnDate IS NULL;`

### 3. What is `LIKE '%value%'`?  
`LIKE '%value%'` searches for rows where the column contains `value` anywhere. `%` is a wildcard matching zero or more characters. Use `_` to match exactly one character.

### 4. What is `BETWEEN` used for?  
`BETWEEN` filters values within an inclusive range (e.g., dates or numbers).  
Example: `... WHERE IssueDate BETWEEN '2025-11-01' AND '2025-11-10'`.

### 5. How do you limit output rows?  
Use `LIMIT n` to restrict the number of returned rows (syntax varies slightly by RDBMS).  
Example: `SELECT * FROM Book LIMIT 5;`

### 6. Difference between `=` and `IN`  
- `=` compares a column to a **single** value.  
- `IN` checks against **multiple** values (a list).  
Example: `WHERE AuthorID = 1` vs `WHERE AuthorID IN (1,3,5)`.

### 7. How to sort in descending order?  
Use `ORDER BY column DESC`. Default is ascending if `ASC` or nothing is specified.  
Example: `SELECT * FROM Book ORDER BY Title DESC;`

### 8. What is aliasing?  
Aliasing renames a column or table for the duration of a query using `AS` (optional).  
Example: `SELECT Title AS BookTitle FROM Book;`

### 9. Explain `DISTINCT`.  
`DISTINCT` removes duplicate values from the result set for the selected column(s).  
Example: `SELECT DISTINCT Genre FROM Book;`

### 10. What is the default sort order?  
Default sort order is **ascending (ASC)** when `ORDER BY` is used without `ASC`/`DESC`.
