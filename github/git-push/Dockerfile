FROM alpine:3.10

LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="Git Push"
LABEL "com.github.actions.description"="Push Changes to Origin"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="blue"

RUN	apk add --no-cache \
	bash \
	ca-certificates \
	curl \
	jq \
	git

COPY entrypoint.sh /

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
