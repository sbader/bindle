if [ -f .veewee_params ]
then
  . .veewee_params
fi

if [ -z "$CHEF_VERSION" ]; then
  # Default to latest
  gem install chef --no-ri --no-rdoc
else
  gem install chef --no-ri --no-rdoc --version $CHEF_VERSION
fi

# Running chef-solo

echo '{
"rbenv": {
  "user_installs": [
    {
      "user": "vagrant",
      "rubies": ["2.0.0-p0"],
      "global": "2.0.0-p0",
      "gems": {
        "2.0.0-p0": [
          { "name": "bundler" }
        ]
      }
    }
  ]
},
"run_list": [
  "recipe[apt]",
  "recipe[ntp]",
  "recipe[build-essential]",
  "recipe[git]",
  "recipe[rbenv::user]"
]}' > ~/node.json

echo '
cookbook_path "/root/recipes"
log_level :info
' > ~/solo.rb

tar xzvf ~/recipes.tar.gz

chef-solo -c ~/solo.rb -j ~/node.json

rm ~/node.json ~/solo.rb
rm -rf ~/recipes
