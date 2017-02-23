# docker-env
Give you an **out-of-the-box** development environment.

(Powered by [Docker](https://www.docker.com/))

## Goal

- Just `up`. When you need a software/tool (MySQL, ZooKeeper, ...), or **even a cloud (Mesos, Kubernetes)**, just run a command `up`.

  > Out-of-the-box, no more configuration is needed before using.

- Easy upgrade. You can just modify the Docker image's tag, and `up` again. It's done.

  > No more need to change `apt/sources.list` or `yum.repos.d` and reinstall with unpredictable package conflicts.

- Quick development, **NOT for production.**

  > It is a convenient toolbox for quickly building up your development environment.
  > 
  > Production isn't this project's goal.
  > For example, Mesos needs more specific options for running in a production environment.
  > This project's maintainer will provide some individual repos for running tools in production later.


## Current Available Tools

- [MySQL](https://www.mysql.com/)
- [etcd & etcd3](https://coreos.com/etcd/)
- [Zookeeper](https://zookeeper.apache.org/)
- [Influxdb](https://influxdata.com/) + [Grafana](grafana.org/) + [cAdvisor](https://github.com/google/cadvisor) (Monitoring)
- [TensorFlow](https://www.tensorflow.org) (Machine Learning)
- [Ceph](http://ceph.com/)
- [NFS](http://www.tldp.org/LDP/nag/node140.html) (Please read this [guide](compose/nfs/README.md))
- *(More tools are coming soon...)*

Clouds:

- [Mesos](http://mesos.apache.org/) (Master + Slave) + [Marathon](https://mesosphere.github.io/marathon/)
- [Kubernetes](http://kubernetes.io/) (Please read this [guide](compose/k8s/README.md))


## Usage

> Please install `docker` and `docker-compose` first.

Our Command patten is simple:

```
sudo ./<tool-name>.sh [up|start|stop|kill|restart|rm|logs|...]
```

e.g.

```bash
# This will bring up a mini Mesos Cluster (Master+Slave+Marathon+Zookeeper)
sudo ./mesos.sh up

# Check out logs
sudo ./mesos.sh logs

# Stop the Mesos
sudo ./mesos.sh stop
```

Some tool, such as Mesos, may have some special commands, like `reconfig`.
You can dive into the bash script to figure out what it does.

## Questions

How can I know what port is used by a tool?

> The port configurations are in the docker compose file of each tool under `compose/`.

How to change the prefix name of those containers?

> edit `env.sh`, change the `PROJECT_NAME`
