source "https://rubygems.org"

gem 'rails', "~> 4.0.0"
gem 'arel',  "~> 4.0.0"

gem "carrierwave"
gem "carrierwave-mongoid", require: "carrierwave/mongoid"
gem "decent_exposure"

gem "sidekiq"

gem "moped", github: "mongoid/moped"
gem "mongoid", github: "mongoid/mongoid", branch: "eager_load"
#gem "kiqstand", github: "mongoid/kiqstand"

#
# Front-End Infrastructure
#
gem 'backbone-on-rails'
gem 'jquery-rails'
gem 'rack-iframe-transport'
gem 'mimetype-fu', require: 'mimetype_fu'
gem 'haml-rails'
group :assets do
  gem 'sprockets-rails'
  gem 'sass-rails', "~> 4.0.0"
  gem 'coffee-rails', "~> 4.0.0"
  gem "uglifier"
end

group :development, :test do
  gem "fabrication"
  gem "guard-rspec"
  gem "rspec-rails"
  gem "spork", "~> 0.9.0.rc"
end

platforms :jruby do
  gem "jruby-openssl"
end
