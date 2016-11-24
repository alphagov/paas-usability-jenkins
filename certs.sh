#!/bin/bash

set -euo pipefail

. common.sh

aws s3 cp s3://${DEPLOY_ENV}-state/bosh-CA.tar.gz - | tar --to-stdout -xvzf - bosh-CA.crt | vagrant ssh jenkins.0 -- sudo /opt/bitnami/java/bin/keytool -noprompt -import -trustcacerts -alias ${DEPLOY_ENV}-boshCA-$(date +%s) -keystore /opt/bitnami/java/lib/security/cacerts -storepass changeit ; vagrant ssh jenkins.0 -- sudo /etc/init.d/bitnami restart
