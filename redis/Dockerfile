FROM redis:4.0.2-alpine

RUN apk --no-cache add bash
ADD config/redis.conf /etc/redis.conf
ADD bin /usr/local/bin

CMD ["docker-entrypoint.sh"]