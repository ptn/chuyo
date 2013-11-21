require_relative 'base'

module Controllers
  class Home < Base
    def index
      response 'Hi!'
    end
  end
end
