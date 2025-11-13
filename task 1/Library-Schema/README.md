# SQL Internship – Task 1
## Database Setup & Schema Design – Library Management System

### Files Included
- `schema.sql` → SQL code to create database + tables
- `ER-diagram.png` → ER diagram of the database
- `README.md` → This explanation + interview Q&A

### Description
This task involves designing a database schema for a Library Management System including entities:
- **Author**
- **Book**
- **Member**
- **Loan**

### ER Diagram
- One Author can write many Books (1-to-Many).
- One Book can have many Loan records over time (1-to-Many).
- One Member can borrow many Books (1-to-Many).

### SQL Script Summary
- Uses `AUTO_INCREMENT` surrogate primary keys.
- Enforces relationships via `FOREIGN KEY` constraints.
- InnoDB engine is specified for transactional support and FK enforcement.

### Interview Questions (short answers)
1. **What is normalization?**  
   Organizing data to reduce redundancy and improve integrity (1NF, 2NF, 3NF...).

2. **Primary vs Foreign Key**  
   Primary Key uniquely identifies a record; Foreign Key links to a primary key in another table.

3. **What are constraints?**  
   Rules on table columns — e.g., NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK.

4. **What is a surrogate key?**  
   System-generated key (like AUTO_INCREMENT) used when no suitable natural key exists.

5. **How to avoid data redundancy?**  
   Normalize tables, split into related entities, use foreign keys.

6. **What is an ER diagram?**  
   A visual model of entities and their relationships in a database.

7. **Types of relationships**  
   One-to-One, One-to-Many, Many-to-Many (use join table for M:N).

8. **Purpose of AUTO_INCREMENT**  
   Automatically generates unique numeric IDs for primary keys.

9. **Default MySQL storage engine**  
   InnoDB (in modern MySQL versions).

10. **What is a composite key?**  
    A primary key composed of multiple columns.

### How to run the SQL
1. Open MySQL Workbench / phpMyAdmin / CLI.
2. Run the `schema.sql` script to create `LibraryDB` and tables.

### GitHub Submission Steps
1. Create a new repository (e.g., `SQL-Internship-Task-1`).
2. Upload `schema.sql`, `ER-diagram.png`, and this `README.md`.
3. Commit and copy the repo URL.
4. Paste the repo URL into the submission Google Form.

---
