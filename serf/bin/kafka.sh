#!/bin/bash -eu
#
# Send Kafka message.
#
# Usage: echo $msg | B=<brokerAddr> U=<user> P=<password> T=<topic> kafka.sh
#

IN=$(cat /dev/stdin)

msg() {
  local user=${1:-"?@$HOSTNAME"}
  echo '{
    "user":"'$user'",
    "message":"'$(base64 <<< "$IN" | tr -d '\n')'"
  }'
}

main() {
  [[ ${B:-""} == "" ]] && return 0
  local url="https://${B%:9093}:443/topic/$T?format=raw"
  nohup curl -su $U:$P "$url" -d "$(msg)" >> /tmp/kafka.log 2>&1
}

main "$@"
