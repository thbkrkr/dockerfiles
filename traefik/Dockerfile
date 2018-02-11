#
# docker build -t krkr/traefik .
#
FROM traefik:v1.5.0-alpine

COPY traefik.toml /etc/traefik/traefik.toml
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN mkdir -p /data

EXPOSE 80 8080

ENTRYPOINT ["/docker-entrypoint.sh"]

