module Prototk
  class Generator
    class << self
      def generate(config)
        self.new.generate(config)
      end
    end

    attr_accessor :runner

    def initialize
      @runner = Runner.new
    end

    def generate(config)
      runner.run(
        "protoc",
        "-I=#{config.src_path}",
        "--csharp_out=#{config.out_path}",
        *Prototk.glob_protos(config.messages_path)
      )

      runner.run(
        "protoc",
        "-I=#{config.src_path}",
        "--csharp_out=#{config.out_path}",
        "--plugin=#{Prototk.plugin("enum-initializer")}",
        *Prototk.glob_protos(config.enums_path)
      )
    end
  end
end
