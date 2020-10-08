FROM ruby:2.5-alpine
MAINTAINER cnosuke

ADD motd /etc/motd
RUN apk update \
    && apk add --no-cache bash openssh \
    && mkdir -p /staff/.ssh/ /setup \
    && touch /authorized_keys \
    && adduser -D --shell /sbin/nologin --disabled-password staff \
    && passwd -u staff \
    && chown staff:staff /authorized_keys

ADD . /setup
WORKDIR /setup

ENV HOST_KEYS /host_keys
ENV SSH_PORT 22

EXPOSE 22

CMD ["./run.sh"]
