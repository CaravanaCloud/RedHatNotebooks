#!/bin/bash
# export CLUSTER_NAME="$USER-$(date +%m%d)"
export CLUSTER_NAME="$USER-$RANDOM"

echo "Creating Single Node OpenShift Cluster $CLUSTER_NAME"
mkdir ".$CLUSTER_NAME"
envsubst < "aws-sno/install-config.envsubst.yaml" > ".$CLUSTER_NAME/install-config.yaml"
cp  ".$CLUSTER_NAME/install-config.yaml" ".$CLUSTER_NAME/install-config.bak.yaml"
openshift-install create cluster --dir ".$CLUSTER_NAME"
