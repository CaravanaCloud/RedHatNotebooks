#!/bin/bash

export ROSA_URL=https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/rosa/latest/rosa-linux.tar.gz
mkdir -p /tmp/rosa/
wget -O /tmp/rosa/rosa-linux.tar.gz $ROSA_URL
tar zxvf /tmp/rosa/rosa-linux.tar.gz -C  /tmp/rosa/
ls /tmp/rosa/
sudo mv  /tmp/rosa/rosa /usr/local/bin/ 
rm /tmp/rosa/rosa-linux.tar.gz

rosa download oc
sudo tar zxvf openshift-client-linux.tar.gz -C /usr/local/bin
rm openshift-client-linux.tar.gz

mkdir -p /tmp/splat/
wget -O /tmp/splat/openshift-install-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-install-linux.tar.gz
tar zxvf /tmp/splat/openshift-install-linux.tar.gz -C  /tmp/splat/
sudo mv  /tmp/splat/openshift-install /usr/local/bin/ 
rm /tmp/splat/openshift-install-linux.tar.gz

rosa version
oc version
openshift-install version