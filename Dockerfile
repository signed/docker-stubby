# https://hub.docker.com/r/arm32v7/debian
FROM arm32v7/debian:buster-20200908-slim

RUN set -e -x && \
    debian_frontend=noninteractive apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates \
      stubby \
      ldnsutils && \
    groupadd --system stubby && \
    useradd --no-log-init --system --gid stubby stubby && \
    rm -rf \
      /tmp/* \
      /var/tmp/* \
      /var/lib/apt/lists/*

COPY stubby.yml /etc/stubby/
WORKDIR /home/stubby

EXPOSE 8053/udp

USER stubby:stubby

# 0: EMERG  - System is unusable
# 1: ALERT  - Action must be taken immediately
# 2: CRIT   - Critical conditions
# 3: ERROR  - Error conditions
# 4: WARN   - Warning conditions
# 5: NOTICE - Normal, but significant, condition
# 6: INFO   - Informational message
# 7: DEBUG  - Debug-level message
ENV LOG_LEVEL=4

CMD ["/bin/sh", "-c", "/usr/bin/stubby -v $LOG_LEVEL -C /etc/stubby/stubby.yml"]
