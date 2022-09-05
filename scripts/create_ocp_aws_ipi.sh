#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export OCP_INSTALL_DIR="$DIR/../tmp/install-dir"
export OCP_INSTALL_CONFIG="$DIR/../tmp/install-dir/install-config.yaml"
export OCP_AWS_REGION="ap-northeast-1"
export OCP_ARCH="amd64"
export OCP_WORKER_REPLICAS="3"
export OCP_WORKER_TYPE="t3.2xlarge"
export OCP_CONTROL_TYPE="t3.2xlarge"
export OCP_CONTROL_REPLICAS="3"
export OCP_DRY_RUN="false"
export OCP_INSTANCE_TYPE="t3.2xlarge"
export LOG_LEVEL="info"
export OCP_NAME="rhnb-$RANDOM"

echo "Creating install dir [$OCP_INSTALL_DIR]"
mkdir -p $OCP_INSTALL_DIR

echo "Creating AWS OCP IPI Cluster $OCP_NAME"
envsubst < "$DIR/../provisioning/install_config.tpl.yaml" > "$OCP_INSTALL_CONFIG"

echo "Checking config file"
head "$OCP_INSTALL_CONFIG"
echo "..."

echo "Create cluster"
openshift-install create cluster --dir "$OCP_INSTALL_DIR" --log-level="$LOG_LEVEL"