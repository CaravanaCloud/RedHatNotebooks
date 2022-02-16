#/bin/bash

# To disable dry ryn: 
# export NO_DRY_RUN="--no-dry-run"
# WARNING: this can delete stuff beyond recovery, try a dry run first

export CLN_ACCOUNT="$(aws sts get-caller-identity --query Account --output text)"
export CLN_REGION="$(aws configure get region)"
export CLN_TARGET="$OCP_NAME"

echo "CLN_ACCOUNT=$CLN_ACCOUNT"
echo "CLN_REGION=$CLN_REGION"
echo "CLN_TARGET=$CLN_TARGET"

if ! command -v aws-nuke &> /dev/null
then
    echo "aws-nuke could not be found, downloading..."
    AWS_NUKE_URL="https://github.com/rebuy-de/aws-nuke/releases/download/v2.17.0/aws-nuke-v2.17.0-linux-amd64.tar.gz"
    wget -O /tmp/aws-nuke.tar.gz "$AWS_NUKE_URL"
    mkdir /tmp/aws-nuke
    tar zxvf /tmp/aws-nuke.tar.gz -C /tmp/aws-nuke
    mv -f /tmp/aws-nuke/aws-nuke-v2.17.0-linux-amd64 /usr/local/bin/aws-nuke
fi
aws-nuke version

echo "Generating configuration"
envsubst < aws-nuke.tpl.yaml > /tmp/aws-nuke.yml
cat /tmp/aws-nuke.yml

echo "Starting aws-nuke"
aws-nuke "$CLN_FLAGS" -c /tmp/aws-nuke.yml \
    --force --force-sleep 3 \
    "$NO_DRY_RUN"

echo "done."