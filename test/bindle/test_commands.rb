require 'helper'
require 'bindle'

module Bindle
  class TestCommands < MiniTest::Unit::TestCase
    def test_shows_help
      output = capture(:stdout) do
        system("#{binary} --help")
      end

      assert_match /Usage:\n  bindle/, output
    end

    def test_init_shows_help
      output = capture(:stdout) do
        system("#{binary} init --help")
      end

      assert_match /Usage:\n  bindle init/, output
    end

    def test_cookbooks_shows_help
      output = capture(:stdout) do
        system("#{binary} cookbooks --help")
      end

      assert_match /Usage:\n  bindle cookbooks/, output
    end

    def test_package_shows_help
      output = capture(:stdout) do
        system("#{binary} package --help")
      end

      assert_match /Usage:\n  bindle package/, output
    end

    def test_build_shows_help
      output = capture(:stdout) do
        system("#{binary} build --help")
      end

      assert_match /Usage:\n  bindle build/, output
    end

    def test_generate_shows_help
      output = capture(:stdout) do
        system("#{binary} generate --help")
      end

      assert_match /Usage:\n  bindle generate/, output
    end
  end
end
