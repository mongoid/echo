# encoding: utf-8
class Address
  include Mongoid::Document

  field :extra, type: String
  field :city, type: String
  field :country, type: String
  field :postcode, type: String
  field :state, type: String
  field :street, type: String

  embedded_in :addressable, polymorphic: true

  # These are the minimum required fields in order to say we have a valid
  # address - anything else is a bonus.
  validates :city, :country, :postcode, :street, presence: true
end
