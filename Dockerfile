FROM ubuntu:14.04.2

MAINTAINER justinwatkinson justin.watkinson@gmail.com

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
    DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') && \
    CODENAME=$(lsb_release -cs) && \
    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" |  tee /etc/apt/sources.list.d/mesosphere.list

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends mesos && \
    apt-get -y remove zookeeper && \
    rm -r -f /etc/zookeeper && \
    apt-get -y autoremove && \
    apt-get -y clean

EXPOSE 5051

ADD mesos-slave-init.sh /etc/mesos/mesos-slave-init.sh

ENTRYPOINT /usr/sbin/mesos-slave
