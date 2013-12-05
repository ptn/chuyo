require_relative 'base'

module Sample
  module Controllers
    class Router < Base
      def index
        response body: 'routed to Router#index'
      end

      def both
        response body: 'routed to Router#both'
      end

      def split
        response body: 'routed to Router#split'
      end

      def with_params
        response body: "routed to Router#with_params: #{params}"
      end

      def get
        response body: 'routed to Router#get'
      end

      def post
        response body: 'routed to Router#post'
      end

      def no_DELETE
        response body: 'routed to Router#no_DELETE'
      end

      def no_2nd_param
        response body: 'routed to Router#no_2nd_param'
      end
    end
  end
end
