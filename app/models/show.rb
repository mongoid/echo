# encoding: utf-8
class Show
  include Mongoid::Document

  field :date, type: Time

  embedded_in :tour
  embeds_one :venue, validate: false

  # Shows must be on a specific date, which includes a time.
  validates :date, presence: true
end
