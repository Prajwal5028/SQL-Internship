# Task 8 – Stored Procedures & Functions

## Files Included
- `routines.sql` — stored procedures and functions examples.
- This README — interview Q&A and usage notes.

---

## Overview
This task demonstrates how to modularize SQL logic using stored procedures and functions. The `routines.sql` file includes:
- `AddBookWithAuthor` (procedure that inserts author if missing and adds a book)
- `LoanBook` (procedure with OUT parameter returning new LoanID)
- `ReturnBook` (procedure with conditional logic and OUT status)
- `ActiveLoanCount` (scalar function returning active loans count)
- `AvgLoanDaysForBook` (scalar function returning average days borrowed for a book)

---

## How to run (MySQL)
1. Open MySQL Workbench or CLI.
2. Execute `routines.sql` (it uses DELIMITER to allow multi-statement routines).
3. Use `CALL procedure_name(...)` to invoke procedures and `SELECT function_name(...)` for functions.

Examples:
```sql
CALL AddBookWithAuthor('SQL Mastery', 'Education', 'Prajwal Kumbar');
CALL LoanBook(1, 1, @newLoanId); SELECT @newLoanId;
CALL ReturnBook(2, @status); SELECT @status;
SELECT ActiveLoanCount(1);
SELECT AvgLoanDaysForBook(1);

Interview Questions & Answers
1. Difference between procedure and function?

Procedure: executes a task, may return zero or more OUT parameters, invoked with CALL.

Function: returns a single value and can be used in SQL expressions (e.g., SELECT f(...)). Functions must return a value.

2. What is IN/OUT parameter?

IN: input-only parameter.

OUT: output-only parameter set by the routine.

INOUT: acts as input and can be modified to return a value.

3. Can functions return tables?

Not in standard MySQL — functions return scalar values. Some DBMS (SQL Server, PostgreSQL) support table-valued functions.

4. What is RETURN used for?

In a function, RETURN returns the computed value to the caller. Procedures use OUT parameters instead of RETURN.

5. How to call stored procedures?

Use CALL proc_name(arg1, arg2, @outVar) and then SELECT @outVar to read OUT parameters.

6. What is the benefit of stored routines?

Encapsulate business logic in the database

Reusability and modularity

Reduce client-server network overhead

Centralized security and logic updates

7. Can procedures have loops?

Yes — procedures can include procedural constructs like LOOP, WHILE, REPEAT, and FOR (DBMS-dependent).

8. Difference between scalar and table-valued functions?

Scalar function: returns a single value (number, string).

Table-valued function: returns a result set (a table). Support depends on DBMS.

9. What is a trigger?

A trigger is a routine that automatically runs in response to certain events (INSERT, UPDATE, DELETE) on a table.

10. How to debug stored procedures?

Add logging (INSERT into debug table) inside the routine.

Use step-through debuggers where supported (some GUIs/DBMS provide this).

Test incrementally and use SELECT statements and exceptions to inspect variable values.