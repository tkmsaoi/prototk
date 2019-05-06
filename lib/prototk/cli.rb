require 'thor'

module Prototk
  class CLI < Thor
    class_option :profile, :aliases => '-p', :type => :string

    desc "generate", "Generate Protocol Buffers files"
    def generate
      profile = Prototk.load_profile(options.profile)
      Generator.generate(profile)
    end

    desc "plugins", "List available plugins"
    def plugins
      profile = Prototk.load_profile(options.profile)
      puts profile.list_plugins.join("\n")
    end

    desc "plugin NAME", "Print plugin path"
    def plugin(name)
      profile = Prototk.load_profile(options.profile)
      path = profile.search_plugin(name)

      unless path
        STDERR.puts "Plugin #{name} not found"
        exit 1
      end

      puts "#{path}"
    end
  end
end
