require File.expand_path("../boot", __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(assets: %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Echo
  class Application < Rails::Application
    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Add additional load paths for your own custom dirs.
    config.autoload_paths += %W(#{config.root}/app/services)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.generators do |g|
      g.fixture_replacement :fabrication
      g.orm             :mongoid
      g.test_framework  :rspec
      g.template_engine :haml
    end

    # Setup the Mongoid observers here.
    config.mongoid.observers = :band_observer, :following_observer, :role_observer
  end
end
