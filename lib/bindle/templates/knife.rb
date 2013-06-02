cookbook_path ["chef/cookbooks", "chef/site-cookbooks"]
node_path     "chef/nodes"
role_path     "chef/roles"
data_bag_path "chef/data_bags"

knife[:ssh_user] =              ENV['AWS_SSH_USER'] || "ubuntu"
knife[:flavor] =                ENV['AWS_DEFAULT_FLAVOR'] || "t1.micro"
knife[:image] =                 ENV['AWS_DEFAULT_AMI'] || "ami-8b0772e2"
knife[:aws_access_key_id] =     ENV['AWS_ACCESS_KEY_ID']
knife[:aws_secret_access_key] = ENV['AWS_SECRET_ACCESS_KEY']
knife[:aws_ssh_key_id] =        ENV['AWS_SECURITY_KEY_NAME']
knife[:identity_file] =         ENV['AWS_IDENTITY_FILE']
