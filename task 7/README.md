# Task 7 – Creating and Using Views

## Files Included
- `views.sql` — all view creation & usage examples.
- This README — explanations + interview Q&A.

---

# Overview
This task demonstrates how to use **views** to simplify SQL logic, enhance data security, and create reusable query structures.  
Views provide a virtual table created from a SELECT query.

Based on Task PDF (Day-7) :contentReference[oaicite:1]{index=1}

---

# Views Created in This Task
### ✔ BorrowedBooks  
Shows all active & past borrow records.

### ✔ ActiveLoans  
Lists only current loans (ReturnDate is NULL).

### ✔ BookLoanStats  
Aggregated data → total loans per book.

### ✔ MemberBasicInfo  
Simple, updatable view (no joins).

### ✔ ValidEmails (WITH CHECK OPTION)  
Ensures Email can never become NULL.

### ✔ TopBorrowedBooks  
Nested view built on another view.

---

# Interview Questions & Answers

### 1. What is a view?  
A view is a **virtual table** created from a SELECT query. It does not store physical data.

### 2. Can we update data through a view?  
Yes — **if the view is simple** (no joins, no aggregate functions).  
Complex views are generally **not updatable**.

### 3. What is a materialized view?  
A materialized view **stores actual data** and must be refreshed manually or automatically.  
(Not supported in MySQL, but available in Oracle/PostgreSQL.)

### 4. Difference between view and table?  
| View | Table |
|------|-------|
| Virtual (stored query) | Physically stored data |
| No storage required | Occupies storage |
| Auto-updated when base table changes | Does not auto-update unless refreshed |

### 5. How to drop a view?  
```sql
DROP VIEW view_name;

6. Why use views?

Data security

Simplify complex queries

Provide abstraction

Restrict column-level access

Reusable logic

7. Can we create indexed views?

Not in MySQL.
SQL Server supports indexed views (materialized).

8. How to secure data using views?

Create views that expose only selected columns (e.g., hide salary, password, email).

9. What are limitations of views?

Some views are not updatable

No indexes (in MySQL)

Cannot include ORDER BY unless wrapped

Can become slow if underlying query is expensive

10. How does WITH CHECK OPTION work?

It prevents INSERT/UPDATE that would cause rows to violate the view’s WHERE condition.
example:
    CREATE VIEW ValidEmails AS
SELECT * FROM Member WHERE Email IS NOT NULL WITH CHECK OPTION;
