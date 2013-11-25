require File.expand_path("../boot", __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Echo
  class Application < Rails::Application


    # Enable the asset pipeline.
    config.assets.enabled = true

    # Add additional load paths for your own custom dirs.
    config.autoload_paths += %W(#{config.root}/app/services lib)

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
  end
end
