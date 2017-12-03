#!/bin/bash -eu

REDIS_CONF=/etc/redis.conf

extract_name() {
  cut -d '=' -f1 <<< $1 \
    | sed -e "s|^redis-||"
}

configure() {
  declare var=$1
  local val=$(cut -d '=' -f2 <<< $var)
  local name=$(extract_name $var)
  local regexp='^[# ]*'$name' .*'

  if [[ "$(grep -c "$regexp" $REDIS_CONF)" != "1" ]]; then
    echo "$var doesn't match exactly once '$name'"
    grep "$regexp" $REDIS_CONF
    exit 1
  fi

  sed -e "s|$regexp|$name $val|" -i $REDIS_CONF
  echo "[configure] $name $val"
}

while read envvar; do
  configure "$envvar"
done < <(env | grep '^redis-')

case ${1:-""} in
  "")
    exec redis-server $REDIS_CONF ;;
  *)
    $@ ;;
esac
