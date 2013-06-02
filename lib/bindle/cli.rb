require 'bindle/version'
require 'active_support/core_ext/string'

if ['--version', '-v'].include?(ARGV.first)
  puts "Bindle #{Bindle::VERSION::STRING}"
  exit(0)
end

ARGV << '--help' if ARGV.empty?

aliases = {
  "i" => "init"
}

help_message = <<-EOT.strip_heredoc
Usage:
  bindle COMMAND [ARGS]

Common commands are:
  init        Setup bindle in the current directory
EOT

command = ARGV.shift
command = aliases[command] || command

case command
when 'init'
  require "bindle/commands/init"
  klass = Object.const_get("Bindle::Commands::#{command.capitalize}")
  klass.start(ARGV)
when '-h', '--help'
  puts help_message
else
  puts "Error: '#{command}' not recognized"
  puts help_message
  exit(1)
end
