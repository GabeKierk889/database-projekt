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