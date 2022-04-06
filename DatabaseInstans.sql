# Hvis databasen eksisterer, bliver den slettet.
DROP DATABASE IF EXISTS Tidsmaskinen;

# Opret database og brug den
CREATE DATABASE Tidsmaskinen;
USE Tidsmaskinen;

# Tabeller opsættes her.
CREATE TABLE Idrætsforening
    (ForeningsID        VARCHAR(10) NOT NULL,
     Navn            	VARCHAR(35) NOT NULL,
     Adresse           	VARCHAR(35),
     Postnr				DECIMAL(4,0),
     Email           	VARCHAR(35),
     TelefonNr       	DECIMAL(8,0),
     PRIMARY KEY(ForeningsID)
    );
    
CREATE TABLE Person
    (Email           	VARCHAR(35) NOT NULL,
     Fornavn         	VARCHAR(35) NOT NULL,
     Efternavn       	VARCHAR(35) NOT NULL,
     Adresse           	VARCHAR(35),
     Postnr				DECIMAL(4,0),
     Fødselsdato     	DATE NOT NULL,
     Køn             	ENUM('M','K') NOT NULL,
     PRIMARY KEY(Email)
    );
 
CREATE TABLE EventType
    (EventTypeID       	VARCHAR(15) NOT NULL,
     PRIMARY KEY(EventTypeID)
    ); 
 
CREATE TABLE Begivenhed
    (ForeningsID        VARCHAR(10) NOT NULL,
     Dato            	DATE NOT NULL,
     EventTypeID       	VARCHAR(15) NOT NULL,
     PRIMARY KEY(ForeningsID,Dato,EventTypeID),
     FOREIGN KEY(ForeningsID) REFERENCES Idrætsforening(ForeningsID) ON DELETE CASCADE,
	 FOREIGN KEY(EventTypeID) REFERENCES EventType(EventTypeID) ON DELETE CASCADE
    );

CREATE TABLE Deltager
    (Email           	VARCHAR(35) NOT NULL,
     ForeningsID        VARCHAR(10) NOT NULL,
     Dato            	DATE NOT NULL,
     EventTypeID       	VARCHAR(15) NOT NULL,
     StartNr         	DECIMAL(3,0) NOT NULL,
     Resultat        	TIME,
     PRIMARY KEY(Email,ForeningsID,Dato,EventTypeID),
     FOREIGN KEY(Email) REFERENCES Person(Email) ON DELETE CASCADE,
     FOREIGN KEY(ForeningsID, Dato, EventTypeID) REFERENCES Begivenhed(ForeningsID, Dato, EventTypeID) ON DELETE CASCADE
    );
    
CREATE TABLE Aldersklasse
	(EventTypeID		VARCHAR(15) NOT NULL,
     Køn				ENUM('M','K') NOT NULL,
     FraAlder			DECIMAL(3,0) NOT NULL,
     TilAlder			DECIMAL(3,0) NOT NULL,
     PRIMARY KEY(EventTypeID, Køn, FraAlder),
     FOREIGN KEY(EventTypeID) REFERENCES EventType(EventTypeID) ON DELETE CASCADE
    );
    
# Indsættelse af data i tabellerne
INSERT INTO Idrætsforening(ForeningsID, Navn, Adresse, Postnr, Email, TelefonNr) VALUES
('oa', 'Over Achievers', 'Lærkevej', '1500', 'OverAchievers@gmail.com', '18131813'),
('ua', 'Under Achievers', 'Odinsvej', '1360', 'UnderAchievers@gmail.com', '31813181'),
('vk', 'vikingerne', 'Roskildevej', '3600', 'odin@gmail.com', '44248271'),
('A', 'Avengers', 'Stark', '9090', 'avengers@gmail.com', '24819417'),
('O', 'Olympus', 'Midgårdsvej', '8500', 'olympen@gmail.com', '24158927');

INSERT INTO Person(Email, Fornavn, Efternavn, Adresse, Postnr, Fødselsdato, Køn) VALUES
('knaldperlen@gmail.com', 'Brian', 'Briansen', 'Briansvej', '1500', '19900202', 'M'),
('DanseMyggen@gmail.com', 'Karen', 'Briansen', 'Briansvej', '1500', '19900201', 'K'),
('dansermedulve@gmail.com', 'Mikkel', 'Christensen', 'Mørkevej', '1429', '19900201', 'M'),
('easteregg@gmail.com', 'Bugs', 'Bunny', 'Solvej', '1852', '19900224', 'M'),
('elizabeth@gmail.com', 'Elizabeth', 'Markussen', 'Gefion', '8294', '19900205', 'K');

INSERT INTO EventType(EventTypeID) VALUES
('MTB'),
('10km'),
('5km'),
('SV'),
('BC');


INSERT INTO Begivenhed(ForeningsID, Dato, EventTypeID) VALUES
('oa', '20220330', 'MTB'),
('ua', '20220202', '10km'),
('A', '20220202', '10km'),
('O', '20220330', 'MTB'),
('vk', '20220328', 'BC');

INSERT INTO Deltager(Email, ForeningsID, Dato, EventTypeID, StartNr, Resultat) VALUES
('knaldperlen@gmail.com', 'oa', '20220330', 'MTB', '001', '01:52:23'),
('DanseMyggen@gmail.com', 'ua', '20220202', '10km', '001', '00:30:28'),
('dansermedulve@gmail.com', 'vk', '20220328', 'BC', '002', '00:50:29'),
('easteregg@gmail.com', 'O', '20220330', 'MTB', '002', '00:28:10'),
('elizabeth@gmail.com', 'A', '20220202', '10km', '001', '00:11:09');

INSERT INTO Aldersklasse(EventTypeID, Køn, FraAlder, TilAlder) VALUES
('MTB','M','0','9'),
('MTB','M','10','19'),
('MTB','M','20','29'),
('MTB','M','30','39'),
('MTB','M','40','49'),
('MTB','M','50','59'),
('MTB','M','60','69'),
('MTB','M','70','79'),
('MTB','M','80','89'),
('MTB','M','90','99'),
('MTB','M','100','199'),
('MTB','K','0','9'),
('MTB','K','10','19'),
('MTB','K','20','29'),
('MTB','K','30','39'),
('MTB','K','40','49'),
('MTB','K','50','59'),
('MTB','K','60','69'),
('MTB','K','70','79'),
('MTB','K','80','89'),
('MTB','K','90','99'),
('MTB','K','100','199'),
('10km','M','0','9'),
('10km','M','10','19'),
('10km','M','20','29'),
('10km','M','30','39'),
('10km','M','40','49'),
('10km','M','50','59'),
('10km','M','60','69'),
('10km','M','70','79'),
('10km','M','80','89'),
('10km','M','90','99'),
('10km','M','100','199'),
('10km','K','0','9'),
('10km','K','10','19'),
('10km','K','20','29'),
('10km','K','30','39'),
('10km','K','40','49'),
('10km','K','50','59'),
('10km','K','60','69'),
('10km','K','70','79'),
('10km','K','80','89'),
('10km','K','90','99'),
('10km','K','100','199');

# Vis tabellerne
SELECT * FROM Idrætsforening;
SELECT * FROM Person;
SELECT * FROM Begivenhed;
SELECT * FROM Deltager;
SELECT * FROM Aldersklasse;