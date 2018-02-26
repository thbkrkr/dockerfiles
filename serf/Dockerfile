FROM alpine:3.6
RUN apk --no-cache add curl bash jq && \
    curl -sSL https://releases.hashicorp.com/serf/0.8.1/serf_0.8.1_linux_amd64.zip > serf.zip && \
    unzip serf.zip && mv serf /usr/local/bin && rm serf.zip && \
    curl -sSL https://github.com/thbkrkr/qli/releases/download/0.2.3/oq \
    > /usr/local/bin/oq && chmod +x /usr/local/bin/oq
COPY bin /usr/local/bin
COPY handlers /etc/serf/handlers
ENTRYPOINT ["start.sh"]
