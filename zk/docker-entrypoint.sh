#!/bin/bash -eu

ZOO_ID=${ZOO_ID:-1}
MAX_CLIENT_CNXNS=${MAX_CLIENT_CNXNS:-200}
CLIENT_PORT=${CLIENT_PORT:-2181}
ZOO_PEERS=${ZOO_PEERS:-""}

ZK_HOME=${ZK_HOME:-""}
ZOO_CFG=${ZK_HOME}/conf/zoo.cfg

main() {
  # Make sure ZK_HOME is defined
  if [ -z "$ZK_HOME" ]; then
    echo '$ZK_HOME must be set. Exiting.'
    exit 1
  fi

  # Set Java env
  echo 'export JVMFLAGS="'$JVM_FLAGS'"' > conf/java.env

  # Set node id
  echo $ZOO_ID > ${ZK_HOME}/data/myid

  # Set dataDir and clientPort
  sed  -i \
    -e "s|dataDir=.*|dataDir=$ZK_HOME/data|g" \
    -e "s|clientPort=.*|clientPort=${CLIENT_PORT}|g" \
    -e "s|maxClientCnxns=.*|maxClientCnxns=${MAX_CLIENT_CNXNS}|g" \
    $ZOO_CFG

  #  Set peers
  IFS=","
  for peer in $ZOO_PEERS; do
    echo "server.$peer" >> $ZOO_CFG
  done

  exec "$@"
}

main