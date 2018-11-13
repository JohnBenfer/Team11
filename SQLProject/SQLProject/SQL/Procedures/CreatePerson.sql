CREATE OR ALTER PROCEDURE Demo.CreatePerson
   @FirstName NVARCHAR(32),
   @LastName NVARCHAR(32),
   @PersonId INT OUTPUT
AS

INSERT Demo.Person(FirstName, LastName)
VALUES(@FirstName, @LastName);

SET @PersonId = SCOPE_IDENTITY();
GO
