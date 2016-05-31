#!/bin/bash

source env.sh

c::up() {
  docker-compose -p oms -f compose/kubernetes/kubernetes.yml up -d
}

c::start() {
  docker-compose -p oms -f compose/kubernetes/kubernetes.yml start
}

c::stop() {
  docker-compose -p oms -f compose/kubernetes/kubernetes.yml stop
}

c::reconfig() {
  c::stop && c::up
}

c::kill() {
  docker-compose -p oms -f compose/kubernetes/kubernetes.yml kill
}

c::rm() {
  docker-compose -p oms -f compose/kubernetes/kubernetes.yml rm -v
}

while [ -n $1 ]; do
  case $1 in
    'up') c::up
      ;;
    'start') c::start
      ;;
    'stop') c::stop
      ;;
    'reconfig') c::reconfig
      ;;
    'kill') c::kill
      ;;
    'rm') c::rm
      ;;
    *) break
      ;;
  esac
  shift
done
