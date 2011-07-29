# encoding: utf-8
class Review
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :content, type: String
  field :rating, type: Float

  belongs_to :reviewer, class_name: "User"

  embedded_in :album

  # In order to have a valid review the review must have content and a person
  # authoring the review itself.
  validates :content, :reviewer, presence: true

  # Rating must be between 0 and 10 in order to be valid - we don't need any
  # crazy non base 10 rating system here.
  validates :rating, numericality: {
    less_than_or_equal_to: 10,
    greater_than_or_equal_to: 0
  }
end
