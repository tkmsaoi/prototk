module Prototk
  class Profile < Hash
    attr_reader :path, :options

    def initialize(path)
      super() {|h, k| h[k] = Config.new(k) }

      @path = File.expand_path(path)
      @options = {
        :plugin_paths => [],
      }
      @config_id = 1

      instance_eval(File.read(@path), @path)
    end

    def set(name, value)
      @options[name] = value
    end

    def add_plugin_path(path)
      @options[:plugin_paths].prepend(path)
    end

    def plugin_paths
      [
        *(@options[:plugin_paths].map {|p| expand_path(p) }),
        Prototk.plugin_path,
      ]
    end

    def configure(name = nil)
      unless name
        name = "config#{@config_id}"
        @config_id += 1
      end

      yield self[name] if block_given?

      self[name]
    end

    def base_path
      File.expand_path('..', path)
    end

    def expand_path(path)
      File.expand_path(path, base_path)
    end

    def list_plugins
      plugin_paths.flat_map do |plugin_path|
        Dir.glob("#{plugin_path}/#{Prototk::PLUGIN_PREFIX}*").map do |filename|
          File.basename(filename).sub!(/^#{Prototk::PLUGIN_PREFIX}/, '')
        end
      end
    end

    def search_plugin(name)
      plugin_paths.each do |plugin_path|
        path = "#{plugin_path}/#{Prototk::PLUGIN_PREFIX}#{name}"
        return path if File.exist?(path)
      end
      nil
    end
  end
end
