#!/bin/bash

source env.sh

# Ceph ENVs
export CEPH_CLUSTER=ceph

print_usage() {
	cat <<-EOF
	
	Usage:
	sudo ./ceph.sh up|start|restart|stop|kill|rm|logs|uninstall

	Special Command Intro:
	  uninstall - Clean the local files, nor new ceph monitor will fail to run

	EOF
}

uninstall_ceph_demo() {
	rm -rf /var/lib/ceph/mon
	find /etc/ceph -name "${CEPH_CLUSTER}\.*" | xargs -t -I '{}' rm -f '{}'
}

c::up() {
  docker-compose -p ${PROJECT_NAME} -f compose/ceph/ceph-demo.yml up -d
}

c::start() {
  docker-compose -p ${PROJECT_NAME} -f compose/ceph/ceph-demo.yml start
}

c::restart() {
  docker-compose -p ${PROJECT_NAME} -f compose/ceph/ceph-demo.yml restart
}

c::stop() {
  docker-compose -p ${PROJECT_NAME} -f compose/ceph/ceph-demo.yml stop
}

c::kill() {
  docker-compose -p ${PROJECT_NAME} -f compose/ceph/ceph-demo.yml kill
}

c::rm() {
  docker-compose -p ${PROJECT_NAME} -f compose/ceph/ceph-demo.yml rm -v
}

c::logs() {
  docker-compose -p ${PROJECT_NAME} -f compose/ceph/ceph-demo.yml logs --tail=50 -f
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
		'uninstall')
			c::stop
			c::rm
			uninstall_ceph_demo
			break
			;;
		*)
			print_usage
			break
			;;
	esac
	shift
done
