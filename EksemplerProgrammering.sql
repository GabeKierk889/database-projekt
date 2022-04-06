USE Tidsmaskinen;
USE DELIMITER //
CREATE FUNCTION TotalDeltagerAntalPrForening (vForeningsID VARCHAR(10)) RETURNS INT
BEGIN
	DECLARE vDeltagere INT;
    SELECT COUNT(*) INTO vDeltagere FROM Deltager
    WHERE ForeningsID = vForeningsID;
    RETURN vDeltagere;
END //


CREATE FUNCTION ProcentKvinderPrEventType (vEventTypeID VARCHAR(35)) RETURNS INT
BEGIN
	DECLARE vAntalKvinder INT;
    DECLARE vTotalAntalDeltagere INT;
    SELECT COUNT(*) INTO vTotalAntalDeltagere FROM Deltager
    WHERE EventTypeID = vEventTypeID;
    SELECT COUNT(*) INTO vAntalKvinder FROM Deltager NATURAL JOIN Person
    WHERE EventTypeID = vEventTypeID AND Køn = 'K';
    RETURN vAntalKvinder / vTotalAntalDeltagere * 100;
END //


CREATE PROCEDURE TilmeldDeltagerOgTildelStartNr (IN vEmail VARCHAR(35), IN vForeningsID VARCHAR(10), 
IN vDato DATE, IN vEventTypeID VARCHAR(35))
BEGIN
	DECLARE vmaxStartNr INT; 
	SELECT MAX(StartNr) INTO vmaxStartNr FROM Deltager
    WHERE ForeningsID = vForeningsID AND Dato = vDato AND EventTypeID = vEventTypeID;
    INSERT Deltager VALUES (vEmail, vForeningsID, vDato, vEventTypeID, (vmaxStartNr+1), null);
END //


CREATE PROCEDURE ÆndreEmail (IN vGammelEmail VARCHAR(35), IN vNyEmail VARCHAR(35))
BEGIN
	DECLARE vCount INT;
	SELECT COUNT(*) INTO vCount FROM Person WHERE Email = vNyEmail;
    IF vCount = 0 THEN
		START TRANSACTION;
		INSERT INTO Person
        SELECT vNyEmail, Fornavn, Efternavn, Adresse, Postnr, Fødselsdato, Køn FROM Person
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
SELECT Navn, TotalDeltagerAntalPrForening(ForeningsID) as TotalAntalEventDeltagere FROM Idrætsforening;
SELECT EventTypeID, ProcentKvinderPrEventType(EventTypeID) as ProcentAndelKvinder FROM Begivenhed;
CALL TilmeldDeltagerOgTildelStartNr('DanseMyggen@gmail.com','O', '20220330', 'MTB');
CALL ÆndreEmail('DanseMyggen@gmail.com', 'DanceMonkey@tones.com');
INSERT Person VALUES ('ikkegyldig.dk', 'Karen', 'Briansen', 'Briansvej','2860', '19900201', 'K');

SELECT * FROM Deltager;
SELECT * FROM Idrætsforening;
SELECT * FROM Begivenhed;
SELECT * FROM Person;
SELECT * FROM EventType;