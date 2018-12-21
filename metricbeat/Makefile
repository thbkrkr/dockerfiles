NAME 	:= krkr/metricbeat
VERSION := $(shell curl -s "https://api.github.com/repos/elastic/beats/releases/latest" | jq -r .tag_name | sed "s/v//")

run: build
	docker rm -f metricbeat 2>/dev/null || return 0
	docker run -d \
		--name=metricbeat \
		--env-file=env \
		--net=host \
		--mount type=bind,source=/proc,target=/hostfs/proc,readonly \
		--mount type=bind,source=/sys/fs/cgroup,target=/hostfs/sys/fs/cgroup,readonly \
		--mount type=bind,source=/,target=/hostfs,readonly \
		--restart=always \
		$(NAME) -system.hostfs=/hostfs

build:
	docker build -t $(NAME) --build-arg VERSION=$(VERSION) .

setup-dashb: build
	docker run --rm \
		--env-file=env \
		krkr/metricbeat setup --dashboards
