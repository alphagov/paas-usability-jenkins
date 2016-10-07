# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.8.0"

if !ENV['KEYFILE']
  puts "Need $KEYFILE"
  exit 1
end

AWS_ACCOUNT = ENV.fetch("AWS_ACCOUNT", "dev")
AWS_ACCOUNT_DATA = {
  "dev" => {
    :subnet_id => "subnet-2d54225b", # "usability-jenkins" 10.0.0.0/24 range
    :security_group => "sg-a0639cc6", # "usability-jenkins" security group
  },
}
AWS_ACCOUNT_VARIABLES = AWS_ACCOUNT_DATA.fetch(AWS_ACCOUNT)

COUNT = 1

Vagrant.configure(2) do |config|
  Dir.glob("./post-deploy.d/*").sort.each do |post_deploy_file|
    config.vm.provision "shell" do |s|
      s.privileged = true
      s.name = post_deploy_file
      s.path = post_deploy_file
    end
  end

  COUNT.times do |i|
    config.vm.define "jenkins.#{i}" do |jenkins|
      jenkins.vm.box = ENV['VAGRANT_BOX_NAME'] || 'aws_vagrant_box'

      jenkins.vm.provider :aws do |aws, override|
        aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
        aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
        aws.associate_public_ip = true
        aws.tags = { 'Name' => ENV['PREFIX'] + ".#{i}" }

        # Jenkins marketplace ami from
        #  https://aws.amazon.com/marketplace/pp/B00NNZUF3Q
        #  https://aws.amazon.com/marketplace/fulfillment?productId=447af561-b7e2-4d03-8a67-4842db5439cb
        aws.region = 'eu-west-1'
        aws.ami = 'ami-99116dea'

        aws.keypair_name = ENV['KEYNAME']
        override.ssh.private_key_path = ENV['KEYFILE']
        aws.instance_type = 'm3.medium'

        aws.subnet_id = AWS_ACCOUNT_VARIABLES.fetch(:subnet_id)
        aws.security_groups = [AWS_ACCOUNT_VARIABLES.fetch(:security_group)]

        # Add IAM role to allow access to necessary AWS APIs
        aws.iam_instance_profile_name = 'usability-jenkins'

        # We will rely on vagrant generating a ssh key, but this must be the bitnami user, as the vagrant user does not exist on the vm
        override.ssh.username = "bitnami"

        # Fix issue on osx: https://github.com/mitchellh/vagrant/issues/5401#issuecomment-115240904
        override.nfs.functional = false
      end
    end
  end
end
