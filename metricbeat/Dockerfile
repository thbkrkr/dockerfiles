ARG VERSION
FROM docker.elastic.co/beats/metricbeat:$VERSION
COPY metricbeat.yml /usr/share/metricbeat/metricbeat.yml
USER root
RUN chown root:metricbeat /usr/share/metricbeat/metricbeat.yml
RUN chmod go-w /usr/share/metricbeat/metricbeat.yml
USER metricbeat