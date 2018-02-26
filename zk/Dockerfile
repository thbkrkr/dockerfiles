FROM alpine:3.7

RUN apk --no-cache add wget bash openjdk8=8.151.12-r0

ENV ZK_VERSION="3.4.11"
ENV ZK_DIR="zookeeper-${ZK_VERSION}" \
    ZK_HOME="/opt/zookeeper" \
    CLIENT_PORT=2181 \
    PEERS="" \
    NODE_ID=0 \
    JVM_FLAGS="-Xmx1G -Xms1G"

RUN wget -q http://www.eu.apache.org/dist/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz -O /tmp/zk.tgz && \
    mkdir -p /opt && tar -xzf /tmp/zk.tgz -C /opt && \
    mv /opt/${ZK_DIR} ${ZK_HOME} && \
    rm /tmp/zk.tgz && \
    mkdir $ZK_HOME/data && \
    chmod +x ${ZK_HOME}/bin/zkServer.sh

# 2181: client port
# 2888: peer port
# 3888: election port
EXPOSE 2181 2888 3888

VOLUME ["$ZK_HOME/data"]
WORKDIR ${ZK_HOME}

COPY zoo.cfg ${ZK_HOME}/conf/zoo.cfg
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["zkServer.sh", "start-foreground"]