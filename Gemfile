source "https://rubygems.org"

gem 'rails', "~> 4.2"

gem "carrierwave"
gem "carrierwave-mongoid", require: "carrierwave/mongoid"
gem "decent_exposure"

gem "mongoid", github: "mongoid/mongoid"

gem 'mimetype-fu', require: 'mimetype_fu'

group :development, :test do
  gem "fabrication"
  gem "guard-rspec"
  gem "rspec-rails"
end

platforms :jruby do
  gem "jruby-openssl"
end
