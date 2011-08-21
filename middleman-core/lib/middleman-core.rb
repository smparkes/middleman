# Middleman is a static site renderer that provides all the conveniences of
# a modern web stack, like Ruby on Rails, while remaining focused on building
# the fastest, most-professional sites possible
#
# Install Middleman:
#
#     gem install middleman
#
# To accomplish its goals, Middleman supports provides access to:
# 
#### Command-line tool:
# * **middleman init**: A tool for creating to new static sites.
# * **middleman server**: A tool for rapidly developing your static site.
# * **middleman build**: A tool for exporting your site into optimized HTML, CSS & JS.
#
#### Tons of templating languages including:
# * ERB                        (.erb)
# * Interpolated String        (.str)
# * Sass                       (.sass)
# * Scss                       (.scss)
# * Haml                       (.haml)
# * Slim                       (.slim)
# * Less CSS                   (.less)
# * Builder                    (.builder)
# * Liquid                     (.liquid)
# * RDiscount                  (.markdown)
# * RedCloth                   (.textile)
# * RDoc                       (.rdoc)
# * Radius                     (.radius)
# * Markaby                    (.mab)
# * Nokogiri                   (.nokogiri)
# * Mustache                   (.mustache)
# * CoffeeScript               (.coffee)
#
#### Compile-time Optimiztions
# * Javascript Minifiers: YUI, Google Closure & UglifyJS
# * Smush.it Image Compression
# * CSS Minification
#
#### Robust Extensions:
# Add your own runtime and build-time features!
#
#### Next Steps:
# * [Visit the website]
# * [Read the wiki]
# * [Email the users group]
# * [Submit bug reports]
#
# [Visit the website]:     http://middlemanapp.com
# [Read the wiki]:         https://github.com/tdreyno/middleman-core/wiki
# [Email the users group]: http://groups.google.com/group/middleman-users
# [Submit bug reports]:    https://github.com/tdreyno/middleman-core/issues

# Setup our load paths
libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

# We're riding on Sinatra, so let's include it.
require "sinatra/base"

# Top-level Middleman object
module Middleman
  # Auto-load modules on-demand
  autoload :Base,      "middleman-core/base"
  autoload :Builder,   "middleman-core/builder"
  autoload :CLI,       "middleman-core/cli"
  autoload :Templates, "middleman-core/templates"
  autoload :Guard,     "middleman-core/guard"
  
  module CoreExtensions
    # Add Builder callbacks
    autoload :Builder,       "middleman-core/core_extensions/builder"
    
    # Add Rack::Builder.map support
    autoload :RackMap,       "middleman-core/core_extensions/rack_map"
    
    # Custom Feature API
    autoload :Features,      "middleman-core/core_extensions/features"
  
    # Asset Path Pipeline
    autoload :Assets,        "middleman-core/core_extensions/assets"
  
    # Data looks at the data/ folder for YAML files and makes them available
    # to dynamic requests.
    autoload :Data,           "middleman-core/core_extensions/data"
    
    # Parse YAML from templates
    autoload :FrontMatter,    "middleman-core/core_extensions/front_matter"
    
    # Sprockets 2
    autoload :Sprockets,       "middleman-core/core_extensions/sprockets"
  
    # Pass custom options to views
    autoload :Routing,        "middleman-core/core_extensions/routing"
  end

  module Features
    # RelativeAssets allow any asset path in dynamic templates to be either
    # relative to the root of the project or use an absolute URL.
    autoload :RelativeAssets,      "middleman-core/features/relative_assets"

    # AssetHost allows you to setup multiple domains to host your static
    # assets. Calls to asset paths in dynamic templates will then rotate
    # through each of the asset servers to better spread the load.
    autoload :AssetHost,           "middleman-core/features/asset_host"

    # CacheBuster adds a query string to assets in dynamic templates to avoid
    # browser caches failing to update to your new content.
    autoload :CacheBuster,         "middleman-core/features/cache_buster"

    # AutomaticImageSizes inspects the images used in your dynamic templates
    # and automatically adds width and height attributes to their HTML
    # elements.
    autoload :AutomaticImageSizes, "middleman-core/features/automatic_image_sizes"

    # MinifyCss uses the YUI compressor to shrink CSS files
    autoload :MinifyCss,           "middleman-core/features/minify_css"

    # MinifyJavascript uses the YUI compressor to shrink JS files
    autoload :MinifyJavascript,    "middleman-core/features/minify_javascript"

    # Lorem provides a handful of helpful prototyping methods to generate
    # words, paragraphs, fake images, names and email addresses.
    autoload :Lorem,               "middleman-core/features/lorem"
    
    # Automatically convert filename.html files into filename/index.html
    autoload :DirectoryIndexes,    "middleman-core/features/directory_indexes"
  end
  
  EXTENSION_FILE = "middleman_init.rb"
  def self.load_extensions_in_path
    # If newer Rubygems
    extensions = if Gem::Specification.respond_to? :select
      ::Gem::Specification.select do |spec| 
        spec.contains_requirable_file?(EXTENSION_FILE)
      end
    else
      ::Gem::GemPathSearcher.new.find_all(EXTENSION_FILE)
    end
    
    extensions.each do |spec|
      require spec.name
      # $stderr.puts "require: #{spec.name}"
    end
  end
  
  def self.server(&block)
    sandbox = Class.new(Sinatra::Base)
    sandbox.register Base
    sandbox.class_eval(&block) if block_given?
    sandbox
  end
  
  def self.start_server(options={})
    opts = {
      :Port      => options[:port],
      :AccessLog => []
    }
    
    app = ::Middleman.server
    app.set :environment, options[:environment].to_sym
    opts[:app] = app.new
    opts[:server] = 'thin'

    $stderr.puts "== The Middleman is standing watch on port #{opts[:Port]}"
    ::Rack::Server.new(opts).start
  end
end

require "middleman-core/version"
Middleman.load_extensions_in_path