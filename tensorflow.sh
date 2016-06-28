#!/bin/bash

source env.sh

print_usage() {
	cat <<-EOF
	
	Usage:
	sudo ./tensorflow.sh up|start|restart|stop|kill|rm|logs

	EOF
}

c::up() {
  docker-compose -p ${PROJECT_NAME} -f compose/tensorflow/tensorflow.yml up -d
}

c::start() {
  docker-compose -p ${PROJECT_NAME} -f compose/tensorflow/tensorflow.yml start
}

c::restart() {
  docker-compose -p ${PROJECT_NAME} -f compose/tensorflow/tensorflow.yml restart
}

c::stop() {
  docker-compose -p ${PROJECT_NAME} -f compose/tensorflow/tensorflow.yml stop
}

c::kill() {
  docker-compose -p ${PROJECT_NAME} -f compose/tensorflow/tensorflow.yml kill
}

c::rm() {
  docker-compose -p ${PROJECT_NAME} -f compose/tensorflow/tensorflow.yml rm -v
}

c::logs() {
  docker-compose -p ${PROJECT_NAME} -f compose/tensorflow/tensorflow.yml logs --tail=50 -f
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
