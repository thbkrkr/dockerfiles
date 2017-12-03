FROM elasticsearch:2

RUN \
    plugin install lmenezes/elasticsearch-kopf/v2.1.1 && \
    plugin install mobz/elasticsearch-head

COPY elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
