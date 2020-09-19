# https://hub.docker.com/r/arm32v7/debian
FROM arm32v7/debian:buster-20200908-slim
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y --no-install-recommends ca-certificates stubby dnsutils
COPY stubby.yml /etc/stubby/

EXPOSE 53/tcp 53/udp

CMD ["/bin/sh", "-c", "/usr/bin/stubby -v 0 -C /etc/stubby/stubby.yml"]
