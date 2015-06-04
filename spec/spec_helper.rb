require "rubygems"
require "spork"

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each{ |f| require f }

RSpec.configure do |config|
  # Clean up all collections before each spec runs.
  config.before do
    Mongoid.purge!
  end
end
