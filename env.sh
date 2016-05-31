#!/bin/bash

# -----------------
# Dokcer-compose
# -----------------
export PROJECT_NAME="oms"

# -----------------
# Host info
# -----------------
export HOST_ID=$(hostname)
# LOCAL_NIC_IP is the IP configured on VM's local NIC
export LOCAL_NIC="eth0"
export LOCAL_NIC_IP=$(ip addr show $LOCAL_NIC | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}')
# HOST_IP is the VM's public IP, for remote communication
export HOST_IP='127.0.0.1'
export LIBPROCESS_IP=$LOCAL_NIC_IP

# -----------------
# Zookeeper
# -----------------
export ZK_URI='zk://127.0.0.1:2181'
