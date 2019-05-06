module Prototk
  class Config
    attr_reader :name, :plugins
    attr_writer :base_path, :src_path, :out_path

    def initialize(name)
      @name = name
      @base_path = '.'
      @src_path = 'src'
      @out_path = 'out'
      @plugins = {}
    end

    def base_path
      File.realpath(@base_path)
    end

    def src_path
      File.realpath(File.join(base_path, @src_path))
    end

    def out_path
      File.realpath(File.join(base_path, @out_path))
    end

    def plugin(name, options = {})
      @plugins[name] = options
    end
  end
end
