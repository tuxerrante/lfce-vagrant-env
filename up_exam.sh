#!/bin/bash

vagrant up --provider=docker

ssh-add -q files/insecure_private_key
ssh -A -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2221 vagrant@localhost