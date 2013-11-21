require_relative 'base'

module Controllers
  class Test < Base
    def act
      'done'
    end

    def template
      render :test, name: 'chuyo'
    end
  end
end

