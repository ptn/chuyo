require_relative 'chuyo/router'

module Chuyo
  module App
    def initialize(router=Router.new, *args)
      @router = router
      appinit(*args)
    end

    def appinit(*args); end

    def call(env)
      handler = router.dispatch(env['URL_INFO'])
      request = Rack::Request.new(env)
      handler.call(request)
    end

    private

    attr_reader :router
  end
end
