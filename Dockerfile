FROM docker.io/mariadb:10.6.13@sha256:37e9f7e3cea0096f7fba9d2a77cf0ac926c830e8931d1679da3bcd8fb8989d47

LABEL maintainer="ownCloud GmbH"
LABEL org.opencontainers.image.authors="ownCloud GmbH"
LABEL org.opencontainers.image.title="MariaDB"
LABEL org.opencontainers.image.url="https://github.com/owncloud-ops/mariadb"
LABEL org.opencontainers.image.source="https://github.com/owncloud-ops/mariadb"
LABEL org.opencontainers.image.documentation="https://github.com/owncloud-ops/mariadb"

ARG GOMPLATE_VERSION
ARG CONTAINER_LIBRARY_VERSION

# renovate: datasource=github-releases depName=hairyhenderson/gomplate
ENV GOMPLATE_VERSION="${GOMPLATE_VERSION:-v3.11.5}"
# renovate: datasource=github-releases depName=owncloud-ops/container-library
ENV CONTAINER_LIBRARY_VERSION="${CONTAINER_LIBRARY_VERSION:-v0.1.0}"

USER 0

ADD overlay/ /

RUN apt-get update && apt-get install -y wget curl gnupg2 apt-transport-https ca-certificates && \
    curl -SsfL -o /usr/local/bin/gomplate "https://github.com/hairyhenderson/gomplate/releases/download/${GOMPLATE_VERSION}/gomplate_linux-amd64-slim" && \
    curl -SsfL "https://github.com/owncloud-ops/container-library/releases/download/${CONTAINER_LIBRARY_VERSION}/container-library.tar.gz" | tar xz -C / && \
    chmod 755 /usr/local/bin/gomplate && \
    mkdir -p /var/lib/mysql/ && \
    mkdir -p /var/lib/backup/ && \
    chown -R mysql:mysql /var/lib/mysql/ && \
    chown -R mysql:mysql /var/lib/backup/ && \
    chown mysql:root /etc/mysql/my.cnf && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

VOLUME /var/lib/mysql

EXPOSE 3306

USER mysql

ENTRYPOINT ["/usr/bin/entrypoint", "server"]
HEALTHCHECK --interval=15s --timeout=5s --retries=10 CMD /usr/bin/healthcheck --connect
WORKDIR /var/lib/mysql
CMD []
