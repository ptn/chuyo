require_relative 'base'

module Controllers
  class Home < Base
    def index
      response body: 'Hi!'
    end
  end
end
