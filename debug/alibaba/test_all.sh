#!/bin/bash

regions=(
  "ap-southeast-2"
  "ap-south-1"
#  "eu-west-1"
#  "ap-southeast-6"
#  "ap-southeast-3"
#  "ap-southeast-5"
#  "eu-central-1"
#  "cn-shanghai"
#  "cn-hangzhou"
#  "cn-beijing"
)

base_url="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/4.12.7"
fetch(){
    fname=$1
    if [ ! -f "${fname}" ]; then
        wget "${base_url}/${fname}"
    fi    
    tar zxvf "${fname}"    
}

# fetch "openshift-client-linux.tar.gz"
# fetch "ccoctl-linux.tar.gz"
# fetch "openshift-install-linux.tar.gz"

echo "Checking versions"
./oc version
./openshift-install version
./ccoctl version

echo "Archive old tests"
# mv -f ./ali-* "./archive"

echo "Starting tests"
for region in "${regions[@]}"; do
  ./test_one.sh "${region}" | tee "${dir}/0_test.log"
done
echo "Finished tests"
