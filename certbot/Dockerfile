ARG CERTBOT_IMAGE_VERSION
FROM certbot/certbot:${CERTBOT_IMAGE_VERSION}

LABEL maintainer="Niklas Kaaf <nkaaf@protonmail.com>"
LABEL maintainer_github="https://github.com/nkaaf"
LABEL github_repo="https://github.com/nkaaf/nginx-letsencrypt-certification-management"

RUN apk add --no-cache bash

ARG SCRIPTS_PATH=/usr/local/share/scripts
ENV _scripts_dir=${SCRIPTS_PATH}
ARG CERTBOT_WEBROOT
ENV CERTBOT_WEBROOT=${CERTBOT_WEBROOT}

COPY certbot/scripts ${SCRIPTS_PATH}

COPY scripts/common ${SCRIPTS_PATH}/common

COPY certbot/configuration/cli.ini /etc/letsencrypt/cli.ini

WORKDIR ${SCRIPTS_PATH}

VOLUME ${CERTBOT_WEBROOT}