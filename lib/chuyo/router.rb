require_relative 'router/route'

module Chuyo
  # Given a URL, return the callable that handles it.
  class Router
    attr_reader :routes

    def initialize
      @routes = []
    end

    def self.with_routes(routes)
      router = new
      router.instance_eval(&routes)
      router
    end

    def route(url, handler='', opts={})
      routes << Route.new(url, handler, opts)
    end

    def dispatch(request)
      handler = nil

      routes.each do |route|
        handler = route.match(request)
        break if handler
      end

      if handler.nil?
        Chuyo::Controller::ClassMethods.not_found
      else
        handler
      end
    end
  end
end
