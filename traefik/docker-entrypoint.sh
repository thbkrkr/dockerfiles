#!/bin/sh -eu

DNS_PROVIDER=${DNS_PROVIDER:-"ovh"}
DOMAIN=${DOMAIN:-"docker.localhost"}
ACME_EMAIL=${ACME_EMAIL:-"me@mail.com"}
HTTPS_PORT=${HTTPS_PORT:-"443"}
HTTPS_REDIRECT=${HTTPS_REDIRECT:-true}
SWARM_MODE=${SWARM_MODE:-"false"}

sed -i \
  -e "s|{{ HTTPS_PORT }}|$HTTPS_PORT|g" \
  -e "s|{{ ACME_EMAIL }}|$ACME_EMAIL|g" \
  -e "s|{{ DOMAIN }}|$DOMAIN|g" \
  -e "s|{{ DNS_PROVIDER }}|$DNS_PROVIDER|g" \
  -e "s|{{ SWARM_MODE }}|$SWARM_MODE|g" \
  /etc/traefik/traefik.toml

echo "http_port=$HTTPS_PORT email=$ACME_EMAIL domain=$DOMAIN swarm=$SWARM_MODE configured"

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