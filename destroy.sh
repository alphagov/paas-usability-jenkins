#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
. common.sh

if aws ec2 describe-key-pairs --key-name "${KEYNAME}" > /dev/null 2>&1; then
  aws ec2 delete-key-pair --key-name "${KEYNAME}"
fi

vagrant destroy -f
