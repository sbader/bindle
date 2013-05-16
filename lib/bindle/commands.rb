module Bindle
  module Commands
    def self.subclasses
      @subclasses ||= []
    end

    def self.find_by_namespace(name)
      lookup(name)
      namespaces = Hash[subclasses.map { |klass| [klass.namespace, klass] }]
      namespace = (["bindle", "commands"] + name).join(":")
      namespaces[namespace]
    end

    def self.invoke(name, args = ARGV, config = {})
      if klass = find_by_namespace(name)
        args << "--help" if args.empty? && klass.arguments.any? { |a| a.required? }
        klass.start(args, config)
      else
        puts "Could not find command #{name}"
        help
      end
    end

    def self.help(command = self.to_s)
      puts "Usage: bindle #{command.demodulize.underscore} COMMAND [args] [options]"
      puts
      puts "General options:"
      puts "  -h, [--help]     # Print generator's options and usage"
      puts "  -p, [--pretend]  # Run but do not make any changes"
      puts "  -f, [--force]    # Overwrite files that already exist"
      puts "  -s, [--skip]     # Skip files that already exist"
      puts "  -q, [--quiet]    # Suppress status output"
      puts
      puts "Choose a command below"
      puts
    end

    protected

    def self.lookup(name)
      path = name.inject("bindle/commands") { |path, part| File.join(path, part) }

      begin
        require path
        return
      rescue LoadError => e
        raise unless e.message =~ /#{Regexp.escape(path)}$/
      rescue Exception => e
        warn "[WARNING] Could not load command #{path.inspect}. Error: #{e.message}.\n#{e.backtrace.join("\n")}"
      end
    end
  end
end
