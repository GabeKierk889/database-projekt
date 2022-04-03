import IndlaesPersonerOgTilmeldinger.*;

import java.io.IOException;
import java.util.List;

public class Tidsmaskinen {
    public static void main(String[] args) {
        IndlaesPersonerOgTilmeldinger laeser = new IndlaesPersonerOgTilmeldinger();
        Database db= new Database();
        try {
            List<PersonOgTilmelding> list = laeser.indlaesPersonerOgTilmeldinger("src/tilmeldinger.csv");

            for(PersonOgTilmelding data: list){
                Person person= data.getPerson();
                Tilmelding begivenhed = data.getTilmelding();

                if(person != null) {
                    boolean personExist = db.checkPerson(person.getEmail());

                    if (personExist == false) {
                        db.createPerson(person);
                    }
                }

                if(begivenhed != null) {
                    boolean idraetsforningExist = db.checkIdraetsforening(begivenhed.getForeningsId());
                    boolean begivenhedExist = db.checkBegivenhed(begivenhed);

                    if (idraetsforningExist == false) {
                        db.createIdraetsforening(begivenhed.getForeningsId());
                    }

                    if (begivenhedExist == false) {
                        db.createBegivenhed(begivenhed);
                    }
                }

                if (person != null && begivenhed != null ) {
                    db.createDeltager(person, begivenhed);
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
