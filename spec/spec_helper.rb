require "rubygems"

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each{ |f| require f }

ECHO_USER = Mongo::Auth::User.new(
  database: Mongo::Database::ADMIN,
  user: 'echo-user',
  password: 'password',
  roles: [
    Mongo::Auth::Roles::USER_ADMIN_ANY_DATABASE,
    Mongo::Auth::Roles::DATABASE_ADMIN_ANY_DATABASE,
    Mongo::Auth::Roles::READ_WRITE_ANY_DATABASE,
    Mongo::Auth::Roles::HOST_MANAGER
  ]
)

RSpec.configure do |config|

  config.before(:suite) do
    client = Mongo::Client.new(["127.0.0.1:27017"])
    begin
      # Create the root user administrator as the first user to be added to the
      # database. This user will need to be authenticated in order to add any
      # more users to any other databases.
      client.database.users.create(ECHO_USER)
    rescue Exception => e
    end
  end

  # Clean up all collections before each spec runs.
  config.before do
    Mongoid.purge!
  end
end
