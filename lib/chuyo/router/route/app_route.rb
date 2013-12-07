module Chuyo
  class Router
    class Route
      class AppRoute < Route
        def post_initialize(url, app_spec, opts)
          @app = app_spec
        end

        def app(request, match_data)
          @app
        end
      end
    end
  end
end
