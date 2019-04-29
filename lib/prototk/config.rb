module Prototk
  class Config
    attr_accessor \
      :base_path,
      :src_path,
      :src_messages_path,
      :src_enums_path,
      :out_path,
      :namespace,
      :enum_initializer_name

    def initialize
      @base_path = '.'

      @src_path = "src"
      @src_messages_path = "."
      @src_enums_path = "enums"

      @out_path = "out"

      @enum_initializer_name = "EnumInitializer"
    end

    def base_path
      File.realpath(@base_path)
    end

    def src_path
      File.realpath(File.join(base_path, @src_path))
    end

    def messages_path
      File.realpath(File.join(src_path, src_messages_path))
    end

    def enums_path
      File.realpath(File.join(src_path, src_enums_path))
    end

    def out_path
      File.realpath(File.join(base_path, @out_path))
    end
  end
end
