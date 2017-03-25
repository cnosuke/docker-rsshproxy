#!/bin/bash

echo 'Setting up authorized_keys...' \
  && ruby set_up_authorized_keys.rb \
  && echo 'Creating host keys...' \
  && ruby set_up_ssh_host_keys.rb \
  && echo 'Creating sshd_config...' \
  && erb sshd_config.erb > /etc/ssh/sshd_config \
  && echo 'Starting sshd...' \
  && /usr/sbin/sshd -D
