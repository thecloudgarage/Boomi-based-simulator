# A simulation tool using Boomi

## Objective
Build a process on top of Boomi integration that can serve as a simulator and testing tool for various purposes (mqtt/database/kafka/http, etc.)

> special thanks to Chris Cappetta https://github.com/ccappetta and Premjit Mishra from Boomi who have always helped get the better of the platform!

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
int intValue = 5;
for ( int i = 0; i <= intValue; i++) {
Thread.sleep(5000);
Calendar cal = Calendar.getInstance();
DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd HHmmss.SSS");
datetimeoutput = dateFormat.format(cal.getTime());
latitudeoutput = latitudeinput + Math.random();
longitudeoutput = longitudeinput + Math.random();
Random rnd = new Random();
temperatureoutput = temperatureinput + rnd.nextInt(2);
}
```
### Seed message shape

![image](https://user-images.githubusercontent.com/39495790/120224195-9b1dc300-c260-11eb-9a97-e698e8f58944.png)

### input-output-profile for the map function

Create a csv file on your laptop with the following contents.
```
newLatitude,newLongitude,newTemperature,newDateTime
100.0000,90.0000,30.0000,20210530 090053.989
```
Create a flatfile profile and configure the options as seen below

![image](https://user-images.githubusercontent.com/39495790/120222423-8ab81900-c25d-11eb-8b4f-98459d68bd12.png)

Import the flatfile created and edit the elements as seen below

![image](https://user-images.githubusercontent.com/39495790/120222692-fb5f3580-c25d-11eb-8842-fdccb99341d1.png)

![image](https://user-images.githubusercontent.com/39495790/120222727-0c0fab80-c25e-11eb-830e-59bdedefa3da.png)

Note the format for temperature has only two decimals instead of four for lat/long

![image](https://user-images.githubusercontent.com/39495790/120222802-2b0e3d80-c25e-11eb-84c2-f89c598be0c9.png)

Ensure the datetime format is as seen below

![image](https://user-images.githubusercontent.com/39495790/120222872-47aa7580-c25e-11eb-8654-73f7e9f9fb3c.png)

### Create the map function

On the input and output select the same profile created above (as we have loop back for iterative values)

![image](https://user-images.githubusercontent.com/39495790/120223141-bf78a000-c25e-11eb-905f-59cc74eea3d2.png)

Add a function of the type custom scripting and select groovy 2.4

![image](https://user-images.githubusercontent.com/39495790/120223210-dfa85f00-c25e-11eb-99f6-04e6d4a8f685.png)

Create the input and output parameters

> NOTE: The input parameters for latitudeinput, latitudeoutput, temperatureinput will of FLOAT type, else the function will not be able to parse decimal values

Copy/paste the above groovy script and save. Link the input values and output values as seen in the above figure and save

### Create a decision shape

![image](https://user-images.githubusercontent.com/39495790/120223560-61988800-c25f-11eb-8848-17344d120071.png)

For the first value, select profile element of newlatitude the flatfile profile created earlier (as shown below) and then on the seccond value, give a static value which we will use to break the loop

![image](https://user-images.githubusercontent.com/39495790/120223630-84c33780-c25f-11eb-939c-6d160f9e4874.png)

 ### Create a Branch
 
 Branch-1 will go the respective target connector
 Branch-2 will loop back to the start of the map (as seen in the diagram)
 
 ![image](https://user-images.githubusercontent.com/39495790/120223901-f4392700-c25f-11eb-9235-a03bb0c58278.png)

### Decision (true or false)

Link decision true to the branch and false to a stop shape (deselect "continue processing....")



