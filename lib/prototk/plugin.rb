require 'protobuf'

module Prototk
  class Plugin
    class << self
      def name(name)
        define_method('name') { name }
      end
    end

    def initialize(input = $stdin, output = $stdout)
      request = decode_request(input.read)
      options = parse_options(request)

      res = handle(request, options)

      output << res.to_proto
    end

    def handle(request, options); end

    def response(fields = {})
      Google::Protobuf::Compiler::CodeGeneratorResponse.new(fields)
    end

    def file(fields = {})
      Google::Protobuf::Compiler::CodeGeneratorResponse::File.new(fields)
    end

    def decode_request(bytes)
      Google::Protobuf::Compiler::CodeGeneratorRequest.decode(bytes)
    end

    def parse_options(request)
      pairs = request.parameter.split(',')
      pairs.to_h do |s|
        key, value = s.split('=', 2)
        [key.strip.to_sym, value]
      end
    end
  end
end
