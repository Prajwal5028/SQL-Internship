-- Task 8: Stored Procedures and Functions for LibraryDB
USE LibraryDB;

DELIMITER $$

/*
1) Stored Procedure: Add a new book and optionally create author if not exists
   - IN p_title VARCHAR(150)
   - IN p_genre  VARCHAR(50)
   - IN p_author_name VARCHAR(100)
*/
CREATE PROCEDURE AddBookWithAuthor(
  IN p_title VARCHAR(150),
  IN p_genre VARCHAR(50),
  IN p_author_name VARCHAR(100)
)
BEGIN
  DECLARE v_author_id INT;

  -- find author
  SELECT AuthorID INTO v_author_id FROM Author WHERE Name = p_author_name LIMIT 1;

  -- if not found, insert
  IF v_author_id IS NULL THEN
    INSERT INTO Author (Name) VALUES (p_author_name);
    SET v_author_id = LAST_INSERT_ID();
  END IF;

  -- insert book
  INSERT INTO Book (Title, Genre, AuthorID) VALUES (p_title, p_genre, v_author_id);
END$$

/*
2) Stored Procedure with OUT parameter: Loan a book and return LoanID
   - IN p_bookid INT
   - IN p_memberid INT
   - OUT p_loanid INT
*/
CREATE PROCEDURE LoanBook(
  IN p_bookid INT,
  IN p_memberid INT,
  OUT p_loanid INT
)
BEGIN
  INSERT INTO Loan (BookID, MemberID, IssueDate, ReturnDate)
  VALUES (p_bookid, p_memberid, CURDATE(), NULL);
  SET p_loanid = LAST_INSERT_ID();
END$$

/*
3) Stored Procedure demonstrating conditional logic (return book)
   - IN p_loanid INT
   - OUT p_status VARCHAR(50)
*/
CREATE PROCEDURE ReturnBook(
  IN p_loanid INT,
  OUT p_status VARCHAR(50)
)
BEGIN
  IF EXISTS (SELECT 1 FROM Loan WHERE LoanID = p_loanid AND ReturnDate IS NULL) THEN
    UPDATE Loan SET ReturnDate = CURDATE() WHERE LoanID = p_loanid;
    SET p_status = 'Returned';
  ELSE
    SET p_status = 'Loan not active or does not exist';
  END IF;
END$$

/*
4) Scalar Function: Number of active loans for a member
   - returns INT
*/
CREATE FUNCTION ActiveLoanCount(p_memberid INT) RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE v_count INT;
  SELECT COUNT(*) INTO v_count FROM Loan WHERE MemberID = p_memberid AND ReturnDate IS NULL;
  RETURN v_count;
END$$

/*
5) Scalar Function: Average loan days for a book (returned loans)
*/
CREATE FUNCTION AvgLoanDaysForBook(p_bookid INT) RETURNS DECIMAL(6,2)
DETERMINISTIC
BEGIN
  DECLARE v_avg DECIMAL(6,2);
  SELECT ROUND(AVG(DATEDIFF(ReturnDate, IssueDate)),2) INTO v_avg
  FROM Loan
  WHERE BookID = p_bookid AND ReturnDate IS NOT NULL;
  RETURN COALESCE(v_avg, 0);
END$$

DELIMITER ;

-- Usage examples (MySQL):
-- CALL AddBookWithAuthor('SQL Mastery', 'Education', 'Prajwal Kumbar');
-- CALL LoanBook(1, 1, @newLoanId); SELECT @newLoanId;
-- CALL ReturnBook(2, @status); SELECT @status;
-- SELECT ActiveLoanCount(1) AS active_loans;
-- SELECT AvgLoanDaysForBook(1) AS avg_days;
