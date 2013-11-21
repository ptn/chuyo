module Chuyo
  # Given a URL, return the callable that handles it.
  class Router
    def dispatch(request)
      _, controller_name, action, after = request.path_info.split('/', 4)

      controller_name = "home" unless controller_name != ''
      controller_name = controller_name.capitalize
      controller_klass = Object.const_get('Controllers::' + controller_name)
      controller = controller_klass.new(request)

      action = 'index' unless action && action != ''

      controller.action(action)
    rescue NameError
      Controllers::Base.not_found
    end
  end
end
