# Kubernetes

## Overview

```plain
    kubernetes/
    ├── kubectl
    ├── master
    │   ├── etcd
    │   ├── flanneld
    │   ├── kube-apiserver
    │   ├── kube-controller-manager
    │   └── kube-scheduler
    └── node
        ├── flanneld
        ├── kubelet
        └── kube-proxy
```

## Setup docker-bootstrap & etcd & flannel

### Install

```bash
sudo ./docker-bootstrap.sh install
```

Config Docker Daemon:

#### If you are using **systemd**

> Edit `/usr/lib/systemd/system/docker.service`

Add the following line in `[Service]` block:

```plain
EnvironmentFile=-/run/flannel/subnet.env
```

Add parameters in `ExecStart`:

```plain
--bip=${FLANNEL_SUBNET} --mtu=${FLANNEL_MTU}
```

Restart Docker service.

#### If you are using **Upstart**

> Edit: `/etc/init/docker.conf`

Find the `script` block, which has `exec "$DOCKER" daemon $DOCKER_OPTS --raw-logs`, add/modify the following lines in that block:

```plain
	. /run/flannel/subnet.env
	DOCKER_OPTS="--bip=${FLANNEL_SUBNET} --mtu=${FLANNEL_MTU}"
```

Restart Docker service.

### Run

```bash
sudo ./docker-bootstrap.sh on
```
