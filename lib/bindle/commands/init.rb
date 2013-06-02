require 'fileutils'
require 'bindle/commands/base'
require 'librarian/action/resolve'
require 'librarian/action/install'
require 'librarian-chef'

module Bindle
  module Commands
    class Init < Base
      argument :name, type: :string, required: false,
                      desc: "Name of the project to create (empty for current directory)"

      def main
        unless name.nil?
          self.destination_root = project_name
        end
      end

      def kniferb
        empty_directory ".chef"
        template "knife.rb", ".chef/knife.rb"
      end

      def vagrantfile
        template "Vagrantfile"
      end

      def cheffile
        template "Cheffile"
      end

      def gemfile
        template "Gemfile"
      end

      def librarian
        directory "librarian", ".librarian"
      end

      def chef
        empty_directory "chef"

        inside "chef" do
          directory "roles"

          template "README.md"
        end
      end

      def gitignore
        if File.exists?(File.join(self.destination_root, ".git"))
          append_to_file ".gitignore", <<-IGNORE.strip_heredoc
            /chef/cookbooks
            /chef/tmp
            /chef/packages
            /.vagrant
          IGNORE
        end
      end

      # From railties: github.com/rails/rails/blob/f96478369e/railties/lib/rails/generators/app_base.rb#L253
      def bundle_install
        say_status :running, "bundle install"

        _bundle_command = Gem.bin_path('bundler', 'bundle')

        require 'bundler'

        if !options[:pretend]
          Bundler.with_clean_env do
            print `"#{Gem.ruby}" "#{_bundle_command}" install --binstubs`
          end
        end
      end

      def install_cookbooks
        say_status :running, "librarian-chef install"

        if !options[:pretend]
          environment = Librarian::Chef::Environment.new({pwd: self.destination_root})
          Librarian::Action::Resolve.new(environment).run
          Librarian::Action::Install.new(environment).run
        end
      end

      protected

      def project_name
        @project_name ||= begin
          if name.nil?
            File.basename(Dir.getwd).tr(".", "-")
          else
            name
          end
        end
      end
    end
  end
end
