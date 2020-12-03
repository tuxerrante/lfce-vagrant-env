#!/bin/bash

vagrant up --provision-with docker

ssh-add -q files/insecure_private_key
ssh -A -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2221 vagrant@localhost