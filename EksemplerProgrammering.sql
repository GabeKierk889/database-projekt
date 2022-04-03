USE DELIMITER //

CREATE FUNCTION TotalDeltagerAntalPrForening (vID VARCHAR(10)) RETURNS INT
BEGIN
	DECLARE vDeltagere INT;
    SELECT COUNT(*) INTO vDeltagere FROM Deltager
    WHERE ID = vID;
    RETURN vDeltagere;
END //


CREATE FUNCTION ProcentKvinderPrEventType (vEventType VARCHAR(35)) RETURNS INT
BEGIN
	DECLARE vAntalKvinder INT;
    DECLARE vTotalAntalDeltagere INT;
    SELECT COUNT(*) INTO vTotalAntalDeltagere FROM Deltager
    WHERE EventType = vEventType;
    SELECT COUNT(*) INTO vAntalKvinder FROM Deltager NATURAL JOIN Person
    WHERE EventType = vEventType AND Køn = 'K';
    RETURN vAntalKvinder / vTotalAntalDeltagere * 100;
END //


CREATE PROCEDURE TilmeldDeltagerOgTildelStartNr (IN vEmail VARCHAR(35), IN vID VARCHAR(10), IN vDato DATE, IN vEventType VARCHAR(35))
BEGIN
	DECLARE vmaxStartNr INT; 
	SELECT MAX(StartNr) INTO vmaxStartNr FROM Deltager
    WHERE ID = vID AND Dato = vDato AND EventType = vEventType;
    INSERT Deltager VALUES (vEmail, vID, vDato, vEventType, (vmaxStartNr+1), null);
END //


CREATE PROCEDURE ÆndreEmail (IN vGammelEmail VARCHAR(35), IN vNyEmail VARCHAR(35))
BEGIN
	DECLARE vCount INT;
	SELECT COUNT(*) INTO vCount FROM Person WHERE Email = vNyEmail;
    IF vCount = 0 THEN
		START TRANSACTION;
		INSERT INTO Person
        SELECT vNyEmail, Fornavn, Efternavn, Vej, Fødselsdato, Køn FROM Person
        WHERE Email = vGammelEmail;
		UPDATE Deltager SET Email = vNyEmail WHERE Email = vGammelEmail;
		SELECT COUNT(*) INTO vCount FROM Deltager WHERE Email = vGammelEmail;
        IF vCount = 0 THEN
			DELETE FROM Person WHERE Email = vGammelEmail;
			COMMIT;
		ELSE ROLLBACK;
        END IF;
	END IF;
END //


CREATE TRIGGER ikkeGyldigEmail
BEFORE INSERT ON Person FOR EACH ROW
BEGIN
	IF NOT (LOCATE('@', NEW.Email ) > 1 AND LOCATE('.', NEW.Email ) > 1)
    THEN SIGNAL SQLSTATE 'HY000'
    SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'Indtast en gyldig email addresse';
    END IF;
END //

USE DELIMITER ;

# eksempler på brug af funktioner / procedurer
SELECT Navn, TotalDeltagerAntalPrForening(ID) as TotalAntalEventDeltagere FROM Idrætsforening;
SELECT EventType, ProcentKvinderPrEventType(EventType) as ProcentAndelKvinder FROM Begivenhed;
CALL TilmeldDeltagerOgTildelStartNr('DanseMyggen@gmail.com','OverAc', '20220330', 'MTB');
CALL ÆndreEmail('DanseMyggen@gmail.com', 'DanceMonkey@tones.com');
INSERT Person VALUES ('ikkegyldig.dk', 'Karen', 'Briansen', 'Briansvej', '19900201', 'K');

SELECT * FROM Deltager;
SELECT * FROM Idrætsforening;
SELECT * FROM Begivenhed;
SELECT * FROM Person;
SELECT * FROM aldersklasse;