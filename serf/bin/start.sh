#!/bin/bash -eu
#
# Serf start script that runs the agent or execute a command
#

SERF_NODE=${SERF_NODE:-$HOSTNAME}
SERF_BIND=${SERF_BIND:-$(get-ip.sh)}
SERF_RPC_ADDR=${SERF_RPC_ADDR:-"0.0.0.0:7373"}
SERF_AUTH_KEY=${SERF_AUTH_KEY:-"none"}
SERF_ROLE=${SERF_ROLE:-"none"}
SERF_TAG=${SERF_TAG:-"none"}
SERF_CLUSTER=${SERF_CLUSTER:-"none"}

start_agent() {
  declare options=""
  if [[ $SERF_AUTH_KEY != "none" ]]; then
    options="-encrypt=$SERF_AUTH_KEY"
  fi
  if [[ $SERF_TAG != "none" ]]; then
    for tag in $SERF_TAG; do
      options="$options -tag $tag"
    done
  fi

  mkdir -p /data
  touch /data/snapshot

  echo "Starting serf agent -node=$SERF_NODE -bind=$SERF_BIND"
  exec serf agent \
    -node=$SERF_NODE \
    -bind=$SERF_BIND \
    -rpc-addr=$SERF_RPC_ADDR \
    -event-handler "handler.sh" \
    -snapshot /snapshot \
    -broadcast-timeout 20s \
    $options
    -log-level=debug
}

main() {
  case ${1:-"start"} in
    start) start_agent    ;;
    *)     exec serf "$@" ;;
  esac
}

main "$@"