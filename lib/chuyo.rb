require_relative 'chuyo/router'

module Chuyo
  class App
    def initialize(router=Router.new)
      @router = router
    end

    def call(env)
      handler = router.dispatch(env['URL_INFO'])
      request = Rack::Request.new(env)
      handler.call(request)
    end

    private

    attr_reader :router
  end
end
