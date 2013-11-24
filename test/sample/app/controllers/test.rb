require_relative 'base'

module Sample
  module Controllers
    class Test < Base
      def act
        response body: 'done'
      end

      def template
        render :test, name: 'chuyo'
      end

      def manual_redirect
        response status: 302,
          headers: { 'Location' => '/test/redirected' }
      end

      def redirect_to_url
        redirect_to url: '/test/redirected'
      end

      def redirect_to_controller
        redirect_to controller: :home
      end

      def redirect_to_action
        redirect_to action: :redirected
      end

      def redirect_to_controller_and_action
        redirect_to controller: :home, action: :index
      end

      def redirected
        response body: 'redirected'
      end

      def empty_redirect
        redirect_to
      end

      def bad_redirect
        redirect_to nope: :nope
      end
    end
  end
end
