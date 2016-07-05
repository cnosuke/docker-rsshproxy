FROM ruby:2.3-alpine
MAINTAINER cnosuke

RUN apk update \
    && apk add --no-cache bash openssh

ADD sshd_config /etc/ssh/sshd_config
ADD run.sh .
ADD set_up_authorized_keys.rb .

RUN mkdir /root/.ssh/ && touch /root/.ssh/authorized_keys

EXPOSE 22

CMD ["./run.sh"]
