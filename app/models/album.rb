# encoding: utf-8
class Album
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :description, type: String
  field :name, type: String
  field :released, type: Date

  belongs_to :producer, class_name: "User"

  embedded_in :band
  embeds_many :photos, as: :photographic, validate: false
  embeds_many :tracks, validate: false
  embeds_many :reviews, validate: false

  # Fields that are required in order to have a valid album.
  validates :name, presence: true

  # Gets albums produced by a specific person.
  #
  # @example Get the albums produced by a user.
  #   band.albums.produced_by(user)
  #
  # @param [ User ] producer The producer of the album.
  #
  # @return [ Array<Album> ] The matching albums.
  scope :produced_by, ->(producer) { where(producer_id: producer.id) }

  # Get the average rating of the album based on all the reviews that have been
  # made.
  #
  # @example Get the average rating.
  #   review.average_rating
  #
  # @return [ Float ] The average rating of all reviews.
  def average_rating
    reviews.avg(:rating)
  end

  # Get the total number of discs that are in the album. Delegates to the
  # tracks to figure this out.
  #
  # @example Get the total discs.
  #   album.discs
  #
  # @return [ Integer ] The number of discs in the album.
  def discs
    tracks.distinct(:disc).size
  end
end
