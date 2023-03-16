#!/bin/bash
set -x

# List of top 6 Alibaba Cloud regions
regions=(
  "ap-southeast-2"
  "ap-south-1"
)

# Iterate over the regions and run the test-cleanup-one.sh script for each region
for region in "${regions[@]}"; do
  echo "Processing region: $region"
  ./test_cleanup_one.sh "$region"
  echo "Finished processing region: $region"
done
