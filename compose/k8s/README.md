# Kubernetes

## Setup docker-bootstrap & etcd & flannel

### Install

```bash
sudo ./docker-bootstrap.sh install
```

Config Docker Daemon:

> Modify:
> 
> * Systemd: `/usr/lib/systemd/system/docker.service`
> * Upstart: `/etc/init/docker.conf`

Add `DOCKER_OPTS="--bip=10.1.88.1/24 --mtu=1472"` to systemd/upstart script.

Restart Docker service.

### Run

```bash
sudo ./docker-bootstrap.sh on
```
