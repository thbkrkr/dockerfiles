FROM consul:0.8.5

RUN apk --update add bash jq \
    nagios-plugins nagios-plugins-disk

RUN curl -sSL https://github.com/thbkrkr/tcping/releases/download/0.0.1/tcping > /usr/local/bin/tcping && \
    chmod +x /usr/local/bin/tcping && \
    curl -sSL https://github.com/thbkrkr/qli/releases/download/0.2.3/oq > /usr/local/bin/oq && \
    chmod +x /usr/local/bin/oq

ENV CONFIG_DIR /consul/config
COPY config $CONFIG_DIR
COPY bin /usr/local/bin
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]