source "https://rubygems.org"

gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'

gem "carrierwave"
gem "carrierwave-mongoid", require: "carrierwave/mongoid"
gem "decent_exposure"

gem "sidekiq"

#gem "evolver", github: "mongoid/evolver"
gem "mongoid", github: "mongoid/mongoid"
gem "kiqstand", github: "mongoid/kiqstand"

#
# Front-End Infrastructure
#
gem 'backbone-on-rails'
gem 'jquery-rails'
gem 'rack-iframe-transport'
gem 'mimetype-fu', require: 'mimetype_fu'
gem 'haml-rails'
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'
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
