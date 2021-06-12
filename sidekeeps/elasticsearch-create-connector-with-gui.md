Once you verify that KAFKA is receiving traffic and the topics have been automatically created (key is that topics are created)

Open the Kafka Connect UI and click NEW then select ELASTICSEARCH

![image](https://user-images.githubusercontent.com/39495790/121776349-fd07f200-cba9-11eb-943c-373a448bcf2e.png)

![image](https://user-images.githubusercontent.com/39495790/121776406-56702100-cbaa-11eb-971c-a16931e55d01.png)

Select JSON and **DELETE** the existing JSON content

![image](https://user-images.githubusercontent.com/39495790/121776443-7d2e5780-cbaa-11eb-87a7-8d67a6fe316d.png)

**AFTER DELETING EXISTING JSON., PASTE** the below JSON and then once the message "Kafka connect configuration is correct"...click on CREATE

```
{    "connector.class":"io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",    "tasks.max": "1",    "topics": "gps",    "key.ignore":"true",    "schema.ignore": "true",    "connection.url": "http://elasticsearch:9200",    "type.name": "gps", "name":"gps"  }
```
![image](https://user-images.githubusercontent.com/39495790/121776575-47d63980-cbab-11eb-899f-03073e0c740b.png)

You will return to the dashboard and see the connector

![image](https://user-images.githubusercontent.com/39495790/121776634-9388e300-cbab-11eb-8089-6b6dcf0dc923.png)
