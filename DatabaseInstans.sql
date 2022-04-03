# Hvis tabellerne eksisterer, bliver de slettet.
DROP DATABASE IF EXISTS Tidsmaskinen;

CREATE DATABASE Tidsmaskinen;
USE Tidsmaskinen;
 
-- DROP TABLE IF EXISTS Deltager;
-- DROP TABLE IF EXISTS Begivenhed;
-- DROP TABLE IF EXISTS Aldersklasse;
-- DROP TABLE IF EXISTS Person;
-- DROP TABLE IF EXISTS Idrætsforening;


# Tabeller opsættes her.

CREATE TABLE Idrætsforening
    (ID              	VARCHAR(10) NOT NULL,
     Navn            	VARCHAR(35) NOT NULL,
     Vej             	VARCHAR(35),
     Email           	VARCHAR(35),
     TelefonNr       	DECIMAL(8,0),
     PRIMARY KEY(ID)
    );
    
CREATE TABLE Person
    (Email           	VARCHAR(35) NOT NULL,
     Fornavn         	VARCHAR(35) NOT NULL,
     Efternavn       	VARCHAR(35) NOT NULL,
     Vej             	VARCHAR(35),
     Fødselsdato     	DATE NOT NULL,
     Køn             	ENUM('M','K') NOT NULL,
     PRIMARY KEY(Email)
    );
    
CREATE TABLE Begivenhed
    (ID              	VARCHAR(10) NOT NULL,
     Dato            	DATE NOT NULL,
     EventType       	VARCHAR(35) NOT NULL,
     PRIMARY KEY(ID,Dato,EventType),
     FOREIGN KEY(ID) REFERENCES Idrætsforening(ID) ON DELETE CASCADE
    );

CREATE TABLE Deltager
    (Email           	VARCHAR(35) NOT NULL,
     ID              	VARCHAR(10) NOT NULL,
     Dato            	DATE NOT NULL,
     EventType       	VARCHAR(35) NOT NULL,
     StartNr         	DECIMAL(3,0) NOT NULL,
     Resultat        	TIME,
     PRIMARY KEY(Email,ID,Dato,EventType),
     FOREIGN KEY(Email) REFERENCES Person(Email) ON DELETE CASCADE,
     FOREIGN KEY(ID) REFERENCES Idrætsforening(ID) ON DELETE CASCADE,
     FOREIGN KEY(ID, Dato, EventType) REFERENCES Begivenhed(ID, Dato, EventType) ON DELETE CASCADE
    );
    
CREATE TABLE Aldersklasse
	(Minimumsgrænse		DECIMAL(3,0) NOT NULL,
     Maksimumsgrænse	DECIMAL(3,0) NOT NULL,
     PRIMARY KEY(Minimumsgrænse)
    );
    
# Indsættelse af data i tabellerne
INSERT INTO Idrætsforening(ID, navn, Vej, Email, TelefonNr) VALUES
('oa', 'Over Achievers', 'Lærkevej', 'OverAchievers@gmail.com', '18131813'),
('ua', 'Under Achievers', 'Odinsvej', 'UnderAchievers@gmail.com', '31813181');

INSERT INTO Person(Email, Fornavn, Efternavn, Vej, Fødselsdato, Køn) VALUES
('knaldperlen@gmail.com', 'Brian', 'Briansen', 'Briansvej', '19900202', 'M'),
('DanseMyggen@gmail.com', 'Karen', 'Briansen', 'Briansvej', '19900201', 'K');

INSERT INTO Begivenhed(ID, Dato, EventType) VALUES
('oa', '20220330', 'MTB'),
('ua', '20220202', '10km');

INSERT INTO Deltager(Email, ID, Dato, EventType, StartNr, Resultat) VALUES
('knaldperlen@gmail.com', 'oa', '20220330', 'MTB', '001', '01:52:23'),
('DanseMyggen@gmail.com', 'ua', '20220202', '10km', '001', '00:30:28');

INSERT INTO Aldersklasse(Minimumsgrænse, Maksimumsgrænse) VALUES
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
