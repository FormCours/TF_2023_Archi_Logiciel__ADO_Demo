CREATE TABLE [dbo].[Game]
(
	[Id] INT IDENTITY NOT NULL,
	[Name] NVARCHAR(100) NOT NULL,
	[Description] NVARCHAR(MAX) NULL,
	[ReleaseDate] DATE NULL,
	[StudioId] INT NOT NULL,
	
	CONSTRAINT PK_Game PRIMARY KEY([Id]), 
    CONSTRAINT [FK_Game__Studio] 
		FOREIGN KEY ([StudioId]) REFERENCES [Studio]([Id]) 
)

GO

CREATE INDEX [IDX_Game__Name] ON [dbo].[Game] ([Name])
