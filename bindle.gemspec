# -*- encoding: utf-8 -*-

require File.expand_path("../lib/bindle/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "bindle"
  gem.version       = Bindle::VERSION::STRING
  gem.summary       = %q{bindle is a server and development environment provisioning tool}
  gem.description   = %q{bindle is a server and development environment provisioning tool. Using Chef, Vagrant, and Fog it organizes and simplifies the creation and management of your development environment and allows you to use the same provisioning tools on your production servers.}
  gem.license       = "MIT"
  gem.authors       = ["Scott Bader"]
  gem.email         = "sb@scottbader.org"
  gem.homepage      = "https://github.com/sbader/bindle#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "fog"
  gem.add_dependency "chef"
  gem.add_dependency "librarian-chef"
  gem.add_dependency "thor"
  gem.add_dependency "activesupport"

  gem.add_development_dependency "bundler"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rdoc"
  gem.add_development_dependency "rubygems-tasks"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "m", "~> 1.3.1"
end
