CREATE OR ALTER PROCEDURE Demo.RetrievePersons
AS

SELECT P.PersonId, P.FirstName, P.LastName
FROM Demo.Person P;
GO
