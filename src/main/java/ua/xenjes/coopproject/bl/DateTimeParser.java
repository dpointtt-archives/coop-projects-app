package ua.xenjes.coopproject.bl;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DateTimeParser {

    private static final SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

    public static Timestamp dateTime(String datetime) throws ParseException {
        String parsedString = datetime.replace("T", " ") + ":00.000";
        return new Timestamp(simpleDateFormat.parse(parsedString).getTime());
    }

    public static String dateTimeString(Timestamp datetime) throws ParseException {
        String dateTime = datetime.toString();
        String parsedString1 = dateTime.replace(" ", "T");
        return parsedString1.replace(":00.000", "");
    }

}
