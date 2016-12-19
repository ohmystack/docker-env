#!/bin/bash

source env.sh

# NFS ENVs
export NFS_SHARE_DIR=/data/nfs

print_usage() {
	cat <<-EOF
	
	Usage:
	sudo ./nfs.sh up|start|restart|stop|kill|rm|logs

	EOF
}

print_status() {
	echo " ... start sharing: $NFS_SHARE_DIR"
}

c::up() {
  docker-compose -p ${PROJECT_NAME} -f compose/nfs/server.yml	up -d
	print_status
}

c::start() {
  docker-compose -p ${PROJECT_NAME} -f compose/nfs/server.yml	start
	print_status
}

c::restart() {
  docker-compose -p ${PROJECT_NAME} -f compose/nfs/server.yml	restart
	print_status
}

c::stop() {
  docker-compose -p ${PROJECT_NAME} -f compose/nfs/server.yml	stop
}

c::kill() {
  docker-compose -p ${PROJECT_NAME} -f compose/nfs/server.yml	kill
}

c::rm() {
  docker-compose -p ${PROJECT_NAME} -f compose/nfs/server.yml	rm -v
}

c::logs() {
  docker-compose -p ${PROJECT_NAME} -f compose/nfs/server.yml	logs --tail=50 -f
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
