SELECT Fornavn, Efternavn, Køn, timestampdiff(year, Fødselsdato, curdate()) AS Alder, Resultat
FROM Deltager NATURAL JOIN Person
WHERE EventtypeID = '10km'
ORDER BY Resultat DESC
LIMIT 10;

SELECT Fornavn, Efternavn, Resultat
FROM Deltager NATURAL JOIN Person
WHERE Fornavn= 'Karen' AND Efternavn= 'Briansen' AND dato='2022-02-02' AND EventtypeID='10km';

SELECT Fornavn, Efternavn, Køn, EventTypeID, Resultat
FROM Deltager NATURAL JOIN Person
WHERE EventTypeID = 'MTB'
ORDER BY Resultat;

SELECT Fornavn, Efternavn, ForeningsID
FROM Deltager NATURAL JOIN Person
ORDER BY ForeningsID
LIMIT 3;  

SELECT EventTypeID, AVG(timestampdiff(year, Fødselsdato, curdate())) AS AvgAlder, AVG(Resultat) / 100 AS AvgResultat
FROM Person NATURAL JOIN Deltager
WHERE EventTypeID = '10km'
ORDER BY Resultat;

SELECT *
FROM Deltager LEFT JOIN Person
ON Deltager.Resultat = Person.Køn
ORDER BY Resultat;

