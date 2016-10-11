#!/bin/sh
set -eu
PUBLIC_IP=$(curl -qs http://169.254.169.254/latest/meta-data/public-ipv4)
PASSWORD=$(gawk "match(\$0, /application password to '(.*?)'/, array) { print array[1] }"  /var/log/boot.log)

cat << EOF
Jenkins instance available:

  https://${PUBLIC_IP}/
  Username: user
  Password: ${PASSWORD}
EOF
