#!/bin/bash
set -o errexit

source env.sh

# Kubernetes ENVs
export K8S_APISERVER_PORT=8080
export K8S_CLUSTER_CIDR="10.3.0.0/16"

print_usage() {
	cat <<-EOF
	
	Usage:
	sudo ./k8s up|start|restart|stop|kill|rm|logs

	EOF
}

pre_run() {
	mkdir -p /etc/kubernetes/manifests
}

c::up() {
	pre_run
	docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-minion.yml up -d
}

c::start() {
	pre_run
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-minion.yml start
}

c::restart() {
	pre_run
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-minion.yml restart
}

c::stop() {
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-minion.yml stop
}

c::kill() {
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-minion.yml kill
}

c::rm() {
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-minion.yml rm -v
}

c::logs() {
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-minion.yml logs --tail=50 -f
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
