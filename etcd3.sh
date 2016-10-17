#!/bin/bash

source env.sh

print_usage() {
	cat <<-EOF
	
	Usage:
	sudo ./etcd3.sh up|start|restart|stop|kill|rm|logs

	EOF
}

c::up() {
  docker-compose -p ${PROJECT_NAME} -f compose/etcd3/etcd3.yml up -d
}

c::start() {
  docker-compose -p ${PROJECT_NAME} -f compose/etcd3/etcd3.yml start
}

c::restart() {
  docker-compose -p ${PROJECT_NAME} -f compose/etcd3/etcd3.yml restart
}

c::stop() {
  docker-compose -p ${PROJECT_NAME} -f compose/etcd3/etcd3.yml stop
}

c::kill() {
  docker-compose -p ${PROJECT_NAME} -f compose/etcd3/etcd3.yml kill
}

c::rm() {
  docker-compose -p ${PROJECT_NAME} -f compose/etcd3/etcd3.yml rm -v
}

c::logs() {
  docker-compose -p ${PROJECT_NAME} -f compose/etcd3/etcd3.yml logs --tail=50 -f
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
