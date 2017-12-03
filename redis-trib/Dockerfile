FROM ruby:2.4.2-alpine3.6

RUN apk --no-cache add curl && \
    gem install redis && \
    curl -s https://raw.githubusercontent.com/antirez/redis/4.0/src/redis-trib.rb \
      > /usr/local/bin/redis-trib.rb && chmod +x /usr/local/bin/redis-trib.rb

ENTRYPOINT ["redis-trib.rb"]