# Task 2 – Data Insertion, Updates, Deletes & NULL Handling

## 📂 Files Included
- `inserts.sql` — SQL operations for Task 2  
- `README.md` — Documentation (this file)

---

# 📘 Overview

In this task, you work with the **Library Management System** created in Task 1 and perform:

✔ Data insertion (full + partial)  
✔ Handling NULL values  
✔ Updating records  
✔ Deleting records safely  
✔ Using transactions (COMMIT / ROLLBACK)  
✔ Temporary tables  
✔ INSERT…SELECT queries  

This improves your understanding of CRUD operations and database consistency.

---

# 🔧 Key SQL Concepts Used

## 1️⃣ INSERT Operations  
Examples include:
- Full inserts  
- Partial inserts (specific columns)  
- Inserts with NULL values  
- INSERT…SELECT  

Example:
```sql
INSERT INTO Book (Title, Genre, AuthorID) VALUES ('1984', 'Dystopian', 2);
```

## 2️⃣ NULL Handling
- `NULL` indicates missing/unknown information.
- `IS NULL` and `IS NOT NULL` are used for comparisons.

Example:
```sql
SELECT * FROM Member WHERE Email IS NULL;
```

## 3️⃣ UPDATE Operations
Example:
```sql
UPDATE Book SET Genre = 'Mystery' WHERE BookID = 3;
```

## 4️⃣ DELETE Operations
Example (delete only if member has no active loans):
```sql
DELETE FROM Member
WHERE MemberID = 3 AND NOT EXISTS (
    SELECT 1 FROM Loan WHERE MemberID = 3 AND ReturnDate IS NULL
);
```

## 5️⃣ Transactions (COMMIT & ROLLBACK)
Used to avoid accidental data loss.

Example:
```sql
START TRANSACTION;
DELETE FROM Book WHERE BookID = 2;
ROLLBACK;
```

## 6️⃣ Temporary Tables
Example:
```sql
CREATE TEMPORARY TABLE BookBackup AS SELECT * FROM Book WHERE 1=0;
```

---

# 🧠 Interview Questions & Answers

### **1. What is the difference between NULL and 0?**  
- **NULL** means *missing / unknown* value  
- **0** is a *valid number*  
They are not the same.

---

### **2. What is a DEFAULT constraint?**  
It assigns a predefined value to a column if no value is provided during INSERT.

Example:
```sql
Email VARCHAR(100) DEFAULT 'not-provided@example.com'
```

---

### **3. Why can't we use `=` to compare NULL?**  
Because NULL is *not a value*.  
Use:
```sql
IS NULL  
IS NOT NULL
```

---

### **4. How can you update multiple rows at once?**  
By using a WHERE clause that matches multiple records.

Example:
```sql
UPDATE Loan 
SET ReturnDate = DATE_ADD(ReturnDate, INTERVAL 7 DAY)
WHERE MemberID = 1;
```

---

### **5. Can we insert values into only selected columns?**  
Yes.

Example:
```sql
INSERT INTO Book (Title, AuthorID) VALUES ('SQL Basics', 1);
```

---

### **6. What happens if we insert NULL into a NOT NULL column?**  
The query will **fail** with an error.

---

### **7. How do you rollback a wrong UPDATE or DELETE?**  
Using transactions:
```sql
START TRANSACTION;
DELETE FROM Book WHERE BookID = 10;
ROLLBACK;
```

---

### **8. What is INSERT…SELECT?**  
It inserts data from one table into another.

Example:
```sql
INSERT INTO BookBackup (BookID, Title)
SELECT BookID, Title FROM Book WHERE AuthorID = 1;
```

---

### **9. What is ON DELETE CASCADE?**  
A foreign key feature that automatically deletes child rows when the parent is deleted.

---

### **10. Why are temporary tables used?**  
For backup, testing, or intermediate processing without affecting real data.

---

# 📌 End of Task 2


