module Chuyo
  class Router
    class Route
      attr_reader :regexp, :defaults, :methods

      def initialize(url, handler_spec, opts)
        @regexp = build_regexp(url)
        @defaults = opts[:defaults]
        @methods = opts[:via]
        @controller, @action = handler_spec.split("#")
      end

      def match(request)
        return unless methods_match?(request.request_method)

        match_data = regexp_match?(request.path_info)
        if match_data
          controller, action = get_controller_and_action(match_data)
          handler = controller.new(request, defaults)
          handler.action(action)
        end
      end

      private

      def build_regexp(url)
        url += '/' unless url[-1] == '/'

        # Replace :param with (?<param>.+?(?=/)), which matches:
        # 1. . - anything
        # 2. +? - one or more times, non-greedy
        # 3. (?=/) - only if it's followed by a slash
        # 4. (?<param>) - assigning the whole match to a variable called
        #                 param
        spec = url.gsub(/:(.+?)\//, '(?<\1>.+?(?=/))/')

        Regexp.new(spec)
      end

      def methods_match?(request_method)
        return true unless methods

        if methods.is_a? Array
          methods.each do |method|
            return true if method.to_s.upcase == request_method
          end
          false
        else
          return methods.to_s.upcase == request_method
        end
      end

      def regexp_match?(path)
        path += '/' unless path[-1] == '/'
        regexp.match(path)
      end

      def get_controller_and_action(match_data)
        controller = @controller ? @controller : match_data[:controller]
        controller = APPNAME + '::Controllers::' + controller.capitalize
        controller = Object.const_get(controller)

        action = @action if @action
        unless action
          begin
            action = match_data[:action]
          rescue IndexError
            action = 'index' unless action
          end
        end

        [controller, action]
      end
    end
  end
end
