#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
. common.sh

# Install aws dummy box if not present
if ! vagrant box list | grep -qe "^${VAGRANT_BOX_NAME} "; then
  vagrant box add "${VAGRANT_BOX_NAME}" \
    https://github.com/mitchellh/vagrant-aws/raw/74021d7c9fbc519307d661656f6ce96eeb61153c/dummy.box
fi

# Create and upload an ssh keypair if needed
if [ ! -f "${KEYFILE}" ]; then
  mkdir -p .vagrant
  ssh-keygen -f "${KEYFILE}" -t rsa -b 4096 < /dev/null
fi

if ! aws ec2 describe-key-pairs --key-name "${KEYNAME}" > /dev/null 2>&1; then
  aws ec2 import-key-pair \
    --key-name "${KEYNAME}" \
    --public-key-material "$(cat "${KEYFILE}.pub")"
fi

vagrant up

cat << EOF
To use this vm:
  export KEYFILE=${KEYFILE}
  vagrant ssh
EOF
