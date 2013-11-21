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

    private

    attr_reader :request
  end
end
