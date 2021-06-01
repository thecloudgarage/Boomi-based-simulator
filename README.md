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
<br />

## Outcome matters

Outputs of the process run.

### Warm up: Disk as a target connection

Iterative flat files created by the process iteratively. Each flat file has a latitude, longitude, temperature and date/time that was iteratively built via a single seed value.

![image](https://user-images.githubusercontent.com/39495790/120259918-7ce0b300-c2b2-11eb-9409-fb9d798c8259.png)


Last file (notice 109.9953 as the latitude, our threshold is set at 110)

> After this the decision shape in the process observes a false as the latitude value has increased beyond the 110 threshold set (note the value 110.9178)

<br />

![image](https://user-images.githubusercontent.com/39495790/120228410-a8d74680-c268-11eb-89a4-beaf0b791654.png)

<br />

> In this case, I am dumping the data via disk connector as a bunch of flatfiles. These alternatively can be built as records and pushed through the different connectors available in their own profile formats.

<br />

### Actual use-case: MQTT as target connection (using eclipse mosquitto docker image as broker and mosquitto_sub as the client)

Herein, we move away from disk being a target connection to a MQTT connector

![image](https://user-images.githubusercontent.com/39495790/120230483-079ebf00-c26d-11eb-9eae-42a7208f2faf.png)

<br />

## Cut the chase!

<br />

### Trial 1 with Disk as target connector
![image](https://user-images.githubusercontent.com/39495790/120229116-1afc5b00-c26a-11eb-89d3-c3bd5c21ad02.png)

<br />

### Trial 2 with MQTT as target connector
![image](https://user-images.githubusercontent.com/39495790/120230398-d2926c80-c26c-11eb-84b0-7fe7e35994bf.png)

The process remains the same with the only difference being in the last connector, which is now a MQTT connector

<br />

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
temperatureoutput = temperatureinput + Math.random() -  Math.random() ;
}
```

Alternative method to temperature as a whole number (not used in this example., just for reference)
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

<br />

### Step-1 Seed message shape

We use the message shape to seed a message in a flatfile format. This will be iterated by the map shape and the function embedded in it.

![image](https://user-images.githubusercontent.com/39495790/120261602-d7c7d980-c2b5-11eb-80a2-91e600c3efa4.png)

You can copy the below in to the message shape. Alternatively if you change any of the column headers, the map definitions and function will need to be re-aligned.

```
latitude,longitude,temperature
100.0001,90.0001,30.00
```
<br />

### Step-2 input-output-profile for the map function

Within the map, we will place a function to iterate seed data. The function will be supported via input and output profile that will be passed via the function.

<br />

Create a csv file on your laptop with the following contents.
```
newLatitude,newLongitude,newTemperature,newDateTime
100.0000,90.0000,30.0000,20210530 090053.989
```
<br />

Create a new flatfile profile and configure the options as seen below

![image](https://user-images.githubusercontent.com/39495790/120261574-ca125400-c2b5-11eb-9d65-8e8d2d2119d9.png)

<br />

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

### Disk connector is a straightforward affair (so skipping to document)

### MQTT as target

> Prerequiste: a ubuntu 18.04 machine with docker installed

```
sudo su
mkdir eclipse-mosquitto && cd eclipse-mosquitto && mkdir 
```




