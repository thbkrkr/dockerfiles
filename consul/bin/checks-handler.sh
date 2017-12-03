#!/bin/bash -eu
#
# Handler called when a check state is changing (passing/critical).
#

# Read input
#[ $# -ge 1 -a -f "${1:-"-"}" ] && input="$1" || input="-"
json=$(cat /dev/stdin)


# {
#   "Node": "o8f5xfy9xdpmzy5iux6xwzwcz",
#   "Name": "check jenkins",
#   "Status": "OK",
#   "Output": "check_http OK url=https://jenkins.blurb.space status=403 agent=o8f5xfy9xdpmzy5iux6xwzwcz",
#   "Timestamp": "1506286248",
#   "Kind": "check",
#   "Service": "jenkins"
# }
events() {
  jq -cM '.[] |
    . + {
      "Timestamp":"'$(date +%s)'",
      "Kind":"check",
      "Service":.ServiceID,
    } |
    if .Service=="" then .Service=.CheckID else . end |
    if .Status=="passing" then .Status="OK" else . end |
    if .Status=="critical" then .Status="KO" else . end |
    .Name="check "+.Service |
    del(.CheckID,.Notes,.ServiceID,.ServiceName,.ServiceTags)
  ' \
  <<< $json
}

kafka:pub() {
  [[ "${B:-}" == "" ]] && return

  echo "$@" | oq
}

es:pub() {
  [[ "${EVENTS_API:-}" == "" ]] && return

  curl -s -XPUT "$EVENTS_API/$(uuidgen)" -d "$@"
}

toctoc() {
  [[ "${TOCTOC_URL:-}" == "" ]] && return

  curl -s -XPOST "$TOCTOC_URL" -d "$@"
}

uuidgen() {
  cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 32 | head -1
}

main() {
  declare uuid=$(uuidgen)
  #echo "$json" > /tmp/debug.events-$uuid.json

  events | while read event; do
    echo "$event"
    kafka:pub "$event" &
    es:pub "$event"    &
    toctoc "$event"    &
  done
  wait
}

main "$json"
