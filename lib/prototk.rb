require 'pathname'
require "prototk/version"

module Prototk
  autoload :CLI, "prototk/cli"
  autoload :Config, "prototk/config"
  autoload :DSL, "prototk/dsl"
  autoload :Generator, "prototk/generator"
  autoload :Runner, "prototk/runner"

  class Error < StandardError; end

  class << self
    def base_path
      @base_path ||= File.realpath("#{__dir__}/..")
    end

    def plugins_path
      "#{base_path}/plugins"
    end

    def protofile_path
      "#{Dir.pwd}/Protofile"
    end

    def list_plugins
      Pathname.glob("#{plugins_path}/*").map(&:basename)
    end

    def plugin(name)
      path = "#{plugins_path}/#{name}"
      raise Error, "Plugin #{name} not found" unless File.exist?(path)
      path
    end

    def load_config(path=nil)
      path ||= protofile_path
      unless File.exist?(path)
        raise Error, "Protofile does not exists"
      end

      code = File.read(path)
      config = DSL.eval(code, path)
      unless config
        raise Error, "Protofile must return configuration"
      end

      config
    end

    def glob_protos(path)
      Dir.glob(File.join(path, '*.proto'))
    end

    # def test
    #   if ARGV.size < 3
    #     puts "Usage: $0 SRC_DIR OUT_DIR NAMESPACE"
    #   end

    #   base_path = File.expand_path(__FILE__, '..')
    #   template_path = "#{base_path}/templates/"

    #   src_dir = ARGV[0]
    #   out_dir = ARGV[1]
    #   namespace = ARGV[2]

    #   class_name = "EnumInitializer"

    #   pattern = File.join(src_dir, "*.proto")

    #   enums = Dir.glob(pattern).map do |filename|
    #     File.basename(filename, '.proto')
    #   end
    # end
  end
end
