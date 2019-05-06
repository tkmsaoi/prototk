require 'prototk/version'

module Prototk
  autoload :CLI, 'prototk/cli'
  autoload :Config, 'prototk/config'
  autoload :Generator, 'prototk/generator'
  autoload :Plugin, 'prototk/plugin'
  autoload :Profile, 'prototk/profile'
  autoload :Runner, 'prototk/runner'

  PLUGIN_PREFIX = 'protoc-gen-'

  class Error < StandardError; end

  class << self
    def base_path
      @base_path ||= File.realpath("#{__dir__}/..")
    end

    def plugin_path
      "#{base_path}/plugins"
    end

    def default_profile_path
      "#{Dir.pwd}/Protofile"
    end

    def load_profile(path = nil)
      path ||= default_profile_path
      unless File.exist?(path)
        raise Error, 'Protofile does not exists'
      end
      Profile.new(path)
    end

    def glob_protos(path)
      Dir.glob(File.join(path, '**/*.proto'))
    end
  end
end
