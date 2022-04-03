package IndlaesPersonerOgTilmeldinger;
import java.io.IOException;
import java.util.List;

public class IndlaesDatafilEksempel {

	public static void main(String[] args) {
		IndlaesPersonerOgTilmeldinger laeser = new IndlaesPersonerOgTilmeldinger();
		try {
			List<PersonOgTilmelding> personerOgTilmeldinger = laeser.indlaesPersonerOgTilmeldinger("src/tilmeldinger.csv");
			for(PersonOgTilmelding personOgTilmelding : personerOgTilmeldinger) {
				System.out.print("Person: " +personOgTilmelding.getPerson());
				if(personOgTilmelding.getTilmelding() != null)
					System.out.println("\tTilmelding: " +personOgTilmelding.getTilmelding());
				else
					System.out.println("\t Ingen tilhørende tilmelding");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}


