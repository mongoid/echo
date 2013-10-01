class Pet
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
end
