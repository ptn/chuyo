module Chuyo
  module Controller
    RedirectError = Class.new(RuntimeError)

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def not_found
        proc do
          [404, { 'Content-Type' => 'text/plain' }, ['Not Found']]
        end
      end
    end

    def initialize(request, *args)
      @request = request
      controllerinit(*args)
    end

    def controllerinit(*args); end

    def params
      request.params
    end

    def action(name)
      proc { self.public_send(name) }
    end

    def response(opts={})
      @response if @response
      opts = default_response_opts.merge(opts)
      @response = Rack::Response.new(opts[:body], opts[:status], opts[:headers])
    end

    private

    attr_reader :request

    def render(name, locals)
      body = render_template(name, locals)
      response({ body: body })
    end

    def redirect_to(opts)
      location = ''
      if opts[:url]
        location = opts[:url]
      elsif opts[:controller]
        if opts[:action]
          location = "/#{opts[:controller]}/#{opts[:action]}"
        else
          location = "/#{opts[:controller]}"
        end
      elsif opts[:action]
        this = Utils.class_snake_name(self.class.name)
        location = "/#{this}/#{opts[:action]}"
      else
        raise RedirectError, "Nowhere to redirect"
      end

      response status: 302,
               headers: { 'Location' => location }
    end

    def render_template(name, locals)
      dir = Utils.class_snake_name(self.class.name)
      file = File.join('app', 'views', dir, "#{name}.html.erb")
      src = File.read(file)
      template = Erubis::Eruby.new(src)
      template.result(locals)
    end

    def default_response_opts
      {
        body: [],
        status: 200,
        headers: {
          'Content-Type' => 'text/html',
        },
      }
    end
  end
end
