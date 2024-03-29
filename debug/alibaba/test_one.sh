#!/bin/bash
set -ex

region="$1"
dir="./ali-${region}"

log_file="$dir/test_one.log.txt"
log() {
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  message="$*"
  echo "${timestamp} ${region} ${message}" | tee -a "${log_file}"
}

log "-- Cluster Config:"
export RELEASE_IMAGE=$(./openshift-install version | awk '/release image/ {print $3}')
export CLUSTER_NAME="alij-${region}"
export ALI_REGION="${region}"

log "  base domain: ${ALI_BASEDOMAIN}"
log "  release image: ${RELEASE_IMAGE}"
main() {
  log "Processing region: ${region} on ${dir} at $(date)"
  if [ -d "${dir}" ]; then
    mv "${dir}" "./archive/${dir}-$(date +%Y%m%d%H%M%S)"
  fi
  mkdir $dir

  log "Generating install config"
  envsubst < ./install-config.env.yaml > "${dir}/install-config.yaml"
  cp "${dir}/install-config.yaml" "${dir}/install-config.bak.yaml"

  manifests_dir="${dir}/manifests"
  log "Creating manifests at [$manifests_dir]"
  ./openshift-install create manifests --dir "${dir}"
  
  cred_reqs_dir="${dir}/cred_reqs"
  log "Extracting credential requests to [$cred_reqs_dir]"
  ./oc adm release extract \
    --credentials-requests \
    --cloud=alibabacloud \
    --to="${cred_reqs_dir}" \
    $RELEASE_IMAGE

  ccotl_out="${dir}/ccotl_out"
  log "Processing credentials requests to [$ccotl_out] "
  ccoctl alibabacloud create-ram-users \
    --name $CLUSTER_NAME \
    --region=$ALI_REGION \
    --credentials-requests-dir=${cred_reqs_dir} \
    --output-dir=${ccotl_out}

  log "Copy manifests"
  cp "${ccotl_out}/manifests"/*credentials.yaml "${manifests_dir}"
  
  log "Creating cluster"
  ./openshift-install create cluster --dir ${dir} --log-level=debug

  log "Set auth"
  export KUBECONFIG="${dir}/auth/kubeconfig"

  log "TODO: Collect logs"
  ./oc adm must-gather
  sleep 60

  log "Destroy cluster"
  ./openshift-install destroy cluster --dir ${dir} --log-level=debug

  log "Finished processing region: ${region} at $(date)"
}


start_time=$(date +%s)
main
end_time=$(date +%s)
total_time=$((end_time - start_time))
total_time_minutes=$(log "scale=2; ${total_time}/60" | bc)
log "Total execution time: ${total_time_minutes} minutes"
