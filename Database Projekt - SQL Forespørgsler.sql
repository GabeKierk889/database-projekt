SELECT Eventtypeid as Eventtype, Fornavn, Efternavn, Køn, timestampdiff(year, Fødselsdato, curdate()) AS Alder, Resultat
FROM Deltager NATURAL JOIN Person NATURAL JOIN aldersklasse a
WHERE EventtypeID = '10km' AND timestampdiff(year, Fødselsdato, curdate()) >= a.FraAlder 
AND timestampdiff(year, Fødselsdato, curdate()) <= a.TilAlder AND a.Fraalder = 30 AND køn = 'K'
ORDER BY Resultat ASC
LIMIT 10;

SELECT Fornavn, Efternavn, EventtypeID as Eventtype, Resultat
FROM Deltager NATURAL JOIN Person
WHERE Fornavn= 'Karen' AND Efternavn= 'Briansen' AND dato='2022-02-02' AND EventtypeID='10km' AND ForeningsID = 'ua';

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