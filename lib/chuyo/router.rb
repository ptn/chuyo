module Chuyo
  class Router
    def dispatch(url)
      proc { |request| [200, { 'Content-Type' => 'text/html' }, ['Hi!']] }
    end
  end
end
