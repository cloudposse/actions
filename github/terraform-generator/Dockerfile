ARG CLI_NAME=terraform-generator

FROM alpine:3.12.1 as build

ADD https://apk.cloudposse.com/ops@cloudposse.com.rsa.pub /etc/apk/keys/
RUN echo "@cloudposse https://apk.cloudposse.com/3.11/vendor" >> /etc/apk/repositories

RUN apk add -u \
				libc-dev \
				bash \
				go \
				git \
				variant2@cloudposse \
				direnv@cloudposse==2.21.2-r0

# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

# Build a minimal variant binary in order to download all the required libraries and save them in a Docker layer cache
RUN mkdir -p /tmp/build-cache
ADD https://raw.githubusercontent.com/cloudposse/atmos/master/example/cli/build-cache/build-cache.variant /tmp/build-cache/build-cache.variant
WORKDIR /tmp/build-cache
RUN variant2 export binary $PWD variant-echo

RUN apk add go-jsonnet@cloudposse==0.17.0-r0


# Build the CLI
WORKDIR /usr/cli
COPY ./ ./

ARG CGO_ENABLED=1
ARG CLI_NAME
RUN variant2 export binary $PWD $CLI_NAME

# Verify the CLI
RUN ./"$CLI_NAME" help


# -------------------- Test Image -----------------------------------------

FROM build as test

RUN apk --no-cache add coreutils ncurses curl bats

ENV LIBS_BATS_MOCK_VERSION="1.3.0" \
    LIBS_BATS_SUPPORT_VERSION="0.3.0" \
    LIBS_BATS_ASSERT_VERSION="0.3.0" \
    LIB_BATS_FILE_VERSION="0.2.0"

# Install bats-support
RUN mkdir -p /usr/local/lib/bats/bats-support \
    && curl -sSL https://github.com/ztombol/bats-support/archive/v${LIBS_BATS_SUPPORT_VERSION}.tar.gz -o /tmp/bats-support.tgz \
    && tar -zxf /tmp/bats-support.tgz -C /usr/local/lib/bats/bats-support --strip 1 \
    && printf 'source "%s"\n' "/usr/local/lib/bats/bats-support/load.bash" >> /usr/local/lib/bats/load.bash \
    && rm -rf /tmp/bats-support.tgz

# Install bats-assert
RUN mkdir -p /usr/local/lib/bats/bats-assert \
    && curl -sSL https://github.com/ztombol/bats-assert/archive/v${LIBS_BATS_ASSERT_VERSION}.tar.gz -o /tmp/bats-assert.tgz \
    && tar -zxf /tmp/bats-assert.tgz -C /usr/local/lib/bats/bats-assert --strip 1 \
    && printf 'source "%s"\n' "/usr/local/lib/bats/bats-assert/load.bash" >> /usr/local/lib/bats/load.bash \
    && rm -rf /tmp/bats-assert.tgz

# Install lox's fork of bats-mock
RUN mkdir -p /usr/local/lib/bats/bats-mock \
    && curl -sSL https://github.com/lox/bats-mock/archive/v${LIBS_BATS_MOCK_VERSION}.tar.gz -o /tmp/bats-mock.tgz \
    && tar -zxf /tmp/bats-mock.tgz -C /usr/local/lib/bats/bats-mock --strip 1 \
    && printf 'source "%s"\n' "/usr/local/lib/bats/bats-mock/stub.bash" >> /usr/local/lib/bats/load.bash \
    && rm -rf /tmp/bats-mock.tgz

# Install bats-file
RUN mkdir -p /usr/local/lib/bats/bats-file \
    && curl -sSL https://github.com/ztombol/bats-file/archive/v${LIB_BATS_FILE_VERSION}.tar.gz -o /tmp/bats-file.tgz \
    && tar -zxf /tmp/bats-file.tgz -C /usr/local/lib/bats/bats-file --strip 1 \
    && printf 'source "%s"\n' "/usr/local/lib/bats/bats-file/load.bash" >> /usr/local/lib/bats/load.bash \
    && rm -rf /tmp/bats-file.tgz

# Expose BATS_PATH so people can easily use load.bash
ENV BATS_PATH=/usr/local/lib/bats

WORKDIR /bin

ENTRYPOINT ["bats"]
CMD ["tests/"]

# -------------------- Run Image -----------------------------------------

FROM alpine:3.10 as run

LABEL maintainer="Cloud Posse <hello@cloudposse.com>"

LABEL "com.github.actions.name"="Terraform generator"
LABEL "com.github.actions.description"="Generates terraform code that calls terraform module"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="blue"

ADD https://apk.cloudposse.com/ops@cloudposse.com.rsa.pub /etc/apk/keys/
RUN echo "@cloudposse https://apk.cloudposse.com/3.11/vendor" >> /etc/apk/repositories

RUN apk add	go-jsonnet@cloudposse==0.17.0-r0

# Install CLI
ARG CLI_NAME
COPY --from=build /usr/cli/ /usr/cli/

WORKDIR /usr/cli
ENTRYPOINT [ "/usr/cli/terraform-generator" ]
