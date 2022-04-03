/**
 * Denne klasse håndterer indlæsning af datafil.
 * 
 *  Klassen er en del af projektopgaven på Kursus F21 02327 F22
 *  Version 1.0
 * 
 * @author Thorbjørn Konstantinovitz  
 *
 */
package IndlaesPersonerOgTilmeldinger;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Scanner;

public class IndlaesPersonerOgTilmeldinger {

	public static final String SEMICOLON_DELIMITER = ";";
	public static final String COMMA_DELIMITER = ",";
	private static final int NUMBER_OF_FIELDS_EXPECTED = 8;
	private final String delimiter = SEMICOLON_DELIMITER;
	SimpleDateFormat dateParser = new SimpleDateFormat("yyyyMMdd");

	/**
	 * Denne metode indlæser en datafil med personer og tilmeldinder og returnerer en liste med PersonOgTilmelding objekter der repræsenterer indholdet i filen.
	 * @param filename filnavn på den fil der skal indlæses (inkl. sti hvis nødvendigt)
	 * @return List indeholdende PersonOgTilmelding objekter
	 * @throws FileNotFoundException, IOException
	 */
	public List<PersonOgTilmelding> indlaesPersonerOgTilmeldinger(String filename) throws FileNotFoundException, IOException {
		List<PersonOgTilmelding> poaList = new ArrayList<PersonOgTilmelding>();
		
		BufferedReader in = null;
		try {
			in = new BufferedReader(new FileReader(filename));

		    String line;
		    int lineNbr = 0;
		    while ((line = in.readLine()) != null) {
		    	lineNbr++;
		    	List<String> values = new ArrayList<String>();
		    	try (Scanner rowScanner = new Scanner(line)) {
		    	    rowScanner.useDelimiter(delimiter);
		    	    while (rowScanner.hasNext()) {
		    	        values.add(rowScanner.next());
		    	    }
					if(values.size() == 0)
						continue;
					if(values.size() == 7 || values.size() == 8) {
						String email = values.get(0);
						String fornavn = values.get(1);
						String efternavn = values.get(2);
						String koen = values.get(3);
						Date foedselsdato = null;
						try {
							foedselsdato = dateParser.parse(values.get(4));
						} catch (ParseException e) {
							throw new NumberFormatException("Ugyldig værdi (" + values.get(4) + ") for fødselsdato på linie " + lineNbr);
						}

						String foreningsId = values.get(5).trim().length() > 0 ? values.get(5).trim() : null;
						String eventTypeId = values.get(6).trim().length() > 0 ? values.get(6).trim() : null;
						Date eventDato = null;
						if (values.size() == 8 && values.get(7) != null && values.get(7).trim().length() > 0)
							try {
								eventDato = dateParser.parse(values.get(7));
							} catch (ParseException e) {
								throw new NumberFormatException("Ugyldig værdi (" + values.get(7) + ") for event dato på linie " + lineNbr);
							}

						PersonOgTilmelding poa = new PersonOgTilmelding(email, fornavn, efternavn, koen, foedselsdato, foreningsId, eventTypeId, eventDato);
						poaList.add(poa);
					} else
						throw new IOException("Ugyldigt antal værdier på linie " +lineNbr +". Forventede " +NUMBER_OF_FIELDS_EXPECTED +" værdier, læste " +values.size());
		    	}
		    }
		} finally {
			if(in != null)
				try { in.close(); } catch(Exception e) { /* Ignore */ };
		}
		
		return poaList;
	}
}