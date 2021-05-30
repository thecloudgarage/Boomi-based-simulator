# A simulation tool using Boomi

## Objective
Build a process on top of Boomi integration that can serve as a simulator and testing tool for various purposes (mqtt/database/kafka/http, etc.)

## Project inspiration

![image](https://user-images.githubusercontent.com/39495790/120115476-6e56a680-c1a1-11eb-8978-618b2158ac6d.png)

The inspiration for this project came due to a need for IOT testing tool, which can feature as a MQTT publisher. 

> While that being the case-in-point, I landed up in building this as a generic one that can be extended to diversified simulation testing needs.

The nature of my immediate testing involved generation of incremental lat/long/temperature data and publishing it to a MQTT broker. With this pursuit, I ended up paho and experimenting with mqtt cli tools. However, the level of complexity in building an automated data set and then automating the publishing was too high.

## Boomi to the rescue
Boomi Integration service provides a rich featurette of connectors and integration logic inclusive of custom scripting, etc. I decided to take advantage of Boomi Integration to build a simulation tool instead of leveraging docker/linux/windows tools.
This helped me further as my target processes that need to be tested via simulation were deployed on Boomi itself

## Outcome matters

10 flat files created by the process iteratively. Each flat file has a latitude, longitude, temperature and date/time that was iteratively built via a single seed value.

![image](https://user-images.githubusercontent.com/39495790/120113248-3e0a0a80-c197-11eb-9211-13e636f2ea9b.png)

First file (notice 101 is the latitude which is a result of 1 being added to seed value of 100)

![image](https://user-images.githubusercontent.com/39495790/120113327-904b2b80-c197-11eb-8eee-d389226b1335.png)

Last file (notice 110 as the latitude., at this point the decision shape takes charge and breaks the loop to complete the process)

![image](https://user-images.githubusercontent.com/39495790/120113356-bd97d980-c197-11eb-8340-74a015e91681.png)

> In this case, I am dumping the data via disk connector as a bunch of flatfiles. These alternatively can be built as records and pushed through the different connectors available in their own profile formats.

## Cut the chase

![image](https://user-images.githubusercontent.com/39495790/120114138-64ca4000-c19b-11eb-9ea8-ca0f8a118928.png)


## The magic of GROOVY!!!

This is the main function that runs inside of the map to incrementally generate data points. Thanks to Boomi., groovy custom scripts extend the low code platform in to a powerful beast..

```
import java.util.Properties;
import java.text.DateFormat;
import java.util.GregorianCalendar;
import java.util.Calendar;
import java.util.Date;
import java.text.SimpleDateFormat
import java.io.InputStream;
// Specify the length of time to wait in seconds.

// Leave the rest of the script as-is to pass the Documents to the next step.
int intValue = 5;
for ( int i = 0; i <= intValue; i++) {
Thread.sleep(5000);
Calendar cal = Calendar.getInstance();
DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd HHmmss.SSS");
datetimeoutput = dateFormat.format(cal.getTime());
latitudeoutput = latitudeinput + 1;
longitudeoutput = longitudeinput + 1;
temperatureoutput = temperatureinput + 1;
}
```
