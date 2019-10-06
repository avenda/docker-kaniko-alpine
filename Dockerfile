FROM gcr.io/kaniko-project/executor:debug-v0.13.0 as kaniko

FROM alpine:3.10.2

RUN apk update && \
  apk upgrade && \
  apk add --no-cache \
    bash \
    git \
    openssh-client \
    jq

COPY --from=kaniko /kaniko /kaniko

ENV PATH=/kaniko:$PATH
ENV DOCKER_CONFIG='/kaniko/.docker'
ENV DOCKER_CREDENTIAL_GCR_CONFIG=/kaniko/.config/gcloud/docker_credential_gcr_config.json
ENV SSL_CERT_DIR=/kaniko/ssl/certs

ENTRYPOINT ["/kaniko/executor"]
