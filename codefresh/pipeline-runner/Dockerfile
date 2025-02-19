FROM codefresh/cli:1.0.53

LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="Run Codefresh pipeline"
LABEL "com.github.actions.description"="GitHub action that runs Codefresh pipeline"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="green"

COPY entrypoint.sh /

RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
