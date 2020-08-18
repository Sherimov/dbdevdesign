alter FUNCTION dbo.fn_StudentGradesByCourseAndTeacher(@TeacherID SMALLINT, @CourseID SMALLINT)
RETURNS @output TABLE(FirstName NVARCHAR(100), LastName NVARCHAR(100), Grade TINYINT, CreatedDate DATETIME)
AS
BEGIN
	INSERT INTO @output(FirstName, LastName, Grade, CreatedDate)
	SELECT s.FirstName, s.LastName, g.Grade, g.CreatedDate
	FROM
		dbo.Teacher as t
		INNER JOIN dbo.Grade as g on t.ID = g.TeacherID
		INNER JOIN dbo.Student as s on s.ID = g.StudentID
		INNER JOIN dbo.Course as c on c.ID = g.CourseID
	WHERE
		@TeacherID = t.ID and
		@CourseID = c.ID and
		  g.Grade > 5
		GROUP BY s.FirstName, s.LastName, g.Grade, g.CreatedDate
	RETURN
END

select * from dbo.fn_StudentGradesByCourseAndTeacher(1,1)