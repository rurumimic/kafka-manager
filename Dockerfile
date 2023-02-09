FROM adoptopenjdk/openjdk11:alpine-slim

RUN apk add --no-cache bash

ENV ZK_HOSTS=localhost:2181 \
    KM_VERSION=3.0.0.6 \
    KM_CONFIGFILE="conf/application.conf"

COPY . /cmak

WORKDIR /cmak

EXPOSE 9000

ENTRYPOINT ["./cmak/bin/cmak"]
