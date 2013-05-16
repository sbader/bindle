require 'helper'
require 'bindle'

module Bindle
  class TestBindle < MiniTest::Unit::TestCase
    def test_version
      major = Bindle::VERSION.const_get('MAJOR')
      minor = Bindle::VERSION.const_get('MINOR')
      patch = Bindle::VERSION.const_get('PATCH')

      assert(!major.nil?, 'should have a MAJOR constant')
      assert(!minor.nil?, 'should have a MINOR constant')
      assert(!patch.nil?, 'should have a PATCH constant')
    end

    def test_version_string
      version_string = Bindle::VERSION.const_get('STRING')

      assert(!version_string.empty?, 'should have a VERSION STRING constant')
    end
  end
end
