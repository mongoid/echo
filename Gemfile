source "http://rubygems.org"

ruby "1.9.3"

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
gem "mongoid", github: "mongoid/mongoid"
gem "moped", github: "mongoid/moped"
gem "origin", github: "mongoid/origin"

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
