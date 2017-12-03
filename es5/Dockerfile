FROM elasticsearch:5

RUN \
    elasticsearch-plugin install https://github.com/lmenezes/elasticsearch-kopf/archive/v2.1.1.zip \
    && \
    elasticsearch-plugin install https://github.com/mobz/elasticsearch-head/archive/master.zip && \
    bin/elasticsearch-plugin install x-pack

COPY elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
