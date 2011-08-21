require "padrino-core/application/rendering"

# Custom Renderers
module Middleman
  module Rendering
    autoload :Haml,         "middleman-rendering/haml"
    autoload :Sass,         "middleman-rendering/sass"
    autoload :Slim,         "middleman-rendering/slim"
    autoload :Markdown,     "middleman-rendering/markdown"
    autoload :CoffeeScript, "middleman-rendering/coffee_script"
    autoload :Compass,      "middleman-rendering/compass"
    
    class << self
      def registered(app)
        # Tilt-aware renderer
        app.register Padrino::Rendering

        # Activate custom renderers
        app.register Slim
        app.register Haml
        app.register Sass
        app.register Markdown
        app.register CoffeeScript
        app.register Compass
      end
      alias :included :registered
    end
  end
end