ARG NGINX_IMAGE_VERSION
FROM nginx:${NGINX_IMAGE_VERSION}

LABEL maintainer="Niklas Kaaf <nkaaf@protonmail.com>"
LABEL maintainer_github="https://github.com/nkaaf"
LABEL github_repo="https://github.com/nkaaf/nginx-letsencrypt-certification-management"

ARG SCRIPTS_PATH=/usr/local/share/scripts
ENV _scripts_dir=${SCRIPTS_PATH}

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/certbot.conf /etc/nginx/certbot.conf

COPY nginx/scripts ${SCRIPTS_PATH}
COPY scripts/common ${SCRIPTS_PATH}/common

WORKDIR ${SCRIPTS_PATH}

# Used by build_nginx_conf.sh
ARG CERTBOT_WEBROOT
ARG HTTP_PORT

RUN apk add --no-cache bash \
    && apk add --no-cache --virtual .build-deps openssl \
    # https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/TechnischeRichtlinien/TR02102/BSI-TR-02102-2.pdf?__blob=publicationFile&v=2#page=17
    ## DH 3000 Bit: 2029+
    && openssl dhparam -out /etc/nginx/ssl-dhparams.pem 3000 \
    && apk del .build-deps \
    && ./build_nginx_conf.sh
