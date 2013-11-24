require_relative 'base'

module Sample
  module Controllers
    class Home < Base
      def index
        response body: 'Hi!'
      end
    end
  end
end
