module Prototk
  class Runner
    def run(*args)
      puts(args.join(' '))
      unless system(*args)
        raise Prototk::Error, "Command execution failed"
      end
    end
  end
end
