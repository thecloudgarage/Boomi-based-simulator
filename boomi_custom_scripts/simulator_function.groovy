import java.util.Properties;
import java.text.DateFormat;
import java.util.GregorianCalendar;
import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat
import java.io.InputStream;
int intValue = 2;
for ( int i = 0; i <= intValue; i++) {
Thread.sleep(2000);
gpsterminalidoutput = gpsterminalidinput;
latitudeoutput = latitudeinput + Math.random();
longitudeoutput = longitudeinput + Math.random();
temperatureoutput = temperatureinput + Math.random() -  Math.random();
fueloutput = fuelinput -  Math.random();
Calendar cal = Calendar.getInstance();
DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd HHmmss.SSS");
datetimeoutput = dateFormat.format(cal.getTime());
}
