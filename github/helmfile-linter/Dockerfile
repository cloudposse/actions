FROM alpine:3.10

LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="Helmfile Linter"
LABEL "com.github.actions.description"="Check All Helmfiles for Errors"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="blue"

RUN	apk add --no-cache \
	bash \
	ca-certificates \
	curl \
	jq \
	git

WORKDIR /

RUN curl https://github.com/roboll/helmfile/releases/download/v0.137.0/helmfile_linux_amd64 && \
chmod 764 helmfile_linux_amd64

COPY entrypoint.sh /

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
