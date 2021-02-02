FROM golang:1.15-buster

LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="Build"
LABEL "com.github.actions.description"="Build Go Binaries"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
