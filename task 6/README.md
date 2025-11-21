# Task 6 – Subqueries and Nested Queries

## Files Included
- `subqueries.sql` — contains scalar subqueries, correlated subqueries, IN, EXISTS, subqueries in FROM (derived tables), and examples with notes.
- The original task PDF is referenced for requirements. :contentReference[oaicite:0]{index=0}

## Overview
This task demonstrates using subqueries (scalar, correlated, and nested) inside SELECT, WHERE, and FROM clauses. It also shows practical patterns (IN, EXISTS) and performance considerations (when to replace correlated subqueries with JOINs).

---

# Example Queries (see `subqueries.sql`)
- Scalar subquery in SELECT to compute loans per member.
- Correlated subquery in WHERE to compare per-member counts against overall averages.
- `IN` with subquery to find books loaned by a specific member.
- `EXISTS` to find authors with at least one loaned book.
- Derived table (subquery in FROM) to compute top N books by loan count.
- Demonstration of rewriting correlated subqueries using JOIN + GROUP BY for performance.

---

# Interview Questions & Answers

### 1. What is a subquery?  
A subquery is an SQL query nested inside another query (SELECT, INSERT, UPDATE, DELETE, or FROM). It returns data used by the outer query.

### 2. Difference between subquery and join?  
A **join** combines rows from multiple tables into a single result set by matching columns. A **subquery** computes a result used by the outer query; sometimes subqueries are simpler to write but less efficient than joins for large datasets.

### 3. What is a correlated subquery?  
A correlated subquery references columns from the outer query and is re-evaluated for each row of the outer query.

### 4. Can subqueries return multiple rows?  
Yes. Subqueries can return multiple rows (used with IN or EXISTS). When a subquery must return a single value (e.g., with `=`), it must be scalar or limited to one row.

### 5. How does EXISTS work?  
`EXISTS` returns TRUE if the subquery returns at least one row. It's often efficient because the DB can stop after finding the first match.

### 6. How is performance affected by subqueries?  
Correlated subqueries can be slow because they run per outer row. Non-correlated subqueries and derived tables may be optimized or cached. Rewriting subqueries as joins often improves performance.

### 7. What is scalar subquery?  
A scalar subquery returns exactly one value (one row, one column) and can be used in SELECT lists or WHERE clauses with `=`.

### 8. Where can we use subqueries?  
In `SELECT`, `WHERE`, `FROM`, `HAVING`, and even `INSERT`/`UPDATE` statements — anywhere an expression or table reference is allowed.

### 9. Can a subquery be in FROM clause?  
Yes — when used in the FROM clause it's called a derived table (or inline view). It behaves like a temporary table for the outer query.

### 10. What is a derived table?  
A derived table is the result set of a subquery in the FROM clause; it can be aliased and used like a table in the outer query.
