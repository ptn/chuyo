module Chuyo
  # Given a URL, return the callable that handles it.
  class Router
    def dispatch(request)
      _, controller_name, action, after = request.path_info.split('/', 4)

      controller_name = "home" unless controller_name != ''
      controller_name = param_to_controller_name(controller_name)
      controller_klass = Object.const_get(controller_name)
      controller = controller_klass.new(request)

      action = 'index' unless action && action != ''

      controller.action(action)
    rescue NameError
      Controllers::Base.not_found
    end

    private

    def param_to_controller_name(param)
      'Controllers::' + param.capitalize
    end
  end
end
