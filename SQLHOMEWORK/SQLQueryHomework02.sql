USE [SEDC.Homework]
--1/6
SELECT * FROM Student 
WHERE FirstName = 'Antonio'

SELECT * FROM Student 
WHERE DateOfBirth > '1999.01.01'

SELECT * FROM Student 
WHERE Gender = 'M'

SELECT * FROM Student 
WHERE LastName like 'T%'

SELECT * FROM Student 
WHERE EnrolledDate >='1998.01.01' and EnrolledDate <= '1998.01.31'

SELECT * FROM Student 
WHERE EnrolledDate >='1998.01.01' and EnrolledDate <= '1998.01.31' and LastName like 'J%'

--2/6
SELECT * FROM Student 
WHERE FirstName = 'Antonio'
ORDER BY LastName

SELECT * FROM Student 
ORDER BY FirstName

SELECT * FROM Student
WHERE Gender='M'
ORDER BY EnrolledDate DESC

--3/6

SELECT FirstName FROM Teacher 
UNION ALL
SELECT FirstName FROM Student

SELECT LastName FROM Teacher 
UNION
SELECT LastName FROM Student

SELECT FirstName FROM Teacher 
INTERSECT
SELECT FirstName FROM Student

--4/6

ALTER TABLE GradeDetails
ADD CONSTRAINT DF_GRADEDETAILS_ACHIEVEMENTMAXPOINTS
DEFAULT 100 FOR [AchievementMaxPoints]


ALTER TABLE GradeDetails
ADD CONSTRAINT CHK_GRADEDETAILS_ACHIEVMENTPOINTS
CHECK (AchievementPoints <= AchievementMaxPoints)


ALTER TABLE AchievementType WITH CHECK
ADD CONSTRAINT UC_ACHIEVEMENTTYPE_NAME
UNIQUE ([Name])

--5/6
ALTER TABLE Grade
ADD CONSTRAINT FK_CourseID
FOREIGN KEY (CourseID) REFERENCES Course(ID)

ALTER TABLE Grade
ADD CONSTRAINT FK_StudentID
FOREIGN KEY (StudentID) REFERENCES Student(ID)

ALTER TABLE Grade
ADD CONSTRAINT FK_TeacherID
FOREIGN KEY (TeacherID) REFERENCES Teacher(ID)

ALTER TABLE GradeDetails
ADD CONSTRAINT FK_GradeID
FOREIGN KEY (GradeID) REFERENCES Grade(ID)

ALTER TABLE GradeDetails
ADD CONSTRAINT FK_AchievementID
FOREIGN KEY (AchievementTypeID) REFERENCES AchievementType(ID)

--6/6
SELECT c.[Name], [at].[Name]
FROM Course AS c
CROSS JOIN AchievementType AS [at]

SELECT t.ID, g.TeacherID, t.FirstName, t.LastName
FROM Teacher AS t
INNER JOIN Grade AS g ON t.id=g.TeacherID

SELECT t.ID, g.TeacherID, t.FirstName, t.LastName
FROM Teacher AS t
LEFT OUTER JOIN Grade AS g ON t.id=g.TeacherID
WHERE G.Grade IS NULL

SELECT s.FirstName, s.LastName, s.ID, g.StudentID
FROM Grade AS g
RIGHT OUTER JOIN Student as s on s.ID=g.StudentID
WHERE g.Grade IS NULL