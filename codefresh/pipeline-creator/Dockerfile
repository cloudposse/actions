FROM codefresh/cli:0.75.16

LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="Create Codefresh pipelines"
LABEL "com.github.actions.description"="GitHub action that creates Codefresh pipelines"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="green"

RUN	apk add --no-cache \
	gomplate \
	git

COPY entrypoint.sh /

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
