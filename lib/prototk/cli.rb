require 'thor'

module Prototk
  class CLI < Thor
    class_option :config, :aliases => '-c', :type => :string

    desc "generate", "Generate Protocol Buffers files"
    def generate
      config = Prototk.load_config(options.config)
      Generator.generate(config)
    end

    desc "plugins", "List available plugins"
    def plugins
      puts Prototk.list_plugins.join("\n")
    end

    desc "plugin NAME", "Print plugin path"
    def plugin(name)
      puts "#{Prototk.plugin(name)}"
    end
  end
end
