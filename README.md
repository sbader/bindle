# Bindle

## Description

Bindle is a server and development environment creation tool.

It sets up your repository with the correct files to use Vagrant, knife-ec2, knife-solo, and librarian-chef.

## Dependencies

To use Vagrant you'll need to install the current version at http://downloads.vagrantup.com/.

## Installation

    $ gem install bindle

## Setup

The following environment variables will need to be set to work with EC2:

- **AWS_ACCESS_KEY_ID** - AWS API Access Key Id [found here](https://console.aws.amazon.com/iam/home?#security_credential)
- **AWS_SECRET_ACCESS_KEY** - AWS API Secret Access Key [found here](https://console.aws.amazon.com/iam/home?#security_credential)
- **AWS_SECURITY_KEY_NAME** - Name of EC2 security key to use
- **AWS_IDENTITY_FILE** - The path to the identity file matching the security key

You can also override the following options with an environment variable:

- **AWS_SSH_USER** - The ssh user to use when accessing a server (defaults to 'ubuntu')
- **AWS_DEFAULT_FLAVOR** - The EC2 instance size to use (defaults to 't1.micro')
- **AWS_DEFAULT_AMI** - The AMI to use to build a server (defaults to 'ami-8b0772e2' Ubuntu 12.10 image from http://cloud-images.ubuntu.com/quantal/current)

## Usage

`init` sets up the current directory with config files for librarian, a Cheffile, a Gemfile, a knife.rb file, and a base chef role

To initialize the current directory run:

    $ bindle init

You can also pass a directory as the first argument to init and it will initialize bindle in that directory

    $ bindle init ~/code/bindle_test

Once initialized you can use librarian-chef, vagrant, and knife to work with cookbooks and build servers.

To create and provision a vagrant box, just run:

    $ vagrant up

To launch an EC2 image, run:

    $ bin/knife ec2 server create -T Name="bindle_server"
    $ bin/knife solo prepare HOST_NAME_OF_CREATED_SERVER --run-list "role[base]"
    $ bin/knife solo cook HOST_NAME_OF_CREATED_SERVER

To add cookbooks, update the Cheffile and run:

    $ bin/librarian-chef install

To update installed cookbooks, run:

    $ bin/librarian-chef update [cookbook_name]

Vagrant, Chef, Knife Solo, Knife EC2, and Librarian Chef have a lot more functionality. Follow these links to dig in some more:

[Vagrant](http://docs.vagrantup.com/v2)  
[Chef](http://docs.opscode.com/)  
[Knife Solo](https://github.com/matschaffer/knife-solo/blob/master/README.rdoc)  
[Knife EC2](http://docs.opscode.com/plugin_knife_ec2.html)  
[Librarian Chef](https://github.com/applicationsonline/librarian-chef)  

## Copyright

Copyright (c) 2013 Scott Bader

## License

Bindle is released under the MIT License, see LICENSE.txt for details.
