USE [SEDC.Homework]
--1/3
SELECT COUNT(g.Grade) AS Total
FROM Grade AS g

SELECT COUNT(g.Grade) AS TotalPerTeacher
FROM Grade AS g
GROUP BY TeacherID

SELECT COUNT(g.Grade) AS TotalPerTeacher
FROM Grade AS g
WHERE StudentID <= 100
GROUP BY TeacherID

SELECT MAX(g.Grade) AS MaxPerStudent, AVG(g.Grade) AS AvgPerStudent 
FROM Grade AS g
GROUP BY StudentID

--2/3
SELECT COUNT(g.Grade) AS TotalPerTeacher
FROM Grade AS g
GROUP BY TeacherID
HAVING COUNT(g.Grade) > 200

SELECT COUNT(g.Grade) AS TotalPerTeacher
FROM Grade AS g
WHERE StudentID <= 100
GROUP BY TeacherID
HAVING COUNT(g.Grade) > 50

SELECT COUNT(g.grade) AS GradeCounter, MAX(g.Grade) AS MaxPerStudent, AVG(g.Grade) AS AvgPerStudent 
FROM Grade AS g
GROUP BY StudentID
HAVING MAX(g.Grade)=AVG(g.Grade)

SELECT s.FirstName, s.LastName, COUNT(g.grade) AS GradeCounter, MAX(g.Grade) AS MaxPerStudent, AVG(g.Grade) AS AvgPerStudent
FROM Grade AS g
INNER JOIN Student AS s on  g.StudentID=s.ID
GROUP BY StudentID, s.FirstName, s.LastName
HAVING MAX(g.Grade)=AVG(g.Grade)

--3/3
CREATE VIEW vv_StudentGrades
AS
SELECT g.StudentID, COUNT(g.Grade) as TotalGradesPerStudent
FROM Grade AS g
GROUP BY g.StudentID

SELECT * FROM vv_StudentGrades as sg
ORDER BY sg.StudentID

ALTER VIEW vv_StudentGrades
AS
SELECT s.LastName,  s.FirstName, COUNT(g.Grade) as TotalGradesPerStudent
FROM Grade AS g
INNER JOIN Student as s on s.ID = g.StudentID
GROUP BY s.FirstName, s.LastName

SELECT * FROM vv_StudentGrades

SELECT * FROM vv_StudentGrades AS sg
ORDER BY sg.TotalGradesPerStudent DESC

CREATE VIEW vv_StudentGradeDetails
AS
SELECT s.FirstName, s.LastName, COUNT(g.Grade) AS PassedExams
FROM GradeDetails AS gd
INNER JOIN Grade AS g on g.ID=gd.GradeID
INNER JOIN Student AS s on s.ID=g.StudentID
WHERE gd.AchievementPoints >50
GROUP BY s.FirstName, s.LastName

SELECT * FROM vv_StudentGradeDetails
