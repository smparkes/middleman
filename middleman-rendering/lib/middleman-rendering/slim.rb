module Middleman::Rendering::Slim
  class << self
    def registered(app)
      require "slim"
    end
    alias :included :registered
  end
end