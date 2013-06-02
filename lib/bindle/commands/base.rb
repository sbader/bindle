begin
  require 'thor/group'
rescue LoadError
  puts "Thor is not available.\nPlease make sure thor is installed and run again"
  exit
end

require 'active_support/core_ext/string/inflections'

module Bindle
  module Commands
    class Base < Thor::Group
      include Thor::Actions

      add_runtime_options!
      strict_args_position!

      class << self
        def source_root
          default_source_root
        end

        def default_command_root
          File.dirname(__FILE__)
        end

        def default_source_root
          File.join(default_command_root, "..", "templates")
        end

        def banner
          banner = "bindle #{display_name}"
          banner << " #{self.arguments.map(&:usage).join(' ')}" if self.arguments.length > 0
          banner << " [options]"
        end

        def display_name
          self.to_s.split("::")
            .reject { |item| ["Bindle", "Commands"].include?(item) }
            .map(&:underscore)
            .join(" ")
        end
      end
    end
  end
end
