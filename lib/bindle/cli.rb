require 'bindle/version'
require 'active_support/core_ext/string'

if ['--version', '-v'].include?(ARGV.first)
  puts "Bindle #{Bindle::VERSION::STRING}"
  exit(0)
end

ARGV << '--help' if ARGV.empty?

aliases = {
  "n" => "new",
  "c" => "cookbooks",
  "p" => "package",
  "b" => "build",
  "g" => "generate"
}

help_message = <<-EOT.strip_heredoc
Usage:
  bindle COMMAND [ARGS]

Common commands are:
  init        Setup bindle in the current directory
  cookbooks   Handles tasks with chef cookbooks
  package     Build cloud images and vagrant boxes
  build       Create vagrant and production servers
  generate    Create new roles, definitions, and config files
EOT

command = ARGV.shift
command = aliases[command] || command

case command
when 'init', 'cookbooks', 'package', 'build', 'generate'
  require "bindle/commands"

  if ['init', 'generate'].include? command
    require "bindle/commands/#{command}"
    klass = Object.const_get("Bindle::Commands::#{command.capitalize}")
    klass.start(ARGV)
  else
    if [nil, "-h", "--help"].include?(ARGV.first)
      Bindle::Commands.help command
      exit
    end

    name = ARGV.shift
    Bindle::Commands.invoke [command, name], ARGV
  end
when '-h', '--help'
  puts help_message
else
  puts "Error: '#{command}' not recognized"
  puts help_message
  exit(1)
end
