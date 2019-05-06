module Prototk
  class Generator
    class << self
      def generate(profile)
        self.new.generate(profile)
      end
    end

    def initialize(runner = nil)
      @runner = runner || Runner.new
    end

    def generate(profile)
      profile.each do |name, config|
        plugin_options = generate_plugin_options(profile, config)
        files = Prototk.glob_protos(config.src_path)

        @runner.run("protoc", "-I=#{config.src_path}", *plugin_options, *files)
      end
    end

    def generate_plugin_options(profile, config)
      options = []
      config.plugins.each do |plugin_name, plugin_options|
        plugin_path = profile.search_plugin(plugin_name)
        if plugin_path
          options << "--plugin=#{plugin_path}"
        end

        options << "--#{plugin_name}_out=#{config.out_path}"

        plugin_options.each do |key, value|
          options << "--#{plugin_name}_opt=#{key}=#{value}"
        end
      end
      options
    end
  end
end
