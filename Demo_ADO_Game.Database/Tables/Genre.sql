CREATE TABLE [dbo].[Genre]
(
	[Id] INT IDENTITY NOT NULL, 
    [Name] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_Genre] PRIMARY KEY ([Id]),
    CONSTRAINT [UK_Genre__Name] UNIQUE([Name])
)
