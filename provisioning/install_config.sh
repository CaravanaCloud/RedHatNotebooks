#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export CLUSTER_NAME="rhnb-$RANDOM"
export OCP_NAME=${OCP_NAME:-$CLUSTER_NAME}

install_dir="/tmp/install-$OCP_NAME"
install_config="$install_dir/install-config.yaml"

echo "Cleanup install dir $install_dir"
rm -rf $install_dir
mkdir -p $install_dir

envsubst < $DIR/install_config.tpl.yaml > "$install_config"
cat "$install_config"

echo "# Review your configuration above or [$install_config]"
echo "# Paste the line below to create the cluster [$OCP_NAME]"
echo openshift-install create cluster --dir "$install_dir" --log-level=info | tee >(xsel -ib)

