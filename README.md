Usability Jenkins

Vagrant configurations to make multiple EC2 VMs running Jenkins,
for usability lab testing.

# Usage:

`PREFIX` is optional and defaults to `jenkins`.  It is used to name your vms,
and to name the ssh key we generate.

~~~
PREFIX=example-jenkins ./deploy.sh
~~~

~~~
PREFIX=example-jenkins ./destroy.sh
~~~

## Debugging

~~~
KEYFILE=.vagrant/usability-jenkins PREFIX=example-jenkins vagrant ssh jenkins.0
~~~
