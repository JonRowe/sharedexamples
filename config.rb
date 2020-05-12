require 'dotenv'
Dotenv.load

set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'

activate :directory_indexes

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
end

module ::Rails
  module Railtie
  end
  class Engine
    def self.engine_name whatever
    end
    def self.initializer *whatever
    end
  end
  def self.root
    Pathname.new File.expand_path('../', __FILE__)
  end
end
