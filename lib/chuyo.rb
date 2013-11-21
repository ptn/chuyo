require_relative 'chuyo/controller'
require_relative 'chuyo/router'

module Chuyo
  module App
    def initialize(router=Router.new, *args)
      @router = router
      appinit(*args)
    end

    def appinit(*args); end

    def call(env)
      request = Rack::Request.new(env)
      handler = router.dispatch(request)
      handler.call(request)
    end

    private

    attr_reader :router
  end
end
