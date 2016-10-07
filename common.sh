#!/bin/sh

export PREFIX="${PREFIX:-jenkins}"
export AWS_DEFAULT_REGION=eu-west-1

export VAGRANT_DEFAULT_PROVIDER="aws"
export VAGRANT_BOX_NAME="aws_vagrant_box"

export KEYFILE=.vagrant/usability-jenkins
export KEYNAME=${PREFIX}-key
