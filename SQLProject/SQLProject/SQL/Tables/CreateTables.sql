DROP TABLE IF EXISTS Demo.PersonAddress;
DROP TABLE IF EXISTS Demo.AddressType;
DROP TABLE IF EXISTS Demo.Person;

CREATE TABLE Demo.Person
(
   PersonId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
   FirstName NVARCHAR(32) NOT NULL,
   LastName NVARCHAR(32) NOT NULL,
   CreatedOn DATETIMEOFFSET NOT NULL DEFAULT(SYSDATETIMEOFFSET()),
   UpdatedOn DATETIMEOFFSET NOT NULL DEFAULT(SYSDATETIMEOFFSET()),

   UNIQUE(FirstName, LastName),

   CHECK(FirstName > N'' OR LastName > N'')
);

CREATE TABLE Demo.AddressType
(
   AddressTypeId TINYINT NOT NULL PRIMARY KEY,
   [Name] VARCHAR(8) NOT NULL UNIQUE
);

-- This table uses explicit constraint names.
-- You'll see why later.
CREATE TABLE Demo.PersonAddress
(
   PersonAddressId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
   PersonId INT NOT NULL,
   AddressTypeId TINYINT NOT NULL,
   Line1 NVARCHAR(32) NOT NULL
      CONSTRAINT CK_Demo_PersonAddress_Line1 CHECK(Line1 > N''),
   Line2 NVARCHAR(32) NULL
      CONSTRAINT CK_Demo_PersonAddress_Line2 CHECK(Line2 > N''),
   City NVARCHAR(64) NOT NULL
      CONSTRAINT CK_Demo_PersonAddress_City CHECK(City > N''),
   StateCode CHAR(2) NOT NULL
      CONSTRAINT CK_Demo_PersonAddress_StateCode CHECK(StateCode > N''),
   ZipCode CHAR(5) NOT NULL
      CONSTRAINT CK_Demo_PersonAddress_ZipCode CHECK(ZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]'),
   CreatedOn DATETIMEOFFSET NOT NULL
      CONSTRAINT DF_Demo_PersonAddress_CreatedOn DEFAULT(SYSDATETIMEOFFSET()),
   UpdatedOn DATETIMEOFFSET NOT NULL
      CONSTRAINT DF_Demo_PersonAddress_UpdatedOn DEFAULT(SYSDATETIMEOFFSET()),

   CONSTRAINT UK_Demo_PersonAddress_PersonId_AddressTypeId UNIQUE
   (
      PersonId,
      AddressTypeId
   ),

   CONSTRAINT FK_Demo_PersonAddress_Demo_Person FOREIGN KEY(PersonId)
   REFERENCES Demo.Person(PersonId),

   CONSTRAINT FK_Demo_PersonAddress_Demo_AddressType FOREIGN KEY(AddressTypeId)
   REFERENCES Demo.AddressType(AddressTypeId)
);
GO

INSERT Demo.AddressType(AddressTypeId, [Name])
VALUES
   (1, 'Home'),
   (2, 'Work'),
   (3, 'School'),
   (4, 'Other');
