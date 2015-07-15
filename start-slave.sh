#!/bin/bash

#start the machine (currently will error if it already exists)
docker-machine create -d virtualbox --virtualbox-memory "1024" --virtualbox-disk-size "10000" mesos-slave1

#set up docker environment for compose
eval $(docker-machine env mesos-slave1)

#Check for DOCKER_HOST and Eval the correct docker machine before running.
docker-compose --f mesos-slave-compose.yml up -d --x-smart-recreate
