-- Clean data
DELETE FROM [GameGenre];
DELETE FROM [Genre];
DELETE FROM [Game];
DELETE FROM [Studio];
GO

-- Add initial data
--- Studio
SET IDENTITY_INSERT [Studio] ON;
INSERT INTO [Studio] ([Id], [Name], [Country])
 VALUES (1, 'Nintendo', 'Japon'),
		(2, 'Supergiant Games', 'USA');
SET IDENTITY_INSERT [Studio] OFF;

--- Game
SET IDENTITY_INSERT [Game] ON;
INSERT INTO [Game] ([Id], [Name], [Description], [ReleaseDate], [StudioId])
 VALUES (1, N'Mario Kart 8 Deluxe', N'Mario Kart 8 (マリオカート8, Mario Kāto Eito?) est un jeu vidéo de course développé par Nintendo EAD et édité par Nintendo pour la console Wii U. Huitième opus de la série Mario Kart, il est sorti en 2014 au Japon, en Europe, en Australie et en Amérique du Nord. Une reprise améliorée du jeu nommée Mario Kart 8 Deluxe est sortie le 28 avril 2017 sur Nintendo Switch.', '2017-04-28', 1),
		(2, N'Bastion', NULL, '2011-07-20', 2),
		(3, N'Hades', N'Fondé sur la mythologie grecque, le jeu met en scène Zagreus, jeune fils d''Hadès et prince des Enfers, alors qu''il essaye désespérément de fuir le royaume de son père et d''émerger dans le monde des mortels. Aidé dans son périple par sa lointaine famille sur le mont Olympe, il progresse dans différentes régions des Enfers : le Tartare, l''Asphodèle, et l''Élysée. Lors de chaque tentative d''évasion, le joueur traverse plusieurs salles choisies aléatoirement et générées procéduralement, peuplées d''ennemis et lui proposant plusieurs récompenses. Le jeu emploie un système de combat de type hack ''n'' slash offrant une attaque de base, une technique spéciale, un dash et une capacité dite « ultime », auquel le joueur a recours pour venir à bout de ses ennemis. Si Zagreus vient à périr, il est systématiquement ramené au palais de son père au cœur des Enfers, à partir duquel il pourra s''élancer à nouveau en bénéficiant des trésors et objets trouvés lors de ses échappées précédentes, et ainsi progresser et augmenter ses chances d''évasion.', '2020-09-17', 2),
		(4, N'Hades II', NULL, NULL, 2)
SET IDENTITY_INSERT [Game] OFF;

--- Genre
SET IDENTITY_INSERT [Genre] ON;
INSERT INTO [Genre] ([Id], [Name])
 VALUES (1, 'Roguelite'),
		(2, 'Action-RPG'),
		(3, 'Course'),
		(4, 'Combat motorisé'),
		(5, 'Plate-forme'),
		(6, 'Party game');
SET IDENTITY_INSERT [Genre] OFF;

--- GameGenre
SET IDENTITY_INSERT [GameGenre] ON;
INSERT INTO [GameGenre] ([Id], [GameId], [GenreId])
 VALUES (1, 1, 3),
		(2, 1, 4),
		(3, 2, 2),
		(4, 3, 1),
		(5, 3, 2),
		(6, 4, 1),
		(7, 4, 2);
SET IDENTITY_INSERT [GameGenre] OFF;


-- Create new login
USE [master]
GO

IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE [name] = 'GameUser')
 BEGIN
	CREATE LOGIN [GameUser] 
	WITH PASSWORD=N'Test1234=', 
		 DEFAULT_DATABASE=[master], 
		 CHECK_EXPIRATION=OFF, 
		 CHECK_POLICY=OFF
 END
GO

-- Create new user for login
USE [GameDB]
GO

IF NOT EXISTS (SELECT * FROM sys.sysusers WHERE [name] = 'GameUser')
 BEGIN
	CREATE USER [GameUser] FOR LOGIN [GameUser]
 END
GO

ALTER ROLE [db_datareader] ADD MEMBER [GameUser]
ALTER ROLE [db_datawriter] ADD MEMBER [GameUser]
GO
