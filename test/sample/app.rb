require '../../lib/chuyo'
require_relative 'app/controllers/home'
require_relative 'app/controllers/test'
require_relative 'app/controllers/router'

Chuyo::APPNAME = 'Sample'

module Sample
  class App
    include Chuyo::App
  end
end

Sample::App.routes do
  # Routing
  # Specify both controller and action in the 2nd param
  route '/router/both', 'router#both'
  # No action specified, use the default
  route '/only/controller', 'router'
  # # Split specification: action in 1st param, controller in 2nd
  # route '/router/:action', 'router'
  # # Everything in the 1st param
  # route '/:controller/:action'
  # To a different Rack app
  route '/mounted/', proc { |env|
    [200, { 'Content-Type' => 'text/html' }, ["mounted app"]]
  }

  # Parameters
  route '/router/params/:id/:p1/:p2', 'router#with_params',
        defaults: { p3: 'p3' }

  # Constraints
  route '/router/get', 'router#get', via: :get
  route '/router/post', 'router#post', via: :post
  route '/router/no_DELETE', 'router#no_DELETE', via: [:get, :post]
end
