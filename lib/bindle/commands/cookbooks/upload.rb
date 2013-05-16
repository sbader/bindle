require 'bindle/commands/base'

module Bindle
  module Commands
    module Cookbooks
      class Upload < Base

        protected

        def self.banner
          "bindle cookbooks upload #{self.arguments.map(&:usage).join(' ')} [options]"
        end
      end
    end
  end
end
