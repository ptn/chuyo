module Chuyo
  module Utils
    extend self

    def to_snake(string)
      string.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    def class_snake_name(name)
      full = to_snake(name)
      discard = full.rindex('/')
      if discard
        full[(discard + 1)..-1]
      else
        full
      end
    end
  end
end
