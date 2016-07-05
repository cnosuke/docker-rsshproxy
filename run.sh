#!/bin/bash

echo 'Setting up authorized_keys...' \
  && ruby set_up_authorized_keys.rb \
  && echo 'Creating host keys...' \
  && ssh-keygen -t rsa  -N '' -f /etc/ssh/ssh_host_rsa_key \
  && ssh-keygen -t dsa  -N '' -f /etc/ssh/ssh_host_dsa_key \
  && ssh-keygen -t dsa  -N '' -f /etc/ssh/ssh_host_ecdsa_key \
  && ssh-keygen -t dsa  -N '' -f /etc/ssh/ssh_host_ed25519_key \
  && echo 'Starting sshd...' \
  && /usr/sbin/sshd -D
