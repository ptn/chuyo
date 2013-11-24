module Chuyo
  # Given a URL, return the callable that handles it.
  class Router
    def dispatch(request)
      _, controller, action, after = request.path_info.split('/', 4)

      controller = "home" unless controller != ''
      controller = APPNAME + '::Controllers::' + controller.capitalize
      controller_klass = Object.const_get(controller)
      controller = controller_klass.new(request)

      action = 'index' unless action && action != ''

      controller.action(action)
    rescue NameError
      Chuyo::Controller::ClassMethods.not_found
    end
  end
end
