FROM alpine:3.13

LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="CRUD"
LABEL "com.github.actions.description"="Synchronize Github workflows to a repository"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /

RUN chmod 755 /entrypoint.sh \
  && apk --no-cache add bash git

ENTRYPOINT ["/entrypoint.sh"]
