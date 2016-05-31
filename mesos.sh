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
  c::stop && rm -f ${MESOS_SLAVE_WORK_DIR}/meta/slaves/latest && c::up
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
			;;
		'start') c::start
			;;
		'restart') c::restart
			;;
		'reconfig') c::reconfig
			;;
		'stop') c::stop
			;;
		'kill') c::kill
			;;
		'rm') c::rm
			;;
		'logs') c::logs
			;;
		*)
			print_usage
			break
			;;
	esac
	shift
done
