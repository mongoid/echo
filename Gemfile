source "https://rubygems.org"

gem "rails", "~> 3.2"

gem "bundler"
gem "carrierwave"
gem "carrierwave-mongoid", require: "carrierwave/mongoid"
gem "decent_exposure"
gem "haml"
gem "jquery-rails"
gem "kiqstand"
gem "sidekiq"

gem "evolver", github: "mongoid/evolver"
gem "mongoid", "~> 3.1.4"

group :assets do
  gem "sass-rails", "~> 3.2"
  gem "coffee-rails", "~> 3.2"
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
