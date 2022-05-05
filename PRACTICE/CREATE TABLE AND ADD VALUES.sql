create Database CROMA;
go
Use CROMA;
go
create table artists(artistId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
ArtistName nvarchar(255) NOT NUll,
ActiveFrom date);
Go

Create Table Genres(GenerId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Genre nvarchar(50) Not Null );

CREATE TABLE Albums (
  AlbumId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
  AlbumName nvarchar(255) NOT NULL,
  ReleaseDate date NOT NULL,
  ArtistId int NOT NULL,
  GenreId int NOT NULL

  CONSTRAINT FK_Albums_Artists FOREIGN KEY (ArtistId)     
    REFERENCES dbo.Artists (ArtistId)     
    ON DELETE NO ACTION    
    ON UPDATE NO ACTION    
);

USE BLUSTAR; 
SELECT column_name, data_type, character_maximum_length, is_nullable 
FROM information_schema.columns;

USE Music; 
SELECT column_name, data_type, character_maximum_length, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'Artists';


INSERT INTO Artists (ArtistName, ActiveFrom)
VALUES 
  ('Iron Maiden','1975-12-25'),
  ('AC/DC','1973-01-11'), 
  ('Allan Holdsworth','1969-01-01'),
  ('Buddy Rich','1919-01-01'),
  ('Devin Townsend','1993-01-01'),
  ('Jim Reeves','1948-01-01'),
  ('Tom Jones','1963-01-01'),
  ('Maroon 5','1994-01-01'),
  ('The Script','2001-01-01'),
  ('Lit','1988-06-26'),
  ('Black Sabbath','1968-01-01'),
  ('Michael Learns to Rock','1988-03-15'),
  ('Carabao','1981-01-01'),
  ('Karnivool','1997-01-01'),
  ('Birds of Tokyo','2004-01-01'),
  ('Bodyjar','1990-01-01');

  select * from artists;

  INSERT INTO Genres (Genre)
VALUES 
  ('Rock'),
  ('Jazz'), 
  ('Country'),
  ('Pop'),
  ('Blues'),
  ('Hip Hop'),
  ('Rap'),
  ('Punk');

INSERT INTO Albums (AlbumName, ReleaseDate, ArtistId, GenreId)
VALUES 
  ('Powerslave', '1984-09-03', 1, 1),
  ('Powerage', '1978-05-05', 2, 1), 
  ('Singing Down the Lane', '1956-01-01', 6, 3),
  ('Ziltoid the Omniscient', '2007-05-21', 5, 1),
  ('Casualties of Cool', '2014-05-14', 5, 1),
  ('Epicloud', '2012-09-18', 5, 1),
  ('Somewhere in Time', '1986-09-29', 1, 1),	
  ('Piece of Mind', '1983-05-16', 1, 1),	
  ('Killers', '1981-02-02', 1, 1),	
  ('No Prayer for the Dying', '1990-10-01', 1, 1),	
  ('No Sound Without Silence', '2014-09-12', 9, 4),	
  ('Big Swing Face', '1967-06-01', 4, 2),	
  ('Blue Night', '2000-11-01', 12, 4),	
  ('Eternity', '2008-10-27', 12, 4),	
  ('Scandinavia', '2012-06-11', 12, 4),	
  ('Long Lost Suitcase', '2015-10-09', 7, 4),	
  ('Praise and Blame', '2010-06-26', 7, 4),	
  ('Along Came Jones', '1965-05-21', 7, 4),	
  ('All Night Wrong', '2002-05-05', 3, 2),	
  ('The Sixteen Men of Tain', '2000-03-20', 3, 2);

  select AlbumID,AlbumName,ArtistName
  from Albums
  INNER JOIN artists
  on Albums.ArtistId=artists.artistId
  where ReleaseDate<'1990-01-01';

  select * from Albums;
  select * from artists;

  select count(distinct AlbumName)
  from Albums;



