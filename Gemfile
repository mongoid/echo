source "https://rubygems.org"

gem 'rails', "~> 4.0.2"

gem "carrierwave"
gem "carrierwave-mongoid", require: "carrierwave/mongoid"
gem "decent_exposure"

gem "sidekiq"

gem "moped", github: "mongoid/moped"
gem "mongoid", github: "mongoid/mongoid"

gem 'mimetype-fu', require: 'mimetype_fu'

group :development, :test do
  gem "fabrication"
  gem "guard-rspec"
  gem "rspec-rails"
  gem "spork", "~> 0.9.0.rc"
end

platforms :jruby do
  gem "jruby-openssl"
end
