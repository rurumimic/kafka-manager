FROM openjdk:8-jre-alpine

RUN apk add --no-cache bash

ENV ZK_HOSTS=localhost:2181 \
    KM_VERSION=1.3.3.21 \
    KM_CONFIGFILE="conf/application.conf"

COPY . /kafka-manager-${KM_VERSION}

WORKDIR /kafka-manager-${KM_VERSION}

EXPOSE 9000

ENTRYPOINT ["./bin/kafka-manager"]
