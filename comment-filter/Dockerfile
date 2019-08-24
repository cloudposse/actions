FROM alpine:3.10
LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="GitHub Comment Filter"
LABEL "com.github.actions.description"="Only continue when comment matched"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="blue"

RUN	apk add --no-cache \
	bash \
	grep \
	jq

COPY entrypoint.sh /

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
