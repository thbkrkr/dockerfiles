FROM alpine:3.8

RUN apk --no-cache add bash curl && \
	curl -sSL https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kubectl > /usr/local/bin/kubectl && \
	chmod +x /usr/local/bin/kubectl

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]