# encoding: utf-8
class Venue
  include Mongoid::Document

  field :name, type: String
  field :location, type: Array, default: []

  embedded_in :show
  embeds_one :address, as: :addressable, validate: false

  # Venues must have a name, address right now is optional.
  validates :name, presence: true
end
