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
('ua', 'Under Achievers', 'Odinsvej', '1360', 'UnderAchievers@gmail.com', '31813181');

INSERT INTO Person(Email, Fornavn, Efternavn, Adresse, Postnr, Fødselsdato, Køn) VALUES
('knaldperlen@gmail.com', 'Brian', 'Briansen', 'Briansvej', '1500', '19900202', 'M'),
('DanseMyggen@gmail.com', 'Karen', 'Briansen', 'Briansvej', '1500', '19900201', 'K');

INSERT INTO Begivenhed(ForeningsID, Dato, EventTypeID) VALUES
('oa', '20220330', 'MTB'),
('ua', '20220202', '10km');

INSERT INTO Deltager(Email, ForeningsID, Dato, EventTypeID, StartNr, Resultat) VALUES
('knaldperlen@gmail.com', 'oa', '20220330', 'MTB', '001', '01:52:23'),
('DanseMyggen@gmail.com', 'ua', '20220202', '10km', '001', '00:30:28');

INSERT INTO Aldersklasse(EventTypeID, Køn, FraAlder, TilAlder) VALUES
('0','9'),
('10','19'),
('20','29'),
('30','39'),
('40','49'),
('50','59'),
('60','69'),
('70','79'),
('80','89'),
('90','99'),
('100','199');

# Vis tabellerne
SELECT * FROM Idrætsforening;
SELECT * FROM Person;
SELECT * FROM Begivenhed;
SELECT * FROM Deltager;
SELECT * FROM Aldersklasse;