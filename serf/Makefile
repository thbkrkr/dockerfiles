all: up scale join logs

up:
	docker-compose up -d

scale:
	docker-compose scale agent=5

ip:
	docker exec serf_agent_1 get-ip.sh

join-n1:
	docker exec serf_agent_2 serf join serf.n1.blurb.space:7944
join-n2:
	docker exec serf_agent_3 serf join serf.n2.blurb.space:7944

join: ip
	docker exec serf_agent_2 serf join $$(docker exec serf_agent_1 get-ip.sh)
	docker exec serf_agent_3 serf join $$(docker exec serf_agent_1 get-ip.sh)
	docker exec serf_agent_4 serf join $$(docker exec serf_agent_1 get-ip.sh)
	docker exec serf_agent_5 serf join $$(docker exec serf_agent_1 get-ip.sh)

members:
	@docker run --rm --net=host krkr/serf members --format=json \
		-rpc-addr=$$(docker exec serf_agent_1 get-ip.sh):7373 \
	| jq -c '.members[] | {n:.name, a:.addr, t:.tags}'

ping:
	docker run --rm --net=host krkr/serf event -rpc-addr=$$(docker exec serf_agent_1 get-ip.sh):7373 ping

debug:
	docker run --rm --net=host krkr/serf event -rpc-addr=$$(docker exec serf_agent_1 get-ip.sh):7373 debug


uptime:
	docker run --rm --net=host krkr/serf query --format=json -rpc-addr=$$(docker exec serf_agent_1 get-ip.sh):7373 uptime

sys:
	docker run --rm --net=host krkr/serf query --format=json -rpc-addr=$$(docker exec serf_agent_1 get-ip.sh):7373 sys


logs:
	docker-compose logs -f
