#!/bin/bash
set -o errexit

source env.sh

# Kubernetes ENVs
export K8S_APISERVER_IP=${HOST_IP}
export K8S_APISERVER_PORT=8080
export K8S_CLUSTER_CIDR="10.3.0.0/16"
# K8S_DNS_SERVER_IP should be the IP of the host who is running the kube-dns and dnsmasq
export K8S_DNS_SERVER_IP=$HOST_IP
export K8S_DNS_DOMAIN="k8s.local."

print_usage() {
	cat <<-EOF
	
	Usage:
	sudo ./k8s up|start|restart|stop|kill|rm|logs|first-run

	Special Command Intro:
	  first-run - Do some patch, please restart k8s after doing this

	EOF
}

pre_run() {
	./etcd3.sh up
	mkdir -p /etc/kubernetes/manifests
}

# Run after api-server ready
first_run() {
	# Create the kube-system namespace
	curl -H "Content-Type: application/json" -XPOST -d '{"apiVersion":"v1","kind":"Namespace","metadata":{"name":"kube-system"}}' "http://${HOST_IP}:${K8S_APISERVER_PORT}/api/v1/namespaces"
}

c::up() {
	pre_run
	docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-node.yml up -d
}

c::start() {
	pre_run
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-node.yml start
}

c::restart() {
	pre_run
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-node.yml restart
}

c::stop() {
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-node.yml stop
}

c::kill() {
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-node.yml kill
}

c::rm() {
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-node.yml rm -v
}

c::logs() {
  docker-compose -p ${PROJECT_NAME} -f compose/k8s/kube-master.yml -f compose/k8s/kube-node.yml logs --tail=50 -f
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
		'first-run')
			first_run
			break
			;;
		*)
			print_usage
			break
			;;
	esac
	shift
done
