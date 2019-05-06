module Prototk
  class Config
    attr_accessor :src_path, :out_path
    attr_reader :name, :plugins

    def initialize(name)
      @name = name
      @src_path = 'src'
      @out_path = 'out'
      @plugins = {}
    end

    def plugin(name, options = {})
      @plugins[name] = options
    end
  end
end
