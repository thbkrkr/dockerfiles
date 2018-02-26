#!/bin/bash -eu
#
# Handle Serf events.
#

IN=$(cat /dev/stdin)
OUT=""

export PLUGIN_PATH="/etc/serf/handlers"
export HANDLER_DIR="/etc/serf/handlers"


main() {
  local event=""
  case $SERF_EVENT in
    user)  event="user-$SERF_USER_EVENT"  ;;
    query) event="query-$SERF_QUERY_NAME" ;;
    *)     event=$SERF_EVENT              ;;
  esac

  #pluginhook $EVENT

  local handler="$HANDLER_DIR/$event"
  if [ -f "$handler" -a -x "$handler" ]; then
    OUT=$(exec "$handler") || :
  fi

  function message() {
    echo $event':'
    [[ "$IN" != "" ]]  && echo "$IN"
    [[ "$OUT" != "" ]] && echo "$OUT"
  }

  local user="serf@$SERF_SELF_NAME.$SERF_TAG_GROUP.$SERF_TAG_CLUSTER"
  message | kafka.sh $user
}

main
