CREATE TABLE [dbo].[GameGenre]
(
	[Id] INT IDENTITY NOT NULL, 
    [GameId] INT NOT NULL, 
    [GenreId] INT NOT NULL, 
    CONSTRAINT [PK_GameGenre] PRIMARY KEY ([Id]), 
    CONSTRAINT [FK_GameGenre__Game] 
        FOREIGN KEY ([GameId]) REFERENCES [Game]([Id]),
    CONSTRAINT [FK_GameGenre__Genre]
        FOREIGN KEY ([GenreId]) REFERENCES [Genre]([Id]),
    CONSTRAINT [UK_GameGenre] UNIQUE ([GameId], [GenreId])
)
