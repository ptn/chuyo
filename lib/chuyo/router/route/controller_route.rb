module Chuyo
  class Router
    class Route
      class ControllerRoute < Route
        attr_reader :controller, :action

        def post_initialize(url, app_spec, opts)
          @controller, @action = app_spec.split("#")
        end

        def app(request, match_data)
          controller = get_controller(match_data)
          action = get_action(match_data)
          url_params = get_params(match_data)

          params = defaults ? defaults.merge(url_params) : url_params
          controller = controller.new(request, params)
          controller.action(action)
        end

        private

        def get_controller(match_data)
          controller = @controller ? @controller : match_data[:controller]
          controller = APPNAME + '::Controllers::' + controller.capitalize
          Object.const_get(controller)
        end

        def get_action(match_data)
          action = @action if @action
          unless action
            begin
              action = match_data[:action]
            rescue IndexError
              action = 'index' unless action
            end
          end
          action
        end

        def get_params(match_data)
          names = match_data.names.map { |n| n.to_sym }
          params = Hash[names.zip(match_data.captures)]
          params.delete :controller
          params.delete :action
          params
        end
      end
    end
  end
end

