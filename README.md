# Usability Jenkins

Vagrant configurations to make multiple EC2 VMs running Jenkins, for usability lab testing.

## Laboratory

Before the lab day, one of our colleague will need to run, the Jenkins deployment, using [`paas-usability-jenkins`](https://github.com/alphagov/paas-usability-jenkins) extension to `paas-cf`.

The deployment should end up successfully, providing us with the credentials required for the Jenkins interface.

These credentials should be passed onto the user, when their session approaches.

Each participant, will have the fresh Jenkins setup, allowing them to configure what's necessary, in order to deploy their applications with CloudFoundry.

At the end of the session, it will be safe to run the destroy functionality, which should release used resources.

## How to

The script makes use of some environment variables.

 - `PREFIX` - Used for AWS resource names and key generators. Defaults to `jenkins`. This prefix, should be specified for both, `deploy` and `destroy` functionality. It does need to be the same.

### deploy

```
./deploy.sh
```

### certs

This feature, should only need to be used in dev environment. Try to avoid the usage for other envs.

```
./certs.sh
```

**Note** This script, requires both, `DEPLOY_ENV` and `PREFIX` to be set.

#### Outcome

```
$ PREFIX=rafalp-jenkins ./deploy.sh

Bringing machine 'jenkins.0' up with 'aws' provider...
[...]
==> jenkins.0: Jenkins instance available:
==> jenkins.0:
==> jenkins.0:   https://54.174.148.59/
==> jenkins.0:   Username: user
==> jenkins.0:   Password: qXmDjpn2HJ9C
[...]
To use this vm:
  export KEYFILE=.vagrant/usability-jenkins
  vagrant ssh
```

### destroy

```
./destroy.sh
```

### Debugging

```
KEYFILE=.vagrant/usability-jenkins PREFIX=example-jenkins vagrant ssh jenkins.0
```
