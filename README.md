# kafka-manager

- [yahoo/kafka-manager](https://github.com/yahoo/kafka-manager)
- [sheepkiller/kafka-manager-docker](https://github.com/sheepkiller/kafka-manager-docker)

## Dockerfile

```Dockerfile
FROM openjdk:8-jre-alpine

RUN apk add --no-cache bash

ENV ZK_HOSTS=localhost:2181 \
    KM_VERSION=1.3.3.21 \
    KM_CONFIGFILE="conf/application.conf"

COPY . /kafka-manager-${KM_VERSION}

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000

ENTRYPOINT ["./bin/kafka-manager"]
```

## docker-compose.yml

```yml
version: '2.4'
services:
  zoo:
    image: zookeeper:latest
    restart: always
    container_name: zoo
    hostname: zoo
    ports:
      - 2181:2181
    environment:
      ZOO_MY_ID: 1
      ZOO_SERVERS: server.1=0.0.0.0:2888:3888

  kafka:
    image: wurstmeister/kafka:latest
    restart: always
    container_name: kafka
    hostname: kafka
    ports:
      - 9092:9092
      - 9192:9192
    environment:
      KAFKA_ADVERTISED_HOST_NAME: <HOSTIP?
      KAFKA_ZOOKEEPER_CONNECT: zoo:2181
      JMX_PORT: 9192
      KAFKA_JMX_OPTS: "-Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=kafka -Djava.net.preferIPv4Stack=true"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock

  manager:
    image: rurumimic/kafka-manager:latest
    restart: always
    container_name: manager
    hostname: manager
    ports:
      - 9000:9000
    environment:
      ZK_HOSTS: "zoo:2181"
```
