package IndlaesPersonerOgTilmeldinger;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Tilmelding {
    private final String foreningsId;
    private final String eventTypeId;
    private final Date eventDate;

    public Tilmelding(String foreningsId, String eventTypeId, Date eventDate) {
        this.foreningsId = foreningsId;
        this.eventTypeId = eventTypeId;
        this.eventDate = eventDate;
    }

    public String getForeningsId() {
        return foreningsId;
    }

    public String getEventTypeId() {
        return eventTypeId;
    }

    public Date getEventDate() {
        return eventDate;
    }
    @Override
    public String toString() {
        final String D = ";";
        final SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");

        return getForeningsId() +D +getEventTypeId() +D +dateFormatter.format(getEventDate());
    }

}