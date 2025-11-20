# Task 5 – SQL Joins (Inner, Left, Right, Full, Cross, Natural, Self-Join)

## Files Included
- `join_queries.sql` — contains SQL queries demonstrating all major join types.
- `README.md` — this file.

## Overview
This task demonstrates how to combine data from multiple tables using JOINs.  
Examples cover INNER, LEFT, RIGHT, FULL (via UNION), CROSS JOIN, NATURAL JOIN (concept), SELF JOIN, and multi-table joins.

---

# Example Join Types

### ✔ INNER JOIN  
Returns rows that match in both tables.

### ✔ LEFT JOIN  
Returns all rows from the left table and matching rows from the right table.

### ✔ RIGHT JOIN  
Returns all rows from the right table and matching rows from the left table.

### ✔ FULL OUTER JOIN  
Returns all rows from both tables; non-matching rows are filled with NULLs.  
(MySQL requires LEFT JOIN + RIGHT JOIN + UNION.)

### ✔ CROSS JOIN  
Returns every combination of rows (Cartesian product).

### ✔ SELF JOIN  
A table joins with itself using aliases.

### ✔ NATURAL JOIN  
Automatically joins by matching column names.  
(Not recommended in production because it may produce unexpected joins.)

### ✔ Multi-table JOIN  
Joining 3 or more tables using chained JOIN statements.

---

# Interview Questions & Answers

### 1. Difference between INNER and LEFT JOIN?  
- **INNER JOIN** → only matching rows from both tables  
- **LEFT JOIN** → all left rows + matching right rows (non-matching become NULL)

### 2. What is a FULL OUTER JOIN?  
Returns all rows from both tables whether they match or not.

### 3. Can joins be nested?  
Yes — you can use a JOIN inside another JOIN or combine JOINs with subqueries.

### 4. How to join more than 2 tables?  
Use multiple JOIN clauses:
```sql
A JOIN B ON ...
JOIN C ON ...

5. What is a cross join?

Produces every possible combination of rows — Cartesian product.

6. What is a natural join?

JOINs automatically based on columns with the same names.
Risky because you don’t explicitly control joined columns.

7. Can tables be joined without foreign keys?

Yes — JOINs work as long as matching column values exist.

8. What is a self join?

Table joins itself to compare rows within the same table.

9. What causes a Cartesian product accidentally?

SELECT * FROM A, B;

10. How to optimize joins?

Index join columns

Avoid SELECT *

Filter early with WHERE

Use EXPLAIN to analyze performance