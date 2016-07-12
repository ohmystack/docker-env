#!/bin/bash
set -o errexit

source env.sh

# Bootstrap ENVs
export BOOTSTRAP_SOCK=unix:///var/run/docker-bootstrap.sock
export BOOTSTRAP_PID=/var/run/docker-bootstrap.pid
export BOOTSTRAP_LOG=/var/log/docker-bootstrap.log

print_usage() {
	cat <<-EOF
	
	Usage:
	sudo ./docker-bootstrap install|uninstall|on|off|net|...

	Command Intro:
	  install - Run docker-bootstrap daemon, start etcd + flannel, config flannel
	  net - Get the subnet settings from flannel
	  off - Turn OFF the bootstrap suite (Stop all the components)
	  on - Turn ON the bootstrap suite (Start all the components)
	  stop-daemon - Stop bootstrap Docker Daemon
	  uninstall - Uninstall all the components (etcd + flannel), stop the docker-bootstrap daemon

	EOF
}


# -----------------
# A bootstrap Docker Daemon + etcd + flannel
# -----------------
start_daemon() {
	if [ ! -f "${BOOTSTRAP_PID}" ]; then
		echo " ... start bootstrap Docker daemon: ${BOOTSTRAP_PID}"
		docker daemon \
			-H ${BOOTSTRAP_SOCK} \
			-p ${BOOTSTRAP_PID} \
			--iptables=false \
			--ip-masq=false \
			--bridge=none \
			--exec-root=/var/run/docker-bootstrap \
			--graph=/var/lib/docker-bootstrap \
			2>${BOOTSTRAP_LOG} 1>/dev/null &
	fi
}

install_bootstrap() {
	# bootstap Docker daemon
	start_daemon
	# etcd
	echo " ... start etcd: http://${HOST_IP}:4001"
	docker-compose -H ${BOOTSTRAP_SOCK} -p ${PROJECT_NAME} -f compose/etcd/etcd.yml up -d
	sleep 2 && curl -X PUT -d 'value={ "Network": "10.1.0.0/16" }' "http://${HOST_IP}:4001/v2/keys/coreos.com/network/config" | python -mjson.tool
	# flannel
	echo " ... start flannel"
	docker-compose -H ${BOOTSTRAP_SOCK} -p ${PROJECT_NAME} -f compose/flannel/flannel.yml up -d
	sleep 2 && flannel_net_env
}

start_bootstrap() {
	start_daemon
	docker-compose -H ${BOOTSTRAP_SOCK} -p ${PROJECT_NAME} -f compose/etcd/etcd.yml up -d
	docker-compose -H ${BOOTSTRAP_SOCK} -p ${PROJECT_NAME} -f compose/flannel/flannel.yml up -d
}

stop_bootstrap() {
	docker-compose -H ${BOOTSTRAP_SOCK} -p ${PROJECT_NAME} -f compose/flannel/flannel.yml stop
	docker-compose -H ${BOOTSTRAP_SOCK} -p ${PROJECT_NAME} -f compose/etcd/etcd.yml stop
}

stop_docker_daemon() {
	kill $(cat ${BOOTSTRAP_PID})
}

uninstall_bootstrap() {
	stop_bootstrap
	docker-compose -H ${BOOTSTRAP_SOCK} -p ${PROJECT_NAME} -f compose/flannel/flannel.yml rm -v
	docker-compose -H ${BOOTSTRAP_SOCK} -p ${PROJECT_NAME} -f compose/etcd/etcd.yml rm -v
	stop_docker_daemon
}


# -----------------
# Flannel
# -----------------
flannel_net_env() {
	docker -H ${BOOTSTRAP_SOCK} exec ${PROJECT_NAME}_flannel_1 cat /run/flannel/subnet.env
}


if [ -n $1 ]; then
	case $1 in
		'help'|'-h'|'--help')
			print_usage
			;;
		'install')
			install_bootstrap
			;;
		'uninstall')
			uninstall_bootstrap
			;;
		'on')
			start_bootstrap
			;;
		'off')
			stop_bootstrap
			;;
		'stop-daemon')
			stop_docker_daemon
			;;
		'net')
			flannel_net_env
			;;
		*)
			docker -H $BOOTSTRAP_SOCK "$@"
			;;
	esac
fi
