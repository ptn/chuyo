module Chuyo
  module Controller
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def not_found
        proc do
          [404, { 'Content-Type' => 'text/plain' }, ['Not Found']]
        end
      end

      def snake_name
        Utils.to_snake(name)
      end
    end

    def initialize(request, *args)
      @request = request
      controllerinit(*args)
    end

    def controllerinit(*args); end

    def action(name)
      text = proc do
        text = self.public_send(name)
        [200, { 'Content-Type' => 'text/html' }, [text]]
      end
    end

    def render(name, locals)
      # example snake_name: controllers_test
      # 11..-1 removes 'controllers_'
      dir = self.class.snake_name[11..-1]
      file = File.join('app', 'views', dir, "#{name}.html.erb")
      src = File.read(file)
      template = Erubis::Eruby.new(src)
      template.result(locals)
    end

    private

    attr_reader :request
  end
end
