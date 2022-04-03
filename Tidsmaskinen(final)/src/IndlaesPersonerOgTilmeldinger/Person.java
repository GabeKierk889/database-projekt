package IndlaesPersonerOgTilmeldinger;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Person {
    private final String email;
    private final String fornavn;
    private final String efternavn;
    private final String koen;
    private final Date foedselsdato;

    public Person(String email, String fornavn, String efternavn, String koen, Date foedselsdato) {
        this.email = email;
        this.fornavn = fornavn;
        this.efternavn = efternavn;
        this.koen = koen;
        this.foedselsdato = foedselsdato;
    }

    public String getEmail() {
        return email;
    }

    public String getFornavn() {
        return fornavn;
    }

    public String getEfternavn() {
        return efternavn;
    }

    public String getKoen() {
        return koen;
    }

    public Date getFoedselsdato() {
        return foedselsdato;
    }



    @Override
    public String toString() {
        final String D = ";";
        final SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");

        return getEmail() +D +getFornavn() +D +getEfternavn() +D +getKoen() +D +dateFormatter.format(getFoedselsdato());
    }
}

