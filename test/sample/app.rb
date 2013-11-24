require '../../lib/chuyo'
require_relative 'app/controllers/home'
require_relative 'app/controllers/test'

Chuyo::APPNAME = 'Sample'

module Sample
  class App
    include Chuyo::App
  end
end
