CREATE OR ALTER PROCEDURE Demo.GetPerson
   @PersonId INT
AS

SELECT P.FirstName, P.LastName
FROM Demo.Person P
WHERE P.PersonId = @PersonId;
GO
