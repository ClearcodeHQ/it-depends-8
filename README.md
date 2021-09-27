# IT Depends #8 CDC Workshop

## Prequisites

To run this workshop you need several tools installed:

1. The [Docker Engine](https://docs.docker.com/engine/install/)
1. The [Docker Compose](https://docs.docker.com/compose/install/)

## How to

### Run the application

```sh
# start all services defined in the docker-compose.yaml
docker-compose -f docker-compose.yaml up
```

### Connect to the database

Linux / macOS (bash):

```sh
docker-compose -f docker-compose.yaml exec postgres env PGOPTIONS="--search_path=campaigns" bash -c 'psql -U $POSTGRES_USER postgres'
```

### Consume messages from the Kafka topic

Linux / macOS (bash):

```sh
docker-compose -f docker-compose.yaml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic dbserver1.campaigns.customers
```

Windows (PowerShell):

```PowerShell
docker-compose -f docker-compose.yaml exec kafka /kafka/bin/kafka-console-consumer.sh `
    --bootstrap-server kafka:9092 `
    --from-beginning `
    --property print.key=true `
    --topic dbserver1.campaigns.customers
```

### List available Kafka topics

```sh
docker-compose -f docker-compose.yaml exec kafka /kafka/bin/kafka-topics.sh --bootstrap-server=kafka:9092 --list
```

### Add Debezium connector

Linux / macOS (bash):

```sh
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @connector-config.json
```

Windows (PowerShell):

```PowerShell
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @connector-config.json
```

### List DB connectors

Linux / macOS (bash):

```sh
curl -i -X GET -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/
```

Windows (PowerShell):

```PowerShell
curl -i -X GET -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/
```

## Useful documentation

* [Quick guide to psql / PostgreSQL](docs/psql.md)
* [Debezium](https://debezium.io/documentation/reference/1.6/index.html)
* [Debezium PostgreSQL connector](https://debezium.io/documentation/reference/1.6/connectors/postgresql.html)
* [Kafka](https://kafka.apache.org/)

## TODOs

1. DB diagram
1. Add connector curl command + Powershell?

## Acknowledgements

For the workshop we used the config files and images from the [Debezium Team Repositories](https://github.com/debezium). Cheers!
