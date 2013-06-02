require 'rubygems'

begin
  require 'bundler'
rescue LoadError => e
  STDERR.puts e.message
  STDERR.puts "Run `gem install bundler` to install Bundler."
  exit e.status_code
end

begin
  Bundler.setup(:default, :development, :test)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems."
  exit e.status_code
end

require 'active_support/concern'
require 'minitest/unit'
require 'pry'

ENV['THOR_SHELL'] = "Thor::Shell::Basic"

class MiniTest::Unit::TestCase
  # The location of the command line binary
  def binary
    File.join(File.dirname(__FILE__), "../bin/bindle")
  end

  # Using until updated activesupport is stable
  # Captures the given stream and returns it:
  #
  #   stream = capture(:stdout) { puts 'notice' }
  #   stream # => "notice\n"
  #
  #   stream = capture(:stderr) { warn 'error' }
  #   stream # => "error\n"
  #
  # even for subprocesses:
  #
  #   stream = capture(:stdout) { system('echo notice') }
  #   stream # => "notice\n"
  #
  #   stream = capture(:stderr) { system('echo error 1>&2') }
  #   stream # => "error\n"
  def capture(stream)
    stream = stream.to_s
    captured_stream = Tempfile.new(stream)
    stream_io = eval("$#{stream}")
    origin_stream = stream_io.dup
    stream_io.reopen(captured_stream)

    yield

    stream_io.rewind
    return captured_stream.read
  ensure
    captured_stream.unlink
    stream_io.reopen(origin_stream)
  end

  def destination_root
    tmp_path 'test_tmp'
  end

  def tmp_path(*args)
    @tmp_path ||= File.realpath(Dir.mktmpdir)
    File.join(@tmp_path, *args)
  end
end

MiniTest::Unit.autorun
