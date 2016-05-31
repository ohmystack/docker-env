#!/bin/bash

source env.sh

c::up() {
  docker-compose -p ${PROJECT_NAME} -f compose/cadvisor/cadvisor.yml up -d
}

c::start() {
  docker-compose -p ${PROJECT_NAME} -f compose/cadvisor/cadvisor.yml start
}

c::restart() {
  docker-compose -p ${PROJECT_NAME} -f compose/cadvisor/cadvisor.yml restart
}

c::stop() {
  docker-compose -p ${PROJECT_NAME} -f compose/cadvisor/cadvisor.yml stop
}

c::kill() {
  docker-compose -p ${PROJECT_NAME} -f compose/cadvisor/cadvisor.yml kill
}

c::rm() {
  docker-compose -p ${PROJECT_NAME} -f compose/cadvisor/cadvisor.yml rm -v
}

while [ -n $1 ]; do
  case $1 in
    'up') c::up
      ;;
    'start') c::start
      ;;
    'restart') c::restart
      ;;
    'stop') c::stop
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
