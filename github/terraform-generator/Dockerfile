FROM alpine:3.12.1 as run

LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="Terraform generator"
LABEL "com.github.actions.description"="Generates terraform code that calls terraform module"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="blue"

ADD https://apk.cloudposse.com/ops@cloudposse.com.rsa.pub /etc/apk/keys/
RUN echo "@cloudposse https://apk.cloudposse.com/3.11/vendor" >> /etc/apk/repositories

RUN apk add -u \
				git \
				variant2@cloudposse \
				go-jsonnet@cloudposse==0.17.0-r0

# Build the CLI
WORKDIR /usr/cli
ENV VARIANT_DIR /usr/cli
COPY ./ ./
ENTRYPOINT [ "/usr/cli/main.variant" ]
