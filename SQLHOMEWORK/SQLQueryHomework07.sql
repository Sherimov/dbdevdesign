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

SELECT 
	@ParticipationRate = participationRate
FROM 
	dbo.AchievementType
WHERE 
	@AchievementTypeID = ID

BEGIN TRY
	INSERT INTO 
		dbo.GradeDetails (GradeID, AchievementTypeID, AchievementPoints,AchievementMaxPoints, AchievementDate)
	VALUES
		(@GradeID ,@AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, @AchievementDate)
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_SEVERITY() AS ErrorSeverity,
		ERROR_STATE() AS ErrorState,
		ERROR_PROCEDURE() AS ErrorProcedure,
		ERROR_LINE() AS ErrorLine,
		ERROR_MESSAGE() AS ErrorMessage
END CATCH
	SELECT 
		SUM(CAST(gd.AchievementPoints AS DECIMAL(6,2)) / CAST(gd.AchievementMaxPoints AS DECIMAL(6,2)) * @ParticipationRate) AS GradeOutput
	FROM 
		dbo.GradeDetails AS gd 
	WHERE
		@GradeID = GradeID
END

EXEC dbo.usp_CreateGradeDetail
@GradeID = 66,
@AchievementTypeID = 33,
@AchievementPoints = 68,
@AchievementMaxPoints = 100,
@AchievementDate = '1999-02-05 00:00:00.000'