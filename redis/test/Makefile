run:
	docker-compose up

info:
	redis-cli -p 7001 cluster nodes
	redis-cli -p 7002 cluster nodes
	redis-cli -p 7003 cluster nodes
	redis-cli -p 7011 cluster nodes
	redis-cli -p 7012 cluster nodes
	redis-cli -p 7013 cluster nodes

create-cluster:
	docker run --rm -ti --net=host \
		krkr/redis-trib create --replicas 1 \
			127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 \
			127.0.0.1:7011 127.0.0.1:7012 127.0.0.1:7013
