require 'erubis'

require_relative 'chuyo/version'
require_relative 'chuyo/utils'
require_relative 'chuyo/controller'
require_relative 'chuyo/router'

module Chuyo
  module App
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def routes(&block)
        if block_given?
          @routes = block
        else
          @routes
        end
      end
    end

    attr_reader :router

    def initialize(router=Router, *args)
      @router = router.with_routes(self.class.routes)
      appinit(*args)
    end

    def appinit(*args); end

    def call(env)
      request = Rack::Request.new(env)
      handler = router.dispatch(request)
      response = handler.call(request)
      response.to_a
    end
  end
end
