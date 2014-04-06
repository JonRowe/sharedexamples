require 'dotenv'
Dotenv.load

set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'

activate :sprockets
activate :directory_indexes

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :cache_buster
  activate :smusher #compressed PNG files
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

activate :sync do |sync|
  sync.fog_provider          = 'AWS'
  sync.fog_region            = ENV['S3_REGION']
  sync.fog_directory         = ENV.fetch('TARGET',ENV['S3_BUCKET'])
  sync.aws_access_key_id     = ENV['S3_KEY']
  sync.aws_secret_access_key = ENV['S3_SECRET']
  sync.existing_remote_files = 'delete'
  sync.gzip_compression      = true
  sync.after_build           = false
end
