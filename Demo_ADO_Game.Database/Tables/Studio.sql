CREATE TABLE [dbo].[Studio]
(
	[Id] INT IDENTITY NOT NULL , 
    [Name] NVARCHAR(50) NOT NULL, 
    [Country] NVARCHAR(50) NULL, 
    [IsActive] BIT NOT NULL DEFAULT 1, 
    CONSTRAINT [PK_Studio] PRIMARY KEY ([Id]), 
    CONSTRAINT [UK_Studio__NameCountry] UNIQUE ([Name], [Country])
)
