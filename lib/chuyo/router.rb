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
      routes << Route.for(url, handler, opts)
    end

    def dispatch(request)
      app = nil

      routes.each do |route|
        app = route.match(request)
        break if app
      end

      if app.nil?
        Chuyo::Controller::ClassMethods.not_found
      else
        app
      end
    end
  end
end
