FROM mesosphere/mesos-slave:1.0.0-2.0.89.ubuntu1404
MAINTAINER ohmystack <jiangjun1990@gmail.com>
LABEL description="Mesos Slave for running docker client"

RUN ln -s -f /lib/x86_64-linux-gnu/libdevmapper.so.1.02.1 /lib/x86_64-linux-gnu/libdevmapper.so.1.02

ADD https://get.docker.com/builds/Linux/x86_64/docker-1.10.3 /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker
