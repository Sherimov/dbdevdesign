CREATE OR ALTER PROCEDURE dbo.usp_CreateGrade
(
	@StudentID INT,
	@CourseID SMALLINT,
	@TeacherID SMALLINT,
	@Grade TINYINT,
	@CreatedDate DATETIME
)
AS
BEGIN
	INSERT INTO dbo.Grade( StudentID, CourseID, TeacherID, Grade, CreatedDate )
	VALUES ( @StudentID, @CourseID, @TeacherID, @Grade, @CreatedDate)

	SELECT 
		COUNT(*) AS TotalGrades
	FROM
		dbo.Grade
	WHERE
		@StudentID = StudentID
	SELECT 
		MAX(Grade) AS MaxGrade
	FROM 
		dbo.Grade
	WHERE
		@StudentID = StudentID 
		AND @TeacherID = TeacherID
END

EXEC dbo.usp_CreateGrade
@StudentID = 3,
@CourseID = 1,
@TeacherID = 4,
@Grade = 6,
@CreatedDate = '1999-02-05 00:00:00.000'

select createddate from dbo.Grade

select * from grade where StudentID = 3 and TeacherID = 4

select * from GradeDetails
select * from AchievementType

CREATE OR ALTER PROCEDURE dbo.usp_CreateGradeDetail
(
	@GradeID INT,
	@AchievementTypeID TINYINT,
	@AchievementPoints TINYINT,
	@AchievementMaxPoints TINYINT,
	@AchievementDate DATETIME
)
AS
BEGIN
	DECLARE
	@ParticipationRate TINYINT

	SELECT @ParticipationRate = ParticipationRate
	FROM dbo.AchievementType
	WHERE @AchievementTypeID = ID

	INSERT INTO dbo.GradeDetails (GradeID, AchievementTypeID, AchievementPoints,AchievementMaxPoints, AchievementDate)
	VALUES(@GradeID ,@AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate)

	SELECT SUM(AchievementPoints / AchievementMaxPoints * @ParticipationRate) AS GradeOutput
	FROM dbo.GradeDetails
	WHERE
	@GradeID = GradeID
END

EXEC dbo.usp_CreateGradeDetail
@GradeID = 220,
@AchievementTypeID = 5,
@AchievementPoints = 58,
@AchievementMaxPoints = 70,
@AchievementDate = '1999-02-05 00:00:00.000'