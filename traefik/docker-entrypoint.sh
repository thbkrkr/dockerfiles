#!/bin/sh -eu

ACME_EMAIL=${ACME_EMAIL:-"me@mail.com"}
DOMAIN=${DOMAIN:-"docker.localhost"}
HTTPS_PORT=${HTTPS_PORT:-"443"}
HTTPS_REDIRECT=${HTTPS_REDIRECT:-true}
SWARM_MODE=${SWARM_MODE:-"false"}

sed -i \
  -e "s|{{ ACME_EMAIL }}|$ACME_EMAIL|" \
  -e "s|{{ HTTPS_PORT }}|$HTTPS_PORT|" \
  -e "s|{{ SWARM_MODE }}|$SWARM_MODE|" \
  /etc/traefik/traefik.toml
echo "http_port=$HTTPS_PORT swarm=$SWARM_MODE email=$ACME_EMAIL configured"

if [[ "$HTTPS_REDIRECT" != "true" ]]; then
  sed -i 's|defaultEntryPoints.*|defaultEntryPoints = ["http"]|' \
    /etc/traefik/traefik.toml
  sed -ie '/entryPoints.http.redirect/,+4d' \
    /etc/traefik/traefik.toml
  sed -ie '/acme/,+4d' \
    /etc/traefik/traefik.toml
fi

echo "Starting traefik..."
exec /usr/local/bin/traefik