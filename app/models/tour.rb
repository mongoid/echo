# encoding: utf-8
class Tour
  include Mongoid::Document
  include Mongoid::Timestamps::Updated

  field :name, type: String

  embedded_in :band
  embeds_many :shows, validate: false

  # Tours must have a name, obviously.
  validates :name, presence: true
end
