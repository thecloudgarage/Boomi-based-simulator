We will be creating one connector between ES and KAFKA per topic. Open the kafka connect UI from portainer. Create a new connector and click on JSON. 

Copy and paste the below

1st connector
```
{    "connector.class":"io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",    "tasks.max": "1",    "topics": "delhi",    "key.ignore":"true",    "schema.ignore": "true",    "connection.url": "http://elasticsearch:9200",    "type.name": "delhi", "name":"delhi"  }
```

2nd connector
```
{    "connector.class":"io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",    "tasks.max": "1",    "topics": "maharashtra",    "key.ignore":"true",    "schema.ignore": "true",    "connection.url": "http://elasticsearch:9200",    "type.name": "maharashtra", "name":"maharashtra"  }
```

3rd connector
```
{    "connector.class":"io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",    "tasks.max": "1",    "topics": "karnataka",    "key.ignore":"true",    "schema.ignore": "true",    "connection.url": "http://elasticsearch:9200",    "type.name": "karnataka", "name":"karnataka"  }
```

4th connector
```
{    "connector.class":"io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",    "tasks.max": "1",    "topics": "tamilnadu",    "key.ignore":"true",    "schema.ignore": "true",    "connection.url": "http://elasticsearch:9200",    "type.name": "tamilnadu", "name":"tamilnadu"  }
```
