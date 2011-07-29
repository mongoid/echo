require File.expand_path("../boot", __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Echo
  class Application < Rails::Application

    # Add additional load paths for your own custom dirs.
    config.autoload_paths += %W(#{config.root}/app/services)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Fabrication setup for model generation to create the fabricators.
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :fabrication
    end

    # Setup the Mongoid observers here.
    config.mongoid.observers = :band_observer, :following_observer, :role_observer
  end
end
