#!/bin/bash

source env.sh

print_usage() {
	cat <<-EOF
	
	Usage:
	sudo ./mesos.sh up|start|restart|reconfig|stop|kill|rm|logs

	EOF
}

c::up() {
  docker-compose -p ${PROJECT_NAME} -f compose/mesos/mesos.yml -f compose/zookeeper/zookeeper.yml up -d
}

c::start() {
  docker-compose -p ${PROJECT_NAME} -f compose/mesos/mesos.yml -f compose/zookeeper/zookeeper.yml start
}

c::restart() {
  docker-compose -p ${PROJECT_NAME} -f compose/mesos/mesos.yml restart
}

c::reconfig() {
  c::stop && rm -f /tmp/mesos_slave/meta/slaves/latest && c::up
}

c::stop() {
  docker-compose -p ${PROJECT_NAME} -f compose/mesos/mesos.yml stop
}

c::kill() {
  docker-compose -p ${PROJECT_NAME} -f compose/mesos/mesos.yml kill
}

c::rm() {
  docker-compose -p ${PROJECT_NAME} -f compose/mesos/mesos.yml rm -v
}

c::logs() {
  docker-compose -p ${PROJECT_NAME} -f compose/mesos/mesos.yml logs --tail=50 -f
}

while [ -n $1 ]; do
	case $1 in
		'up') c::up
			break
			;;
		'start') c::start
			break
			;;
		'restart') c::restart
			break
			;;
		'reconfig') c::reconfig
			break
			;;
		'stop') c::stop
			break
			;;
		'kill') c::kill
			break
			;;
		'rm') c::rm
			break
			;;
		'logs') c::logs
			break
			;;
		*)
			print_usage
			break
			;;
	esac
	shift
done
