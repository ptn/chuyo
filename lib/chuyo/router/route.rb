require_relative 'route/app_route'
require_relative 'route/controller_route'

module Chuyo
  class Router
    class Route
      attr_reader :regexp, :defaults, :methods

      def self.for(url, app_spec, opts)
        if app_spec.respond_to? :call
          AppRoute.new(url, app_spec, opts)
        else
          ControllerRoute.new(url, app_spec, opts)
        end
      end

      def initialize(url, app_spec, opts)
        @regexp = build_regexp(url)
        @defaults = opts[:defaults]
        @methods = opts[:via]
        post_initialize(url, app_spec, opts)
      end

      def post_initialize(url, app_spec, opts);end

      def match(request)
        return unless methods_match?(request.request_method)
        match_data = regexp_match?(request.path_info)
        app(request, match_data) if match_data
      end

      def app(match_data)
        raise NotImplementedError
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
    end
  end
end
