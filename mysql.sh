#!/bin/bash

source env.sh

c::up() {
  docker-compose -p ${PROJECT_NAME} -f compose/mysql/mysql.yml up -d
}

c::start() {
  docker-compose -p ${PROJECT_NAME} -f compose/mysql/mysql.yml start
}

c::stop() {
  docker-compose -p ${PROJECT_NAME} -f compose/mysql/mysql.yml stop
}

c::kill() {
  docker-compose -p ${PROJECT_NAME} -f compose/mysql/mysql.yml kill
}

while [ -n $1 ]; do
  case $1 in
    'up') c::up
      ;;
    'start') c::start
      ;;
    'stop') c::stop
      ;;
    'kill') c::kill
      ;;
    *) break
      ;;
  esac
  shift
done
