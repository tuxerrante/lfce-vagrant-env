#!/bin/bash

if [[ -n "$1" ]]; then
    echo "Please invoke the script with the provider: bash up_exam.sh [docker|vbox]"
elif [[ "$1" = "docker" ]]; then
    echo Swarm Init...
    sudo docker swarm init --listen-addr 10.0.0.100:2377 --advertise-addr 10.100.199.200:2377
    sudo docker swarm join-token --quiet worker > vagrant/worker_token
fi

cd "$1" || exit 1
vagrant up

ssh-add -q files/insecure_private_key
ssh -A -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 2221 vagrant@localhost

cd ..