require 'helper'
require 'bindle'

module Bindle
  class TestCli < MiniTest::Unit::TestCase
    def test_shows_help
      output = capture(:stdout) do
        system("#{binary} --help")
      end

      assert_match /Usage:\n  bindle/, output
    end
  end
end
