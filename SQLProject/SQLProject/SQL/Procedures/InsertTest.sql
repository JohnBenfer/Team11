CREATE OR ALTER PROCEDURE Homework4.InsertTest
   @ClubName NVARCHAR(32),
   @ClubPurpose NVARCHAR(128),
   @ClubId INT OUTPUT
AS

INSERT Homework4.Club([Name], Purpose)
VALUES(@ClubName, @ClubPurpose);

SET @ClubId = SCOPE_IDENTITY();
GO
