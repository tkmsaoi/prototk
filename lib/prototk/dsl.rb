module Prototk
  class DSL
    class << self
      def eval(code, filename, lineno=1)
        self.new.instance_eval(code, filename, lineno)
      end
    end

    def configure
      config = Config.new
      yield config if block_given?
      config
    end
  end
end
