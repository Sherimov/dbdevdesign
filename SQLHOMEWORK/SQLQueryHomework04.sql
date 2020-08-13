USE [SEDC.Homework]
--1/2
DECLARE @FirstNameValues NVARCHAR(100)
SET @FirstNameValues = 'Antonio'

SELECT * FROM Student
WHERE FirstName = @FirstNameValues

DECLARE @StudentInfo TABLE
(StudentID INT, StudentName NVARCHAR(100), DateOfBirth DATE)

INSERT INTO @StudentInfo
SELECT s.ID, s.FirstName, s.DateOfBirth
FROM Student AS s
WHERE Gender = 'F'

SELECT * FROM @StudentInfo

CREATE TABLE #StudentEnrollementDate
(LastName NVARCHAR(100), EnrolledDate DATE)

INSERT INTO #StudentEnrollementDate
SELECT s.LastName, s.EnrolledDate
FROM Student AS s
WHERE s.Gender = 'M' and FirstName LIKE 'A%'

SELECT * FROM #StudentEnrollementDate as st
WHERE LEN(st.LastName) = 7

SELECT t.FirstName, t.LastName, SUBSTRING(t.FirstName,1, 3) AS subFirst, SUBSTRING(t.LastName,1, 3) AS subLast
FROM Teacher AS t
WHERE LEN(t.FirstName) < 5 and SUBSTRING(t.FirstName,1, 3) = SUBSTRING(t.LastName,1, 3)

--2/2

ALTER FUNCTION dbo.fn_FormatStudentName(@StudentID INT)
RETURNS NVARCHAR(1000)
AS
BEGIN

DECLARE @Result NVARCHAR(1000)
SELECT @Result = SUBSTRING(s.StudentCardNumber, 4, 8) + '-' + LEFT(s.FirstName, 1) + '.' + s.LastName
FROM Student as s
WHERE s.ID = @StudentID

RETURN @Result
END

SELECT *, dbo.fn_FormatStudentName(s.ID) as FunctionResult
FROM Student as s