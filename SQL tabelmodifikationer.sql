SELECT * FROM Person;

# Karen får et mellemnavn
UPDATE Person SET Fornavn='Karen Smuksak' WHERE Email='DanseMyggen@gmail.com';

# Familien Briansen flytter til Nygade
UPDATE Person SET Adresse='Nygade',PostNr=1515 WHERE Efternavn='Briansen';

# Pga. flytning har Karen skiftet til en idrætsforening, som ikke er med i databasen
DELETE FROM Person WHERE Email='DanseMyggen@gmail.com';
