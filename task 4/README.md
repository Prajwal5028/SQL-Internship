# Task 4 – Aggregate Functions & Grouping

## Files Included
- `aggregate_queries.sql` — SQL queries demonstrating COUNT, SUM, AVG, GROUP BY, HAVING, MAX, ROUND, and use of joins with aggregation.
- `README.md` — this file.

## Overview
This task practices summarizing and analyzing tabular data using aggregate functions and grouping. It includes examples such as counting rows, averaging durations, summing borrowed days, filtering groups using HAVING, and finding maximums.

---

# Example Queries (see `aggregate_queries.sql`)
- `SELECT COUNT(*) AS total_books FROM Book;`
- `SELECT b.BookID, b.Title, COUNT(l.LoanID) AS loan_count ... GROUP BY b.BookID, b.Title;`
- `SELECT ROUND(AVG(DATEDIFF(ReturnDate, IssueDate)),2) AS avg_loan_days FROM Loan WHERE ReturnDate IS NOT NULL;`
- `SELECT ... HAVING COUNT(l.LoanID) > 1;`
- `SELECT a.AuthorID, a.Name, ROUND(AVG(book_loans.loan_count),2) AS avg_loans_per_book ... GROUP BY a.AuthorID, a.Name;`

---

# Interview Questions & Answers

### 1. What is GROUP BY?  
`GROUP BY` groups rows that have the same values for specified columns so aggregate functions can be applied to each group.

### 2. Difference between WHERE and HAVING?  
`WHERE` filters rows **before** grouping; `HAVING` filters groups **after** aggregation.

### 3. How does COUNT(*) differ from COUNT(column)?  
`COUNT(*)` counts all rows in the group including NULLs; `COUNT(column)` counts only rows where that column is not NULL.

### 4. Can you group by multiple columns?  
Yes — list multiple columns in `GROUP BY` to form composite groups, e.g., `GROUP BY author_id, genre`.

### 5. What is ROUND() used for?  
`ROUND()` rounds numeric results to a specified number of decimal places (e.g., `ROUND(AVG(...),2)`).

### 6. How do you find the highest salary by department?  
Use `GROUP BY department` with `MAX(salary)`, e.g.:  
```sql
SELECT department, MAX(salary) AS highest_salary
FROM employees
GROUP BY department;

### 7. What is the default behavior of GROUP BY?

It groups rows strictly by exact matching values of the specified columns; non-aggregated columns in the SELECT must be in the GROUP BY (or depend on DBMS extensions).

### 8. Explain AVG and SUM.

AVG(column) returns the average of numeric values; SUM(column) returns the total sum of numeric values for a group.

### 9. How to count distinct values?

Use COUNT(DISTINCT column), e.g., COUNT(DISTINCT MemberID).

### 10. What is an aggregate function?

An aggregate function computes a single result from multiple input rows (examples: COUNT, SUM, AVG, MIN, MAX).