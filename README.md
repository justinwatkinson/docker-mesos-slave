# docker-mesos-slave
Used to deploy a mesos-slave using Docker

## Important Info
This is very far from complete!  This is by no means ready for prime time in any system, just a playground for some stuff I've been working at home to POC Mesos, but simplifying the architecture by containerizing everything - from Mesos to frameworks to helper tools.

Note:  192.168.99.100 is the docker-machine IP for my mesos-master, and .101 is my mesos-slave-1.  This will be enhanced later to dynamically replace, or better yet, use libnetwork!  All of these images are also available in Docker Hub.

## Starting the container with Docker Compose

Currently doing this test using docker-machine and compose.  You should be able to use the start-slave.sh if you already have docker-machine installed to create a VM.  This is intended to be used in conjunction with my mesos-master docker-machine/compose set up.  You should be able to continually use this script to launch.  I know it has an error if the docker machine already exists - known issue, focusing on other stuff at the moment.

Starting using Docker Compose:

    ./start-slave.sh

Docker Compose is still a little strange when you use it with a custom file.  Not all command may work.  Use at your own risk.  I've been testing against the busybox Boot2Docker docker-machine image with this setup quite successfully.

## Starting the container manually (no compose)

Example syntax for starting this container:

    docker run -d \
    --net=host \
    --privileged \
    -e MESOS_HOSTNAME=192.168.99.101 \
    -e MESOS_IP=192.168.99.101 \
    -e MESOS_WORK_DIR=/var/mesos \
    -e MESOS_LOG_DIR=/var/log \
    -e MESOS_MASTER=zk://192.168.99.100:2181/mesos \
    -e MESOS_CONTAINERIZERS=docker,mesos \
    -e MESOS_EXECUTOR_REGISTRATION_TIMEOUT=5mins \
    -p 5051:5051 \
    -v /sys:/sys \
    -v /usr/bin/docker:/usr/bin/docker:ro \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /lib64/libdevmapper.so.1.02:/lib/libdevmapper.so.1.02:ro \
    justinwatkinson/mesos-slave
