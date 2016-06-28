# docker-env
Give you a pure and clean development environment out-of-the-box.

(Powered by [Docker](https://www.docker.com/))

## Goal

- When you need a software/tool (MySQL, Mesos, ...), just run a command `up`.

One-click, out-of-the-box, no more configuration is needed before using.

- When you want to try a newer version of a software, you just modify the Docker image's tag, and `up` again. It's done.

No more need to change `apt/sources.list` or `yum.repos.d` and reinstall with unpredictable package conflicts.

- For quick development, **NOT for production.**

> It is a convenient toolbox for quickly building up your development environment.
> 
> Production isn't this project's goal.
> For example, Mesos needs more specific options for running in a production environment.
> This project's maintainer will provide some individual repos for running tools in production later.


## Current Supported Tools

- MySQL
- Zookeeper
- Mesos (Master + Slave) + Marathon
- cAdvisor
- Influxdb + Grafana + cAdvisor (Monitoring containers)
- Kubernetes (AllInOne, NOTE: still in incubator)
- [TensorFlow](https://www.tensorflow.org) (Machine Learning)
- *(More tools are coming soon...)*


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
