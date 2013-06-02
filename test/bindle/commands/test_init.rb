require 'helper'
require 'bindle'
require 'bindle/commands/init'

module Bindle
  module Commands
    class TestInit < MiniTest::Unit::TestCase

      def test_shows_help
        output = capture(:stdout) do
          system("#{binary} init --help")
        end

        assert_match /Usage:\n  bindle init/, output
      end

      def test_displays_creation_of_files
        output = capture(:stdout) do
          Init.start(['--pretend'], {destination_root: destination_root})
        end

        files = %w( Vagrantfile
                    Veeweefile
                    Cheffile
                    .librarian
                    .librarian/chef/config
                    chef
                    chef/roles
                    chef/roles/base.rb
                    chef/definitions
                    chef/definitions/base/base.sh
                    chef/definitions/base/chef.sh
                    chef/definitions/base/cleanup.sh
                    chef/definitions/base/definition.rb
                    chef/definitions/base/zerodisk.sh
                    chef/README.md )

        files.each do |file|
          assert_match /create\s\s#{file}/, output
        end

        assert_match /librarian-chef\sinstall/, output
      end
    end
  end
end

